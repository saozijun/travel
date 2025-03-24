<template>
  <a-modal
    v-model:open="visible"
    :title="modelRef.id ? '编辑' : '新增'"
    :confirm-loading="confirmLoading"
    width="40%"
    @ok="handleOk"
    destroyOnClose
    :afterClose="afterClose"
  >
    <a-form name="form" :model="modelRef" :label-col="{style:{width: '80px'}}">
      <a-form-item label="景区名称" v-bind="validateInfos.name">
        <a-input v-model:value="modelRef.name" placeholder="请输入"/>
      </a-form-item>
      <a-form-item label="开放时间" v-bind="validateInfos.openingHours">
        <a-time-range-picker v-model:value="modelRef.openingHours" format="HH:mm" valueFormat="HH:mm"/>
      </a-form-item>
      <a-form-item label="门票价格" v-bind="validateInfos.ticketPrice">
        <a-input-number v-model:value="modelRef.ticketPrice" prefix="￥" style="width: 100%" />
      </a-form-item>
      <a-form-item label="景区评分" v-bind="validateInfos.rate">
        <a-rate v-model:value="modelRef.rate" />
      </a-form-item>
      <a-form-item label="联系电话" v-bind="validateInfos.contactPhone">
        <a-input v-model:value="modelRef.contactPhone" style="width: 100%" placeholder="请输入" />
      </a-form-item>
      <a-form-item label="详细地址" v-bind="validateInfos.address">
        <a-input v-model:value="modelRef.address" placeholder="请输入或通过地图选点获取" />
      </a-form-item>
      <a-form-item label="地理位置">
        <div class="map-container">
          <div class="map-info">
            <p v-if="modelRef.locations" >经纬度: {{ modelRef.locations }}</p>
            <a-button type="primary" @click="openMapPicker">选择位置</a-button>
          </div>
        </div>
      </a-form-item>
      <a-form-item label="景区描述" v-bind="validateInfos.description">
        <a-textarea v-model:value="modelRef.description" placeholder="请输入" />
      </a-form-item>
      <a-form-item label="景区图片" v-bind="validateInfos.imageUrl">
        <div class="image-uploader">
          <div class="preview-image" v-if="modelRef.imageUrl">
            <a-image :src="modelRef.imageUrl" :width="150" :height="150" />
            <div class="image-actions">
              <a-space>
                <a-button type="link" danger @click="removeImage">
                  <delete-outlined />
                </a-button>
              </a-space>
            </div>
          </div>
          <a-upload
            v-else
            name="file"
            :action="baseUrl + '/file/upload'"
            :show-upload-list="false"
            @change="handleImageChange"
            :accept="'.jpg,.jpeg,.png,.gif'"
            :beforeUpload="beforeUpload"
          >
            <a-button type="dashed" class="upload-button">
              <upload-outlined />
              <span>上传图片</span>
            </a-button>
          </a-upload>
        </div>
      </a-form-item>
    </a-form>
  </a-modal>
  
  <!-- 地图选点弹窗 -->
  <a-modal
    v-model:open="mapVisible"
    title="选择位置"
    width="800px"
    :zIndex="1200"
    @ok="confirmMapLocation"
    @cancel="cancelMapLocation"
  >
    <div id="map-picker" style="height: 300px;"></div>
    <div class="point-data">
      <div class="point-info">
        <p>地址: {{ tempLocation.address || '未选择' }}</p>
        <p v-if="tempLocation.locations">
          经纬度: {{ tempLocation.locations }}
        </p>
      </div>
    </div>
    <div class="map-search" style="margin-top: 10px;">
      <a-input-search
        v-model:value="searchKeyword"
        placeholder="搜索地点"
        enter-button
        @search="searchLocation"
      />
      <div v-if="searchResults.length > 0" class="search-results">
        <a-list size="small">
          <a-list-item v-for="(item, index) in searchResults" :key="index" @click="selectSearchResult(item)">
            {{ item.name }} - {{ item.address }}
          </a-list-item>
        </a-list>
      </div>
    </div>
  </a-modal>
</template>
<script setup>
import { ref, reactive, onMounted, nextTick } from "vue";
import { Form, message } from 'ant-design-vue';
import { save } from '~/api/scenic'
import AMapLoader from '@amap/amap-jsapi-loader';
import { UploadOutlined, DeleteOutlined } from "@ant-design/icons-vue";

const useForm = Form.useForm;
const visible = ref(false);
const imgVisible = ref(false);
const confirmLoading = ref(false);
const emits = defineEmits(["saveOk"]);
const baseUrl = import.meta.env.VITE_APP_BASE_URL;

