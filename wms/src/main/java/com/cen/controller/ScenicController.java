package com.cen.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cen.common.Result;
import javax.annotation.Resource;
import java.util.List;

import com.cen.service.IScenicService;
import com.cen.entity.Scenic;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author volcano
 * @since 2025-03-20
 */
@RestController
@RequestMapping("/scenic")
public class ScenicController {

    @Resource
    private IScenicService scenicService;
    //新增或修改
    @PostMapping("/save")
    public Result save(@RequestBody Scenic scenic) {
        return Result.success(scenicService.saveOrUpdate(scenic));
    }
    //删除
    @PostMapping("/delete")
    public Result delete(@RequestBody Scenic scenic){ //@RequestBody把前台的json对象转成java的对象
        return Result.success(scenicService.removeById(scenic.getId()));
    }
    //全部列表
    @GetMapping("/list")
    public Result list(){
        return Result.success(scenicService.list());
    }
    //批量删除
    @PostMapping("/del/batch")
    public Result Batch(@RequestBody List<Integer> ids){
        return Result.success(scenicService.removeBatchByIds(ids));
    }
    //根据id获取
    @GetMapping("/getById")
    public Result findOne(@PathVariable Scenic scenic) {
        return Result.success(scenicService.getById(scenic.getId()));
    }
    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                           @RequestParam(defaultValue = "10") Integer pageSize,
                           @RequestParam(defaultValue = "") String name) {
        QueryWrapper<Scenic> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id"); //设置id倒序
        queryWrapper.like(Strings.isNotEmpty(name),"name",name);
        return Result.success(scenicService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}

