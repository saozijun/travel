<template>
  <a-modal
    v-model:open="visible"
    :title="modelRef.id ? '编辑' : '新增'"
    :confirm-loading="confirmLoading"
    width="40%"
    @ok="handleOk"
    :afterClose="afterClose"
  >
    <a-form name="form" :model="modelRef" :label-col="{style:{width: '80px'}}">
      <a-form-item label="路线名称" v-bind="validateInfos.name">
        <a-input v-model:value="modelRef.name" placeholder="请输入"/>
      </a-form-item>

      <a-form-item label="所属景区" v-bind="validateInfos.scenicId">
        <a-select
          v-model:value="modelRef.scenicId"
          placeholder="请选择所属景区"
          :options="scenicList"
          :field-names="{
            label: 'name',
            value: 'id'
          }"
        />
      </a-form-item>

      <a-form-item label="路线图片" v-bind="validateInfos.imageUrl">
        <div class="image-uploader">
          <div class="preview-image" v-if="modelRef.imageUrl">
            <a-image :src="modelRef.imageUrl" :width="120" :height="120" />
            <div class="image-actions">
              <a-space>
                <a-button style="padding: 2px 6px;" type="link" danger @click="removeImage">
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

      <a-form-item label="路线描述" v-bind="validateInfos.description">
        <a-textarea 
          v-model:value="modelRef.description" 
          placeholder="请输入"
          :rows="4"
        />
      </a-form-item>

      <a-form-item label="路线规划" v-bind="validateInfos.routeData">
        <div class="map-container">
          <div class="route-controls">
            <a-space>
              <a-button type="primary" @click="openRoutePicker">
                {{ modelRef.routeData ? '修改路线' : '规划路线' }}
              </a-button>
            </a-space>
          </div>
          <div v-if="modelRef.routeData" class="route-info">
            <p>起点: {{ JSON.parse(modelRef.routeData).startAddress }}</p>
            <p>终点: {{ JSON.parse(modelRef.routeData).endAddress }}</p>
          </div>
        </div>
      </a-form-item>
    </a-form>

    <!-- 路线规划弹窗 -->
    <a-modal
      v-model:open="routeVisible"
      title="路线规划"
      width="1000px"
      @ok="confirmRoute"
      @cancel="cancelRoute"
      destroyOnClose
    >
      <div class="route-header">
        <a-radio-group v-model:value="routeType" @change="onRouteTypeChange">
          <a-radio-button value="walk">步行路线</a-radio-button>
          <a-radio-button value="drive">驾车路线</a-radio-button>
        </a-radio-group>
        <span class="route-tip">点击地图选择起点和终点</span>
      </div>
      <div class="route-container">
        <div id="route-picker" class="route-picker"></div>
        <div id="route-panel" style="height: 30%;" class="route-panel"></div>
      </div>
    </a-modal>
  </a-modal>
</template>
<script setup>
import { ref, reactive, onMounted, nextTick, watch } from "vue";
import { Form, message } from 'ant-design-vue';
import { save } from '~/api/route'
import { PlusOutlined, DeleteOutlined, UploadOutlined } from '@ant-design/icons-vue';
import AMapLoader from '@amap/amap-jsapi-loader';

const baseUrl = import.meta.env.VITE_APP_BASE_URL;
const useForm = Form.useForm;
const visible = ref(false);
const confirmLoading = ref(false);
const map = ref(null);
const emits = defineEmits(["saveOk"]);
const scenicList = ref([]);
const modelRef = ref({
  name: "",
  imageUrl: "",
  description: "",
  scenicId: undefined,
  routeData: null
})

const fileList = ref([]);

// 添加路线规划相关的响应式变量
const routeVisible = ref(false);
const routeType = ref('walk');
const routeMarkers = ref({
  start: null,
  end: null
});
const routingResult = ref(null);
const tempLocation = ref(null);

const afterClose = () => {
  resetFields();
  fileList.value = [];
};

const { resetFields, validate, validateInfos } = useForm(
  modelRef,
  reactive({
    name: [{ required: true, message: '请输入名称'}],
    scenicId: [{ required: true, message: '请选择所属景区'}],
    description: [{ required: true, message: '请输入路线描述'}],
    imageUrl: [{ required: true, message: '请上传路线图片'}],
    routeData: [{ 
      required: true, 
      validator: (_, value) => {
        if (!value) {
          return Promise.reject('请规划路线');
        }
        try {
          const routeData = JSON.parse(value);
          if (!routeData.startLocation || !routeData.endLocation) {
            return Promise.reject('请完成路线规划');
          }
          return Promise.resolve();
        } catch (error) {
          return Promise.reject('路线数据格式错误');
        }
      }
    }]
  }),
);

const handleOk = async () => {
  try {
    await validate();
    confirmLoading.value = true;
    await save(modelRef.value);
    message.success('操作成功');
    emits('saveOk');
    confirmLoading.value = false;
    visible.value = false;
  } catch (error) {
    confirmLoading.value = false;
  }
};

