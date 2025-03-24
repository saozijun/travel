<template>
    <div class="box">
        <div class="list">
            <a-tabs v-model:activeKey="activeKey" centered>
                <a-tab-pane key="1" tab="全部景区">
                    <div class="list-box">
                        <div class="list-item" v-for="(item,index) in allList" :key="index" @click="getDetail(item)">
                            <div class="item-image" @click="getDetail(item)">
                                <img :src="item.imageUrl" alt="">
                                <div class="item-price" v-if="item.ticketPrice">¥{{ item.ticketPrice }}</div>
                            </div>
                            <div class="item-content">
                                <h4 class="item-name" @click="getDetail(item)">{{ item.name }}</h4>
                                <div class="item-info">
                                    <div class="item-rate" v-if="item.rate">
                                        <span class="rate-icon">★</span> {{ item.rate }}
                                    </div>
                                    <div class="item-address" v-if="item.address">{{ formatAddress(item.address) }}</div>
                                </div>
                                <div class="item-actions">
                                    <span class="detail-action" @click.stop="getDetail(item)">查看详情</span>
                                    <span class="feedback-action" @click.stop="showFeedbackModal(item)">
                                        <i class="feedback-icon">✍</i> 反馈
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </a-tab-pane>
                <a-tab-pane key="2" tab="智能推荐">
                    <div class="list-box">
                        <div class="list-item" v-for="(item,index) in recommendList" :key="index" @click="getDetail(item)">
                            <div class="item-image">
                                <img :src="item.imageUrl" alt="">
                                <div class="item-price" v-if="item.ticketPrice">¥{{ item.ticketPrice }}</div>
                            </div>
                            <div class="item-content">
                                <h4 class="item-name">{{ item.name }}</h4>
                                <div class="item-info">
                                    <div class="item-rate" v-if="item.rate">
                                        <span class="rate-icon">★</span> {{ item.rate }}
                                    </div>
                                    <div class="item-address" v-if="item.address">{{ formatAddress(item.address) }}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </a-tab-pane>
            </a-tabs>
        </div>
        <div class="map-box">
            <div v-if="currentScenic" class="scenic-detail" :class="{ 'collapsed': isPanelCollapsed }">
                <div class="panel-toggle" @click="togglePanel">
                    <span class="toggle-icon">{{ isPanelCollapsed ? '»' : '«' }}</span>
                </div>
                <div class="panel-content">
                    <div class="scenic-header">
                        <h2>{{ currentScenic.name }}</h2>
                        <div class="scenic-info">
                            <p><span>开放时间:</span> {{ currentScenic.openingHours }}</p>
                            <p><span>门票价格:</span> ¥{{ currentScenic.ticketPrice }}</p>
                            <p><span>联系电话:</span> {{ currentScenic.contactPhone }}</p>
                            <p><span>地址:</span> {{ currentScenic.address }}</p>
                        </div>
                    </div>
                    
                    <a-tabs>
                        <a-tab-pane key="routes" tab="智能路线">
                            <div class="route-controls" v-if="activeRoute">
                                <a-radio-group v-model:value="routeType" @change="onRouteTypeChange">
                                    <a-radio-button value="walk">步行路线</a-radio-button>
                                    <a-radio-button value="drive">驾车路线</a-radio-button>
                                </a-radio-group>
                            </div>
                            <div class="routes-list">
                                <div 
                                    v-for="(route, index) in routes" 
                                    :key="index" 
                                    class="route-item"
                                    :class="{ active: activeRoute && activeRoute.id === route.id }"
                                    @click.stop="showRoute(route)"
                                >
                                    <div class="route-info">
                                        <h3>{{ route.name }}</h3>
                                        <p class="route-desc">{{ route.description }}</p>
                                    </div>
                                    <div class="route-image" @click.stop="">
                                        <a-image :width="60" style="height: 60px;" :src="route.imageUrl"/>
                                    </div>
                                </div>
                            </div>
                        </a-tab-pane>
                        <a-tab-pane key="cuisines" tab="餐饮列表">
                            <div class="cuisines-list">
                                <div v-for="(cuisine, index) in cuisines" :key="index" class="cuisine-item">
                                    <div class="cuisine-image">
                                        <a-image :width="120" :src="cuisine.imageUrl"/>
                                    </div>
                                    <div class="cuisine-info">
                                        <h3>{{ cuisine.name }}</h3>
                                        <p class="cuisine-price">¥{{ cuisine.price }}</p>
                                        <p class="cuisine-desc">{{ cuisine.description }}</p>
                                    </div>
                                </div>
                            </div>
                        </a-tab-pane>
                    </a-tabs>
                </div>
            </div>
            <div class="map-container-wrapper">
                <div id="map-container" class="map-container"></div>
                <div id="route-panel" :class="routePanelClass" v-show="activeRoute"></div>
            </div>
        </div>
        <a-modal 
            v-model:visible="feedbackModalVisible" 
            title="景区反馈" 
            @ok="submitFeedback" 
            @cancel="feedbackModalVisible = false"
            :maskClosable="false"
        >
            <div class="feedback-form">
                <div class="form-item">
                    <div class="form-label">景区名称</div>
                    <div class="form-content">{{ currentFeedbackScenic?.name }}</div>
                </div>
                <div class="form-item">
                    <div class="form-label">您的评分</div>
                    <div class="form-content">
                        <a-rate v-model:value="feedbackForm.rate" allow-half />
                    </div>
                </div>
                <div class="form-item">
                    <div class="form-label">反馈内容</div>
                    <div class="form-content">
                        <a-textarea 
                            v-model:value="feedbackForm.content" 
                            placeholder="请输入您对该景区的反馈" 
                            :rows="4" 
                            :maxlength="200"
                            show-count
                        />
                    </div>
                </div>
                <div class="form-tips">
                    您的反馈对我们非常重要，感谢您的评价！
                </div>
            </div>
        </a-modal>
    </div>
