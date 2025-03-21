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
      <a-form-item label="餐厅名称" v-bind="validateInfos.name">
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

      <a-form-item label="餐厅图片" v-bind="validateInfos.imageUrl">
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

      <a-form-item label="人均消费" v-bind="validateInfos.price">
        <a-input-number 
          v-model:value="modelRef.price" 
          prefix="￥" 
          style="width: 100%"
          :min="0"
          :precision="2"
        />
      </a-form-item>

      <a-form-item label="餐厅描述" v-bind="validateInfos.description">
        <a-textarea 
          v-model:value="modelRef.description" 
          placeholder="请输入餐厅特色、主营菜品等描述信息"
          :rows="4"
        />
      </a-form-item>
    </a-form>
  </a-modal>
</template>
<script setup>
import { ref, reactive, onMounted, nextTick } from "vue";
import { Form, message } from 'ant-design-vue';
import { save } from '~/api/cuisine'

import { PlusOutlined, DeleteOutlined, UploadOutlined } from '@ant-design/icons-vue';

const baseUrl = import.meta.env.VITE_APP_BASE_URL;
const useForm = Form.useForm;
const visible = ref(false);
const confirmLoading = ref(false);
const emits = defineEmits(["saveOk"]);
const scenicList = ref([]);
const modelRef = ref({
  name: "",
  imageUrl: "",
  price: null,
  description: "",
  address: "",
  scenicId: undefined
})

const fileList = ref([]);

const afterClose = () => {
  resetFields();
  fileList.value = [];
};

const { resetFields, validate, validateInfos } = useForm(
  modelRef,
  reactive({
    name: [{ required: true, message: '请输入餐厅名称'}],
    price: [{ required: true, message: '请输入人均消费'}],
    description: [{ required: true, message: '请输入餐厅描述'}],
    scenicId: [{ required: true, message: '请选择所属景区'}],
    imageUrl: [{ required: true, message: '请上传餐厅图片'}]
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
    price: null,
    description: "",
    scenicId: undefined,
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

// 打开地图选点弹窗
const openMapPicker = () => {
  mapVisible.value = true;
  nextTick(() => {
    initMapPicker();
  });
};

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
</style>