const open = (row, list) => {
  modelRef.value = {
    name: "",
    imageUrl: "",
    description: "",
    scenicId: undefined,
    routeData: null,
    ...row
  };
  // 获取景区下拉字典项
  scenicList.value = list;
  // 设置文件列表
  fileList.value = modelRef.value.imageUrl ? [{
    uid: '-1',
    name: 'image.png',
    status: 'done',
    url: modelRef.value.imageUrl,
  }] : [];
  
  visible.value = true;
};

defineExpose({
  open,
});

// 处理图片上传
const handleImageChange = (info) => {
  if (info.file.status === "done") {
    message.success(`图片上传成功`);
    modelRef.value.imageUrl = info.file.response;
  } else if (info.file.status === "error") {
    message.error(`图片上传失败`);
  }
};

// 上传前校验
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

// 删除图片
const removeImage = () => {
  modelRef.value.imageUrl = '';
};
// 高德地图配置
const MAP_KEY = 'ec1cc8fead3b82b6798ba07768c1a3e3'; // 用于加载地图
const WEB_SERVICE_KEY = '6ede2de34b2ec9fe711c87e06b5d16a7'; // 用于地理编码和搜索服务
const MAP_PLUGINS = ['AMap.Geocoder', 'AMap.PlaceSearch', 'AMap.Walking', 'AMap.Driving'];

// 设置安全配置
window._AMapSecurityConfig = {
  securityJsCode: "10782f5a3b5a11e72afa948b6ddcd15c",
};

// 添加路线类型切换处理函数
const onRouteTypeChange = () => {
  if (routeMarkers.value.start && routeMarkers.value.end) {
    calculateRoute();
  }
};

// 修改打开路线规划函数
const openRoutePicker = async () => {
  routeVisible.value = true;
  
  try {
    // 确保地图 API 已加载
    if (!window.AMap) {
      window.AMap = await AMapLoader.load({
        key: MAP_KEY,
        version: '2.0',
        plugins: MAP_PLUGINS
      });
    }
    
    // 使用setTimeout确保DOM已经渲染
    setTimeout(() => {
      initRoutePicker();
      // 如果已有路线数据，恢复显示并重新规划路线
      if (modelRef.value.routeData) {
        try {
          const routeData = JSON.parse(modelRef.value.routeData);
          const { startLocation, endLocation, type } = routeData;
          routeType.value = type; // 设置路线类型
          
          if (startLocation && endLocation) {
            // 添加起点和终点标记
            const [startLng, startLat] = startLocation.split(',');
            const [endLng, endLat] = endLocation.split(',');
            
            addRouteMarker('start', new window.AMap.LngLat(startLng, startLat));
            addRouteMarker('end', new window.AMap.LngLat(endLng, endLat));
            // 计算路线
            calculateRoute();
          }
        } catch (error) {
          console.error('解析路线数据失败:', error);
          message.error('路线数据格式错误');
        }
      }
    }, 100);
  } catch (error) {
    console.error('地图加载失败:', error);
    message.error('地图加载失败');
    routeVisible.value = false;
  }
};

// 修改初始化地图函数
const initRoutePicker = async () => {
  try {
    map.value = new window.AMap.Map('route-picker', {
      zoom: 13,
      center: [110.186956, 25.235479]
    });
    
    // 只在没有已存路线时显示提示
    if (!modelRef.value.routeData) {
      message.info('请点击地图选择起点');
    }
    
    // 点击地图设置起点或终点
    map.value.on('click', (e) => {
      const lnglat = e.lnglat;
      if (!routeMarkers.value.start) {
        addRouteMarker('start', lnglat);
        message.info('请点击地图选择终点');
      } else if (!routeMarkers.value.end) {
        addRouteMarker('end', lnglat);
        calculateRoute();
      }
    });
  } catch (error) {
    message.error('地图初始化失败: ' + error.message);
  }
};

// 添加路线标记
const addRouteMarker = (type, lnglat) => {
  if (routeMarkers.value[type]) {
    routeMarkers.value[type].setPosition(lnglat);
  } else {
    routeMarkers.value[type] = new AMap.Marker({
      position: lnglat,
      map: map.value,
      draggable: true,
      label: {
        content: type === 'start' ? '起点' : '终点',
        direction: 'top'
      }
    });
    
    routeMarkers.value[type].on('dragend', () => {
      if (routeMarkers.value.start && routeMarkers.value.end) {
        calculateRoute();
      }
    });
  }
  getAddress(lnglat, type);
};

