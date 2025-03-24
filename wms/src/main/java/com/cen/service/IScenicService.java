package com.cen.service;

import com.cen.entity.Scenic;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author volcano
 * @since 2025-03-20
 */
public interface IScenicService extends IService<Scenic> {
    // 获取景区详细信息(包含路线和餐饮信息)
    Map<String, Object> getScenicDetailById(Integer id);
}