</template>

<script setup>
import { get } from 'lodash';
import { ref, onMounted, watch, nextTick, computed } from 'vue';
import { zdlist, recommend, detail } from '~/api/scenic'
import AMapLoader from '@amap/amap-jsapi-loader';
import { message } from 'ant-design-vue';
import { save } from '~/api/feedback/index.js'
import { useUserStore } from '~@/stores/user'
const userStore = useUserStore()
const activeKey = ref('1')
const allList = ref([])
const recommendList = ref([])
const currentScenic = ref(null)
const cuisines = ref([])
const routes = ref([])
const activeRoute = ref(null)
const map = ref(null)
const routeMarkers = ref({
    start: null,
    end: null
})
const routingResult = ref(null)
const routeType = ref('walk')
const isPanelCollapsed = ref(false)
const feedbackModalVisible = ref(false)
const feedbackForm = ref({
    rate: 5,
    content: ''
})
const currentFeedbackScenic = ref(null)

// 高德地图配置
const MAP_KEY = 'ec1cc8fead3b82b6798ba07768c1a3e3'
const WEB_SERVICE_KEY = '6ede2de34b2ec9fe711c87e06b5d16a7'
const MAP_PLUGINS = ['AMap.Geocoder', 'AMap.PlaceSearch', 'AMap.Walking', 'AMap.Driving']

// 设置安全配置
window._AMapSecurityConfig = {
    securityJsCode: "10782f5a3b5a11e72afa948b6ddcd15c",
}

onMounted(() => {
    getAllList()
    initMap()
})

watch(activeKey, async (val) => {
    if (val == '1') {
        getAllList()
    } else {
        const { data } = await recommend()
        recommendList.value = data
    }
})

