package com.cen.service.impl;

import com.cen.entity.Scenic;
import com.cen.mapper.ScenicMapper;
import com.cen.service.IScenicService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import com.cen.entity.Route;
import com.cen.service.IRouteService;
import com.cen.entity.Cuisine;
import com.cen.service.ICuisineService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cen.exception.ServiceException;
import com.cen.common.Constants;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author volcano
 * @since 2025-03-20
 */
@Service
public class ScenicServiceImpl extends ServiceImpl<ScenicMapper, Scenic> implements IScenicService {

    @Resource
    private IRouteService routeService;
    
    @Resource
    private ICuisineService cuisineService;

    @Override
    public Map<String, Object> getScenicDetailById(Integer id) {
        Map<String, Object> result = new HashMap<>();
        
        // 获取景区基本信息
        Scenic scenic = this.getById(id);
        if (scenic == null) {
            throw new ServiceException(Constants.CODE_400, "景区不存在");
        }
        result.put("scenic", scenic);
        
        // 获取相关路线信息
        QueryWrapper<Route> routeQuery = new QueryWrapper<>();
        routeQuery.eq("scenic_id", id);
        List<Route> routes = routeService.list(routeQuery);
        result.put("routes", routes);
        
        // 获取相关餐饮信息
        QueryWrapper<Cuisine> cuisineQuery = new QueryWrapper<>();
        cuisineQuery.eq("scenic_id", id);
        List<Cuisine> cuisines = cuisineService.list(cuisineQuery);
        result.put("cuisines", cuisines);
        
        return result;
    }
}
