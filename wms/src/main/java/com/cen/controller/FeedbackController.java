package com.cen.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cen.common.Result;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import com.cen.service.IFeedbackService;
import com.cen.entity.Feedback;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 景区反馈表 前端控制器
 * </p>
 *
 * @author volcano
 * @since 2025-03-24
 */
@RestController
@RequestMapping("/feedback")
public class FeedbackController {

    @Resource
    private IFeedbackService feedbackService;
    //新增或修改
    @PostMapping("/save")
    public Result save(@RequestBody Feedback feedback) {
        return Result.success(feedbackService.saveOrUpdate(feedback));
    }
    //删除
    @PostMapping("/delete")
    public Result delete(@RequestBody Feedback feedback){ //@RequestBody把前台的json对象转成java的对象
        return Result.success(feedbackService.removeById(feedback.getId()));
    }
    //批量删除
    @PostMapping("/del/batch")
    public Result Batch(@RequestBody List<Integer> ids){
        return Result.success(feedbackService.removeBatchByIds(ids));
    }
    //根据id获取
    @GetMapping("/getById")
    public Result findOne(@PathVariable Feedback feedback) {
        return Result.success(feedbackService.getById(feedback.getId()));
    }
    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                           @RequestParam(defaultValue = "10") Integer pageSize,
                           @RequestParam(required = false) Integer scenicId) {
        QueryWrapper<Feedback> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id"); //设置id倒序
        if (scenicId != null) {
            queryWrapper.eq("scenic_id", scenicId);
        }
        return Result.success(feedbackService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
    
    //分页查询带详细信息的反馈列表
    @GetMapping("/pageWithInfo")
    public Result pageWithInfo(@RequestParam(defaultValue = "1") Integer pageNum,
                               @RequestParam(defaultValue = "10") Integer pageSize,
                               @RequestParam(required = false) Integer scenicId,
                               @RequestParam(required = false) Integer userId) {
        return Result.success(feedbackService.pageWithInfo(pageNum, pageSize, scenicId, userId));
    }
}