const initMap = async () => {
    try {
        if (!window.AMap) {
            window.AMap = await AMapLoader.load({
                key: MAP_KEY,
                version: '2.0',
                plugins: MAP_PLUGINS
            })
        }
        
        // 创建地图实例
        map.value = new AMap.Map('map-container', {
            zoom: 13,
            center: [110.186956, 25.235479]  // 默认中心点
        })
    } catch (error) {
        console.error('地图加载失败:', error)
        message.error('地图加载失败')
    }
}

const getDetail = async (item) => {
    try {
        const res = await detail(item.id)
        currentScenic.value = res.data.scenic
        cuisines.value = res.data.cuisines || []
        routes.value = res.data.routes || []
        activeRoute.value = null
        
        // 清除之前的路线
        clearRouteDisplay()
        
        // 如果景区有位置信息，将地图中心设置到景区位置
        if (currentScenic.value && currentScenic.value.locations) {
            const [lng, lat] = currentScenic.value.locations.split(',')
            map.value.setCenter([lng, lat])
            
            // 添加景区标记
            new AMap.Marker({
                position: [lng, lat],
                map: map.value,
                label: {
                    content: currentScenic.value.name,
                    direction: 'top'
                }
            })
        }
    } catch (error) {
        console.error('获取详情失败:', error)
        message.error('获取详情失败')
    }
}

const showRoute = (route) => {
    // 如果点击的是已选中的路线，则取消选中
    if (activeRoute.value && activeRoute.value.id === route.id) {
        activeRoute.value = null
        clearRouteDisplay()
        return
    }
    
    // 以下是原有逻辑 - 选中新路线
    activeRoute.value = route
    
    // 清除之前的路线
    clearRouteDisplay()
    
    // 清空路线面板
    const panel = document.getElementById('route-panel')
    if (panel) {
        panel.innerHTML = ''
    }
    
    if (route.routeData) {
        try {
            const routeData = JSON.parse(route.routeData)
            const { startLocation, endLocation, type } = routeData
            
            // 设置路线类型
            routeType.value = type || 'walk'
            
            if (startLocation && endLocation) {
                const [startLng, startLat] = startLocation.split(',')
                const [endLng, endLat] = endLocation.split(',')
                
                // 添加起点和终点标记
                addRouteMarker('start', new AMap.LngLat(startLng, startLat))
                addRouteMarker('end', new AMap.LngLat(endLng, endLat))
                
                // 计算并显示路线
                calculateRoute(routeType.value)
            }
        } catch (error) {
            console.error('解析路线数据失败:', error)
            message.error('路线数据格式错误')
        }
    }
}

// 路线类型切换处理函数
const onRouteTypeChange = () => {
    if (activeRoute.value && activeRoute.value.routeData) {
        try {
            const routeData = JSON.parse(activeRoute.value.routeData)
            const { startLocation, endLocation } = routeData
            
            if (startLocation && endLocation) {
                // 清空路线面板
                const panel = document.getElementById('route-panel')
                if (panel) {
                    panel.innerHTML = ''
                }
                
                // 重新计算路线
                calculateRoute(routeType.value)
            }
        } catch (error) {
            console.error('路线类型切换失败:', error)
        }
    }
}

// 添加路线标记
const addRouteMarker = (type, lnglat) => {
    if (routeMarkers.value[type]) {
        routeMarkers.value[type].setPosition(lnglat)
    } else {
        routeMarkers.value[type] = new AMap.Marker({
            position: lnglat,
            map: map.value,
            label: {
                content: type === 'start' ? '起点' : '终点',
                direction: 'top'
            }
        })
    }
}

