package com.cen.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cen.entity.Feedback;
import com.cen.entity.Scenic;
import com.cen.entity.User;
import com.cen.mapper.FeedbackMapper;
import com.cen.service.IFeedbackService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cen.service.IScenicService;
import com.cen.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 景区反馈表 服务实现类
 * </p>
 *
 * @author volcano
 * @since 2025-03-24
 */
@Service
public class FeedbackServiceImpl extends ServiceImpl<FeedbackMapper, Feedback> implements IFeedbackService {

    @Resource
    private IUserService userService;
    
    @Resource
    private IScenicService scenicService;
    
    @Override
    public Map<String, Object> pageWithInfo(Integer pageNum, Integer pageSize, Integer scenicId) {
        Map<String, Object> result = new HashMap<>();
        
        // 获取反馈分页数据
        QueryWrapper<Feedback> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (scenicId != null) {
            queryWrapper.eq("scenic_id", scenicId);
        }
        Page<Feedback> page = page(new Page<>(pageNum, pageSize), queryWrapper);
        
        // 从分页数据中提取记录列表
        List<Feedback> feedbackList = page.getRecords();
        List<Map<String, Object>> recordsList = new ArrayList<>();
        
        // 为每条记录构建详细信息
        for (int i = 0; i < feedbackList.size(); i++) {
            Feedback feedback = feedbackList.get(i);
            Map<String, Object> record = new HashMap<>();
            
            // 添加序号
            record.put("index", (pageNum - 1) * pageSize + i + 1);
            record.put("id", feedback.getId());
            record.put("content", feedback.getContent());
            record.put("rate", feedback.getRate());
            
            // 获取用户信息
            User user = userService.getById(feedback.getUserId());
            if (user != null) {
                record.put("user", user.getNickname());
                record.put("userId", user.getId());
            } else {
                record.put("user", "未知用户");
                record.put("userId", feedback.getUserId());
            }
            
            // 获取景区信息
            Scenic scenic = scenicService.getById(feedback.getScenicId());
            if (scenic != null) {
                record.put("scenic", scenic.getName());
                record.put("scenicId", scenic.getId());
            } else {
                record.put("scenic", "未知景区");
                record.put("scenicId", feedback.getScenicId());
            }
            
            // 添加时间信息
            record.put("createdAt", feedback.getCreatedAt());
            
            recordsList.add(record);
        }
        
        // 组装结果
        result.put("records", recordsList);
        result.put("total", page.getTotal());
        result.put("size", page.getSize());
        result.put("current", page.getCurrent());
        result.put("pages", page.getPages());
        
        return result;
    }
}