const modelRef = reactive({
  name: "",
  description: "",
  openingHours: "",
  ticketPrice: null,
  contactPhone: null,
  address: "",
  locations: null,
  imageUrl: "",
  rate: 0
});

// 地图相关变量
const mapVisible = ref(false);
const map = ref(null);
const marker = ref(null);
const searchKeyword = ref('');
const searchResults = ref([]);

// 高德地图配置
const MAP_KEY = 'ec1cc8fead3b82b6798ba07768c1a3e3'; // 用于加载地图
const WEB_SERVICE_KEY = '6ede2de34b2ec9fe711c87e06b5d16a7'; // 用于地理编码和搜索服务
const MAP_PLUGINS = ['AMap.Geocoder', 'AMap.PlaceSearch'];

// 添加临时存储变量
const tempLocation = ref({
  address: '',
  locations: null
});

const afterClose = () => {
  resetFields(); 
};

// 修改表单验证规则的定义方式
const rulesRef = reactive({
  name: [{ required: true, message: '请输入名称'}],
  description: [{ required: true, message: '请输入描述'}],
  address: [{ required: true, message: '请输入详细地址'}],
  ticketPrice: [{ required: true, message: '请输入门票价格'}],
  imageUrl: [{ required: true, message: '请上传景区图片'}],
  openingHours: [{ required: true, message: '请选择开放时间'}],
  contactPhone: [{ required: true, message: '请输入联系电话'}],
  rate: [{ required: true, message: '请选择景区评分'}],
});

// 修改 useForm 的使用方式
const { resetFields, validate, validateInfos } = useForm(modelRef, rulesRef);

// 初始化地图选点
const initMapPicker = async () => {
  try {
    if (!window.AMap) {
      window.AMap = await AMapLoader.load({
        key: MAP_KEY,
        version: '2.0',
        plugins: MAP_PLUGINS
      });
    }
    
    // 创建地图实例
    map.value = new AMap.Map('map-picker', {
      zoom: 13,
      center: [110.186956, 25.235479]  // 使用默认坐标
    });
    
    // 添加点击事件
    map.value.on('click', (e) => {
      const lnglat = e.lnglat;
      updateMarker(lnglat);
      getAddress(lnglat);
    });
    
    // 如果已有坐标，立即添加标记
    if (modelRef.locations) {
      nextTick(() => {
        let [lng, lat] = modelRef.locations.split(',');
        updateMarker([lng, lat]);
      });
    }
  } catch (error) {
    message.error('地图加载失败: ' + error.message);
  }
};

// 更新标记点
const updateMarker = (lnglat) => {
  if (marker.value) {
    marker.value.setPosition(lnglat);
  } else {
    marker.value = new AMap.Marker({
      position: lnglat,
      draggable: true,
      map: map.value
    });
    
    // 拖拽结束后获取地址
    marker.value.on('dragend', (e) => {
      getAddress(e.target.getPosition());
    });
  }
};

// 根据坐标获取地址
const getAddress = async (lnglat) => {
  try {
    const lng = typeof lnglat.getLng === 'function' ? lnglat.getLng() : lnglat[0];
    const lat = typeof lnglat.getLat === 'function' ? lnglat.getLat() : lnglat[1];
    
    const response = await fetch(
      `https://restapi.amap.com/v3/geocode/regeo?key=${WEB_SERVICE_KEY}&location=${lng},${lat}&extensions=base`
    );
    const result = await response.json();
    
    if (result.status === '1') {
      const address = result.regeocode.formatted_address;
      tempLocation.value = {
        address,
        locations: lng + ',' + lat
      };
    } else {
      console.error('获取地址失败:', result);
      message.error(`获取地址失败: ${result.info || '未知错误'}`);
    }
  } catch (error) {
    console.error('地理编码异常:', error);
    message.error(`地理编码异常: ${error.message}`);
  }
};

// 搜索位置
const searchLocation = async () => {
  if (!searchKeyword.value) return;
  
  try {
    const response = await fetch(
      `https://restapi.amap.com/v3/place/text?key=${WEB_SERVICE_KEY}&keywords=${encodeURIComponent(searchKeyword.value)}&city=全国`
    );
    const result = await response.json();
    
    if (result.status === '1') {
      searchResults.value = result.pois;
    } else {
      console.error('搜索位置失败:', result);
      message.error(`搜索位置失败: ${result.info || '未知错误'}`);
      searchResults.value = [];
    }
  } catch (error) {}
};

