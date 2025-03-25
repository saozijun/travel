package com.cen.service;

import com.cen.entity.Feedback;
import com.baomidou.mybatisplus.extension.service.IService;
import java.util.Map;

/**
 * <p>
 * 景区反馈表 服务类
 * </p>
 *
 * @author volcano
 * @since 2025-03-24
 */
public interface IFeedbackService extends IService<Feedback> {
    // 获取带详细信息的反馈分页列表
    Map<String, Object> pageWithInfo(Integer pageNum, Integer pageSize, Integer scenicId, Integer userId);
}
