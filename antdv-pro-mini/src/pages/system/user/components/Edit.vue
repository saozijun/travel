<template>
  <a-modal
    v-model:open="visible"
    :title="modelRef.id ? '编辑' : '新增'"
    :confirm-loading="confirmLoading"
    @ok="handleOk"
    :afterClose="afterClose"
  >
    <a-form 
      name="form" 
      :model="modelRef"
      :label-col="{style:{width: '60px'}}"
    >
      <a-form-item label="昵称" v-bind="validateInfos.nickname" >
        <a-input v-model:value="modelRef.nickname" placeholder="请输入"/>
      </a-form-item>
      <a-form-item label="账号" v-bind="validateInfos.username" >
        <a-input v-model:value="modelRef.username" placeholder="请输入"/>
      </a-form-item>
      <a-form-item label="密码" v-bind="validateInfos.password" >
        <a-input-password v-model:value="modelRef.password" placeholder="请输入"/>
      </a-form-item>
      <a-form-item label="角色" v-bind="validateInfos.roleId" >
        <a-select v-model:value="modelRef.roleId" placeholder="请选择">
          <a-select-option v-for="(item) in roleList" :value="item.id" :key="item.id">{{item.name}}</a-select-option>
        </a-select>
      </a-form-item>
      <a-form-item label="邮箱">
        <a-input v-model:value="modelRef.email" type="email" placeholder="请输入"/>
      </a-form-item>
    </a-form>
  </a-modal>
</template>
<script setup>
import { ref, reactive } from "vue";
import { Form, message } from 'ant-design-vue';
import { save } from '~/api/user'
import { zdList } from '~/api/role'
const useForm = Form.useForm;
const visible = ref(false);
const confirmLoading = ref(false);
const emits = defineEmits(["saveOk"]);
const roleList = ref([])
const modelRef = reactive({
  nickname: "",
  username: "",
  password: "",
  email: "",
  role: "",
  roleId: ""
})

const afterClose = () => {
  resetFields(); 
};

const { resetFields, validate, validateInfos } = useForm(
  modelRef,
  reactive({
    nickname: [{ required: true, message: '请输入昵称'}],
    username: [{ required: true, message: '请输入账号'}],
    password: [ { required: true, message: '请输入密码'}],
    roleId: [ { required: true, message: '请选择角色'}]
  }),
);
const handleOk = async () => {
  try {
    await validate();
    confirmLoading.value = true;
    let role = roleList.value.find(item => item.id == modelRef.roleId)
    modelRef.role = role.name
    await save(modelRef);
    message.success('操作成功');
    emits('saveOk');
    visible.value = false;
  } catch (e) {
    console.error(e);
  } finally {
    confirmLoading.value = false;
  }
};
const open = async (row) => {
  Object.assign(modelRef, {
    nickname: "",
    username: "",
    password: "",
    email: "",
    role: "",
    roleId: ""
  }, row);
  roleList.value = (await zdList()).data
  visible.value = true;
};
defineExpose({
  open,
});
</script>
<style lang="less" scoped>
.ant-form{
  margin-top: 20px;
}
</style>