// 选择搜索结果
const selectSearchResult = (item) => {
  const [lng, lat] = item.location.split(',');
  const lnglat = new AMap.LngLat(parseFloat(lng), parseFloat(lat));
  map.value.setCenter(lnglat);
  updateMarker(lnglat);
  // 存储到临时变量中
  tempLocation.value = {
    address: item.pname + item.cityname + item.adname + item.name,
    locations: lng + ',' + lat
  };
  searchResults.value = [];
  searchKeyword.value = '';
};

// 确认地图选点
const confirmMapLocation = () => {
  if (!tempLocation.value.locations) {
    message.warning('请先在地图上选择位置');
    return;
  }
  // 更新到 modelRef (不需要 .value)
  modelRef.address = tempLocation.value.address;
  modelRef.locations = tempLocation.value.locations;
  
  mapVisible.value = false;
  if (map.value) {
    map.value.destroy();
    map.value = null;
  }
  if (marker.value) {
    marker.value = null;
  }
};

// 取消地图选点
const cancelMapLocation = () => {
  mapVisible.value = false;
  // 清理地图实例
  if (map.value) {
    map.value.destroy();
    map.value = null;
  }
  if (marker.value) {
    marker.value = null;
  }
};

// 修改提交处理函数
const handleOk = async () => {
  try {
    await validate();
    confirmLoading.value = true;
    let tempData = {...modelRef};  // 不需要 .value
    
    if (Array.isArray(tempData.openingHours)) {
      tempData.openingHours = tempData.openingHours.join('-');
    }
    await save(tempData);
    message.success('操作成功');
    emits('saveOk');
    confirmLoading.value = false;
    visible.value = false;
  } catch (error) {
    confirmLoading.value = false;
  }
};

const open = (row) => {
  // 使用 Object.assign 重置和填充数据
  Object.assign(modelRef, {
    name: "",
    description: "",
    openingHours: "",
    ticketPrice: null,
    contactPhone: null,
    address: "",
    locations: null,
    imageUrl: "",
    rate: 0
  }, row);
  
  if (modelRef.openingHours) {
    modelRef.openingHours = modelRef.openingHours.split('-');
  }
  visible.value = true;
};

defineExpose({
  open,
});

// 打开地图选点弹窗
const openMapPicker = () => {
  // 打开地图时，初始化临时变量
  tempLocation.value = {
    address: modelRef.address,
    locations: modelRef.locations
  };
  mapVisible.value = true;
  nextTick(() => {
    initMapPicker();
  });
};

// 处理图片上传
const handleImageChange = (info) => {
  if (info.file.status === "done") {
    message.success(`图片上传成功`);
    modelRef.imageUrl = info.file.response;  // 移除 .value
  } else if (info.file.status === "error") {
    message.error(`图片上传失败`);
  }
};

// 删除图片
const removeImage = () => {
  modelRef.imageUrl = "";  // 移除 .value
};

const beforeUpload = (file) => {
  const isImage = file.type.startsWith('image/');
  const isLt10M = file.size / 1024 / 1024 < 10;

  if (!isImage) {
    message.error('只能上传图片文件!');
    return false;
  }
  if (!isLt10M) {
    message.error('图片必须小于 10MB!');
    return false;
  }
  return true;
};
</script>
<style lang="less" scoped>
.ant-form{
  margin-top: 20px;
}

.map-container {
  display: flex;
  flex-direction: column;
  
  .map-info {
    display: flex;
    align-items: center;
    
    p {
      margin-right: 20px;
      margin-bottom: 0;
    }
  }
}
.point-info{
  margin-top: 10px;
  p{
    margin-bottom: 0;
    font-size: 12px;
    color: #666;
  }
}
.search-results {
  max-height: 200px;
  overflow-y: auto;
  margin-top: 10px;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  
  .ant-list-item {
    cursor: pointer;
    
    &:hover {
      background-color: #f0f0f0;
    }
  }
}

.image-uploader {
  .preview-image {
    position: relative;
    width: 150px;
    height: 150px;
    border-radius: 4px;
    overflow: hidden;
    
    &:hover .image-actions {
      opacity: 1;
    }
    
    .image-actions {
      width: 50px;
      position: absolute;
      top: 0;
      right: 0;
      padding: 4px 8px;
      text-align: center;
      opacity: 0;
      transition: opacity 0.3s;
      
      .ant-btn {
        color: #fff;
        
        &:hover {
          &.ant-btn-dangerous {
            color: #ff4d4f;
          }
        }
      }
    }
  }
  
  .upload-button {
    width: 150px;
    height: 150px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    
    .anticon {
      font-size: 24px;
      margin-bottom: 8px;
    }
  }
}
</style>