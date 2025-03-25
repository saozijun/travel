<template>
  <div class="box">
    <a-card mb-4>
      <a-form :model="formModel">
        <a-row :gutter="[15, 0]">
          <a-col>
            <a-form-item name="scenicId" label="景区">
                <a-select v-model:value="formModel.scenicId" style="width: 180px" placeholder="请选择">
                    <a-select-option v-for="item in scenicList" :value="item.id" >{{ item.name }}</a-select-option>
                </a-select>
            </a-form-item>
          </a-col>
          <a-col>
            <a-space flex justify-end w-full>
              <a-button :loading="loading" type="primary" @click="onSearch">
                查询
              </a-button>
              <a-button :loading="loading" @click="onReset"> 重置 </a-button>
            </a-space>
          </a-col>
        </a-row>
      </a-form>
    </a-card>
    <a-table :columns="columns" :data-source="tableData" :pagination="false">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'scenic'">
          <a-tag color="blue">{{ record.scenic }}</a-tag>
        </template>
        <template v-else-if="column.key === 'rate'">
          <a-rate :value="record.rate" disabled />
        </template>
      </template>
    </a-table>
    <div class="pagination">
      <a-pagination
        v-model:current="formModel.pageNum"
        :total="total"
        @change="onPageChange"
      />
    </div>
  </div>
</template>
<script setup>
import { PlusOutlined } from "@ant-design/icons-vue";
import { ref, onMounted } from "vue";
import { message } from "ant-design-vue";
import { list } from "~/api/feedback/index.js";
import { zdlist } from "~/api/scenic";
import { useUserStore } from '~@/stores/user'
const userStore = useUserStore()
const expand = ref(false);
const loading = ref(false);
const scenicList = ref([]);
const tableData = ref([]);
const total = ref(0);
const formModel = ref({
  pageNum: 1,
  pageSize: 10,
  scenicId: null,
});

onMounted(() => {
  getScenicList();
  getList();
});
const getScenicList = async () => {
  const { data } = await zdlist();
  scenicList.value = data;
};
const onPageChange = (page) => {
  getList();
};
const onSearch = () => {
  getList();
};
const onReset = () => {
  formModel.value = {
    pageNum: 1,
    pageSize: 10,
  };
  getList();
};

const getList = async () => {
  loading.value = true;
  try {
    const { data } = await list({...formModel.value, userId: userStore.userInfo.id });
    total.value = data.total;
    data.records.map((item, i) => {
      item.index = i + 1;
    });
    tableData.value = data.records;
  } catch (error) {
  } finally {
    loading.value = false;
  }
};

const columns = [
  {
    title: "序号",
    dataIndex: "index",
    key: "index",
    width: 80,
  },
  {
    title: "景区名称",
    dataIndex: "scenic",
    key: "scenic",
  },
  {
    title: "反馈评分",
    dataIndex: "rate",
    key: "rate",
  },
  {
    title: "反馈内容",
    dataIndex: "content",
    key: "content",
  }
];
</script>

<style lang="less" scoped>
.box {
  height: calc(100vh - 170px);
}

:deep(.ant-form-item) {
  margin-bottom: 0;
}
.pagination {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