// 计算路线
const calculateRoute = async () => {
  if (!routeMarkers.value.start || !routeMarkers.value.end) return;
  
  const start = routeMarkers.value.start.getPosition();
  const end = routeMarkers.value.end.getPosition();
  
  try {
    // 清除已有路线
    if (routingResult.value) {
      routingResult.value.clear();
    }
    
    // 创建路线规划实例，添加导航面板
    const router = routeType.value === 'walk' 
      ? new AMap.Walking({
          map: map.value,
          panel: 'route-panel',
          hideMarkers: true
        })
      : new AMap.Driving({
          map: map.value,
          panel: 'route-panel',
          hideMarkers: true
        });
    
    // 搜索路线
    router.search(
      [start.getLng(), start.getLat()],
      [end.getLng(), end.getLat()],
      (status, result) => {
        console.log('路线规划结果:', result);
        
        if (status === 'complete') {
          routingResult.value = router;
          const route = result.routes[0];
          
          // 使用已经通过 getAddress 获取的地址
          if (!tempLocation.value) {
            tempLocation.value = {};
          }
          
          tempLocation.value = {
            ...tempLocation.value, // 保留已获取的地址信息
            distance: (route.distance / 1000).toFixed(2),
            duration: Math.ceil(route.time / 60),
            path: route.path,
            type: routeType.value,
            steps: route.steps
          };
        } else {
          message.error('路线规划失败');
        }
      }
    );
  } catch (error) {
    message.error(`路线规划异常: ${error.message}`);
  }
};

// 修改确认路线函数
const confirmRoute = () => {
  if (!tempLocation.value || !routeMarkers.value.start || !routeMarkers.value.end) {
    message.warning('请先完成路线规划');
    return;
  }
  
  const start = routeMarkers.value.start.getPosition();
  const end = routeMarkers.value.end.getPosition();
  
  // 更新表单数据，将路线数据转换为字符串
  modelRef.value.routeData = JSON.stringify({
    ...tempLocation.value,
    startLocation: `${start.getLng()},${start.getLat()}`,
    endLocation: `${end.getLng()},${end.getLat()}`,
    type: routeType.value
  });
  
  routeVisible.value = false;
  clearRouteMap();
};

// 修改取消路线规划函数
const cancelRoute = () => {
  // 如果是修改现有路线但取消，恢复原来的路线类型
  if (modelRef.value.routeData) {
    routeType.value = JSON.parse(modelRef.value.routeData).type;
  }
  routeVisible.value = false;
  clearRouteMap();
};

// 清理地图
const clearRouteMap = () => {
  if (map.value) {
    map.value.destroy();
    map.value = null;
  }
  routeMarkers.value = { start: null, end: null };
  if (routingResult.value) {
    routingResult.value.clear();
    routingResult.value = null;
  }
  // 清空导航面板
  const panel = document.getElementById('route-panel');
  if (panel) {
    panel.innerHTML = '';
  }
};

// 获取地址信息
const getAddress = async (lnglat, type) => {
  try {
    const lng = typeof lnglat.getLng === 'function' ? lnglat.getLng() : lnglat[0];
    const lat = typeof lnglat.getLat === 'function' ? lnglat.getLat() : lnglat[1];
    
    const response = await fetch(
      `https://restapi.amap.com/v3/geocode/regeo?key=${WEB_SERVICE_KEY}&location=${lng},${lat}&extensions=base`
    );
    const result = await response.json();
    
    if (result.status === '1') {
      const address = result.regeocode.formatted_address;
      if (!tempLocation.value) {
        tempLocation.value = {};
      }
      if (type === 'start') {
        tempLocation.value.startAddress = address;
        tempLocation.value.startLocation = `${lng},${lat}`;
      } else {
        tempLocation.value.endAddress = address;
        tempLocation.value.endLocation = `${lng},${lat}`;
      }
    }
  } catch (error) {
    console.error('获取地址失败:', error);
    message.error('获取地址失败');
  }
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
    margin-top: 10px;
    display: flex;
    align-items: center;
    
    p {
      margin-right: 20px;
      margin-bottom: 0;
    }
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
  border-radius: 4px;
  overflow: hidden;
  .preview-image {
    position: relative;
    display: inline-block;
    
    .image-actions {
      position: absolute;
      top: 0;
      right: 0;
      padding: 4px;
      border-radius: 0 0 0 8px;
    }
  }
  
  .upload-button {
    width: 120px;
    height: 120px;
    
    :deep(.anticon) {
      font-size: 24px;
    }
    
    span {
      display: block;
      margin-top: 8px;
    }
  }
}

.route-controls {
  margin-bottom: 10px;
}

.route-info {
  margin-top: 10px;
  padding: 12px;
  background: #f5f5f5;
  border-radius: 4px;
  
  p {
    margin-bottom: 8px;
    font-size: 14px;
    color: #666;
    
    &:last-child {
      margin-bottom: 0;
    }
  }
}

.route-header {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
  
  .route-tip {
    margin-left: 16px;
    color: #666;
    font-size: 14px;
  }
}
:deep(.amap-call){
  display: none;
}
.route-container {
  display: flex;
  gap: 20px;
  height: 400px;
  border: 1px solid #f0f0f0;
  border-radius: 4px;
  padding: 16px;
  background: #fff;
}

.route-picker {
  flex: 1;
  height: 100%;
  border-radius: 4px;
  overflow: hidden;
}
</style>