// 计算路线
const calculateRoute = async (routeType = 'walk') => {
    if (!routeMarkers.value.start || !routeMarkers.value.end) return
    
    const start = routeMarkers.value.start.getPosition()
    const end = routeMarkers.value.end.getPosition()
    
    try {
        // 清除已有路线
        if (routingResult.value) {
            routingResult.value.clear()
        }
        
        // 创建路线规划实例，添加导航面板
        const router = routeType === 'walk' 
            ? new AMap.Walking({
                map: map.value,
                panel: 'route-panel',
                hideMarkers: true
            })
            : new AMap.Driving({
                map: map.value,
                panel: 'route-panel',
                hideMarkers: true
            })
        
        // 搜索路线
        router.search(
            [start.getLng(), start.getLat()],
            [end.getLng(), end.getLat()],
            (status, result) => {
                if (status === 'complete') {
                    routingResult.value = router
                    
                    // 调整地图视野以包含所有标记点和路线
                    const startPoint = routeMarkers.value.start.getPosition()
                    const endPoint = routeMarkers.value.end.getPosition()
                    
                    // 创建包含起点和终点的边界
                    const bounds = new AMap.Bounds(
                        [startPoint.getLng(), startPoint.getLat()],
                        [endPoint.getLng(), endPoint.getLat()]
                    )
                    
                    // 设置地图视野
                    map.value.setBounds(bounds, [50, 50, 50, 50])
                } else {
                    message.error('路线规划失败')
                }
            }
        )
    } catch (error) {
        message.error(`路线规划异常: ${error.message}`)
    }
}

// 清除路线显示
const clearRouteDisplay = () => {
    // 清除路线
    if (routingResult.value) {
        routingResult.value.clear()
        routingResult.value = null
    }
    
    // 清除标记点
    if (routeMarkers.value.start) {
        routeMarkers.value.start.setMap(null)
        routeMarkers.value.start = null
    }
    if (routeMarkers.value.end) {
        routeMarkers.value.end.setMap(null)
        routeMarkers.value.end = null
    }
}

const getAllList = async () => {
    const { data } = await zdlist()
    allList.value = data
}

// 添加一个计算属性来控制路线面板的可见性类
const routePanelClass = computed(() => {
    return activeRoute.value ? 'route-panel visible' : 'route-panel';
});

const togglePanel = () => {
    isPanelCollapsed.value = !isPanelCollapsed.value
}

// 在<script setup>中添加地址格式化函数
const formatAddress = (address) => {
    // 如果地址过长，只保留前15个字符并添加省略号
    if (address && address.length > 15) {
        return address.substring(0, 15) + '...';
    }
    return address;
}

const showFeedbackModal = (scenic) => {
    currentFeedbackScenic.value = scenic
    feedbackForm.value = {
        rate: 5,
        content: ''
    }
    feedbackModalVisible.value = true
}

const submitFeedback = async () => {
    if (!feedbackForm.value.rate) {
        message.warning('请选择评分')
        return
    }
    
    try {
        const params = {
            userId: userStore.userInfo.id,
            scenicId: currentFeedbackScenic.value.id,
            rate: feedbackForm.value.rate,
            content: feedbackForm.value.content
        }
        await save(params)
        message.success('反馈成功')
        feedbackModalVisible.value = false
        updateScenicInList(allList.value)
        updateScenicInList(recommendList.value)
        
    } catch (error) {}
}
</script>

