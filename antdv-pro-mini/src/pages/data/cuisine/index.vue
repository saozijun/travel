<template>
  <div class="box">
    <a-card mb-4>
      <a-form :model="formModel">
        <a-row :gutter="[15, 0]">
          <a-col>
            <a-form-item name="name" label="美食名称">
              <a-input v-model:value="formModel.name" placeholder="请输入美食名称" />
            </a-form-item>
          </a-col>
          <a-col>
            <a-space flex justify-end w-full>
              <a-button :loading="loading" type="primary" @click="onSearch">
                查询
              </a-button>
              <a-button :loading="loading" @click="onReset">
                重置
              </a-button>
              <a-button  type="primary" @click="open">
                <template #icon>
                  <PlusOutlined />
                </template>
                新增
              </a-button>
            </a-space>
          </a-col>
        </a-row>
      </a-form>
    </a-card>
    <a-table :columns="columns" :data-source="tableData" :pagination="false">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'imageUrl'">
          <span>
            <a-image v-if="record.imageUrl" :src="record.imageUrl" :width="60" />
          </span>
        </template>
        <template v-else-if="column.key === 'scenicId'">
          <span>
            <a-tag color="processing">{{ getscenicName(record.scenicId) }}</a-tag>
          </span>
        </template>
        <template v-else-if="column.key === 'operation'">
          <a-button style="padding: 0;" type="link" @click="open(record)">编辑</a-button>
          <a-popconfirm title="确定删除吗?" @confirm="onDelete(record.id)">
            <a-button type="link" danger>删除</a-button>
          </a-popconfirm>
        </template>
      </template>
    </a-table>
    <div class="pagination">
      <a-pagination v-model:current="formModel.pageNum" :total="total" @change="onPageChange" />
    </div>
    <Edit ref="editRef" @saveOk="getList"></Edit>
  </div>
</template>
<script setup>
import { PlusOutlined } from '@ant-design/icons-vue';
import { ref, onMounted } from 'vue';
import { message } from 'ant-design-vue';
import { list, del } from '~/api/cuisine'
import { zdlist } from '~/api/scenic'
import Edit from './components/Edit.vue';
const editRef = ref(null)
const expand = ref(false)
const scenicList = ref([])
const loading = ref(false)
const tableData = ref([])
const total = ref(0)
const formModel = ref({
    pageNum: 1,
    pageSize: 10,
    name: "",
    address: "",
})

onMounted(() => {
  getScenicList()
  getList()
})

const getScenicList = async () => {
  const { data } = await zdlist()
  scenicList.value = data
}

const onPageChange = (page) => {
  getList()
}
const onSearch = () => {
  getList()
}
const onReset = () => {
  formModel.value = {
    pageNum: 1,
    pageSize: 10,
    name: "",
    address: ""
  }
  getList()
}

const getList = async () => {
  loading.value = true
  try {
    const { data } = await list(formModel.value)
    total.value = data.total
    data.records.map((item,i) => {item.index = i + 1})
    tableData.value = data.records
  } catch (error) {} finally {
    loading.value = false
  }
}

const onDelete = async (id) => {
  try {
    await del({id})
    message.success('删除成功')
    getList()
  } catch (error) {}
}

const getscenicName = (id) => {
  const item = scenicList.value.find(item => item.id === id)
  return item ? item.name : ''
}

const open = (record = {}) => {
  editRef.value.open(record, scenicList.value)
}
const columns = [
  {
    title: '序号',
    dataIndex: 'index',
    key: 'index',
    width: 80,
  },
  {
    title: '美食名称',
    dataIndex: 'name',
    key: 'name',
  },
  {
    title: '美食图片',
    dataIndex: 'imageUrl',
    key: 'imageUrl',
  },
  {
    title: '所属景区',
    dataIndex: 'scenicId',
    key: 'scenicId',
  },
  {
    title: '人均消费',
    dataIndex: 'price',
    key: 'price',
    customRender: ({ text }) => {
      return `¥${text}`
    }
  },
  {
    title: '描述',
    dataIndex: 'description',
    key: 'description'
  },
  {
    title: '操作',
    key: 'operation',
    fixed: 'right',
    width: 200,
  },
];
</script>

<style lang="less" scoped>
.box {
  height: calc(100vh - 170px);
}

:deep( .ant-form-item ) {
  margin-bottom: 0;
}
.pagination{
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>