<style lang="less" scoped>
.box{
    width: 100%;
    height: calc(100vh - 170px);
    display: grid;
    grid-template-columns: 280px 1fr;
    grid-gap: 24px;
    background-color: #f8f9fa;
    padding: 16px;
    
    .list{
        height: 100%;
        background-color: #fff;
        overflow-y: auto;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        
        :deep(.ant-tabs-nav) {
            margin-bottom: 16px;
        }
        
        .list-box{
            padding: 0 16px 16px;
            
            .list-item{
                width: 100%;
                overflow: hidden;
                cursor: pointer;
                border-radius: 8px;
                margin-bottom: 16px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
                background-color: #fff;
                border: 1px solid #f0f0f0;
                
                &:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 6px 16px rgba(0,0,0,0.1);
                }
                
                .item-image {
                    position: relative;
                    width: 100%;
                    height: 140px;
                    overflow: hidden;
                    
                    img{
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: all 0.5s ease;
                        
                        &:hover {
                            transform: scale(1.05);
                        }
                    }
                    
                    .item-price {
                        position: absolute;
                        bottom: 0;
                        right: 0;
                        background: linear-gradient(90deg, rgba(24, 144, 255, 0.8), rgba(24, 144, 255, 0.9));
                        color: white;
                        padding: 4px 8px;
                        font-size: 13px;
                        border-radius: 4px 0 0 0;
                    }
                }
                
                .item-content {
                    padding: 12px;
                    
                    .item-name {
                        font-size: 15px;
                        font-weight: 500;
                        color: #2c3e50;
                        margin: 0 0 6px 0;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }
                    
                    .item-info {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        
                        .item-rate {
                            color: #f59e0b;
                            font-size: 13px;
                            display: flex;
                            align-items: center;
                            
                            .rate-icon {
                                margin-right: 3px;
                            }
                        }
                        
                        .item-address {
                            color: #718096;
                            font-size: 12px;
                            white-space: nowrap;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            max-width: 70%;
                        }
                    }
                    
                    .item-actions {
                        display: flex;
                        justify-content: space-between;
                        margin-top: 8px;
                        padding-top: 8px;
                        border-top: 1px dashed #f0f0f0;
                        
                        .detail-action, .feedback-action {
                            font-size: 13px;
                            color: #4a90e2;
                            cursor: pointer;
                            transition: all 0.3s;
                            display: flex;
                            align-items: center;
                            
                            &:hover {
                                color: #1890ff;
                            }
                        }
                        
                        .feedback-icon {
                            font-size: 14px;
                            margin-right: 4px;
                        }
                    }
                }
            }
        }
    }
    
    .map-box{
        height: 100%;
        background-color: #fff;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        position: relative;
        
        .scenic-detail {
            position: absolute;
            top: 15px;
            left: 15px;
            width: 380px;
            max-height: 70%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.12);
            z-index: 2;
            backdrop-filter: blur(5px);
            background-color: rgba(255, 255, 255, 0.95);
            transition: transform 0.3s ease;
            
            // 折叠时的样式
            &.collapsed {
                transform: translateX(-400px);
                
                .panel-toggle {
                    background-color: #1890ff;
                    color: white;
                    
                    .toggle-icon {
                        transform: translateX(2px);
                    }
                }
            }
            
            // 切换按钮样式
            .panel-toggle {
                position: absolute;
                right: -30px;
                top: 50%;
                transform: translateY(-50%);
                width: 30px;
                height: 60px;
                background-color: #fff;
                border-radius: 0 8px 8px 0;
                box-shadow: 3px 0 10px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                z-index: 3;
                transition: all 0.3s ease;
                
                &:hover {
                    background-color: #1890ff;
                    color: white;
                }
                
                .toggle-icon {
                    font-size: 18px;
                    font-weight: bold;
                    transition: transform 0.3s ease;
                }
            }
            
            // 面板内容容器
            .panel-content {
                padding: 20px;
            }
            
            .scenic-header {
                margin-bottom: 20px;
                
                h2 {
                    margin-bottom: 12px;
                    font-size: 22px;
                    color: #2c3e50;
                    position: relative;
                    padding-bottom: 10px;
                    
                    &:after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        width: 40px;
                        height: 3px;
                        background: linear-gradient(90deg, #1890ff, #69c0ff);
                        border-radius: 3px;
                    }
                }
                
                .scenic-info {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 12px;
                    
                    p {
                        margin: 0;
                        margin-right: 15px;
                        font-size: 14px;
                        color: #718096;
                        line-height: 1.5;
                        
                        span {
                            color: #4a5568;
                            font-weight: 500;
                        }
                    }
                }
            }
            
            :deep(.ant-tabs-nav) {
                margin-bottom: 16px;
            }
            
            .route-controls {
                margin-bottom: 16px;
                padding: 12px 0;
                border-bottom: 1px solid #f0f0f0;
            }
            
            .routes-list, .cuisines-list {
                margin-top: 12px;
                
                .route-item, .cuisine-item {
                    display: flex;
                    align-items: flex-start;
                    padding: 16px;
                    border-radius: 8px;
                    margin-bottom: 12px;
                    border: 1px solid #f0f0f0;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    background-color: #fff;
                    
                    &:hover {
                        background-color: #f9fafb;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                    }
                    
                    &.active {
                        border-color: #1890ff;
                        background-color: #e6f7ff;
                    }
                }
                
                .route-item {
                    justify-content: space-between;
                    
                    .route-info {
                        flex: 1;
                        
                        h3 {
                            margin: 0 0 8px 0;
                            color: #2c3e50;
                            font-size: 16px;
                        }
                        
                        .route-desc {
                            margin: 0;
                            font-size: 14px;
                            color: #718096;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                            line-height: 1.5;
                        }
                    }
                    
                    .route-image {
                        width: 60px;
                        height: 60px;
                        margin-left: 16px;
                        overflow: hidden;
                        border-radius: 6px;
                        
                        img {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            transition: all 0.5s ease;
                            
                            &:hover {
                                transform: scale(1.08);
                            }
                        }
                    }
                }
                
                .cuisine-item {
                    .cuisine-image {
                        margin-right: 16px;
                        overflow: hidden;
                        border-radius: 6px;
                    }
                    
                    .cuisine-info {
                        flex: 1;
                        
                        h3 {
                            margin: 0 0 6px 0;
                            color: #2c3e50;
                            font-size: 16px;
                        }
                        
                        .cuisine-price {
                            color: #e53e3e;
                            font-weight: 500;
                            margin: 0 0 6px 0;
                        }
                        
                        .cuisine-desc {
                            margin: 0;
                            font-size: 14px;
                            color: #718096;
                            line-height: 1.5;
                        }
                    }
                }
            }
        }
        
        .map-container-wrapper {
            flex: 1;
            display: flex;
            width: 100%;
            height: 100%;
            
            .map-container {
                flex: 1;
                height: 100%;
                position: relative;
            }
            
            .route-panel {
                width: 300px;
                height: 100%;
                overflow-y: auto;
                border-left: 1px solid #f0f0f0;
                background: #fff;
                box-shadow: -2px 0 10px rgba(0,0,0,0.05);
                z-index: 2;
                transition: transform 0.3s ease;
                transform: translateX(100%);
                
                &.visible {
                    transform: translateX(0);
                }
                
                :deep(.amap-lib-driving),
                :deep(.amap-lib-walking) {
                    padding: 16px;
                    
                    .amap-lib-driving-title {
                        background-color: #f8fafc;
                        padding: 12px;
                        margin-bottom: 12px;
                        border-radius: 6px;
                        font-size: 14px;
                        color: #4a5568;
                    }
                    
                    .amap-lib-driving-step {
                        padding: 10px;
                        border-bottom: 1px solid #f0f0f0;
                        
                        &:last-child {
                            border-bottom: none;
                        }
                    }
                }
            }
        }
    }
}

:deep(.amap-call) {
    display: none;
}

// 滚动条样式优化
.list, .scenic-detail, .route-panel {
    &::-webkit-scrollbar {
        width: 6px;
    }
    
    &::-webkit-scrollbar-track {
        background: #f8f9fa;
    }
    
    &::-webkit-scrollbar-thumb {
        background-color: #e2e8f0;
        border-radius: 3px;
        
        &:hover {
            background-color: #cbd5e0;
        }
    }
}

// 反馈表单样式
.feedback-form {
    .form-item {
        margin-bottom: 16px;
        
        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .form-content {
            line-height: 1.5;
        }
    }
    
    .form-tips {
        font-size: 13px;
        color: #8c8c8c;
        margin-top: 16px;
        padding-top: 12px;
        border-top: 1px dashed #f0f0f0;
    }
}
</style>