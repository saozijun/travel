package com.cen.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cen.common.Result;
import javax.annotation.Resource;
import java.util.List;

import com.cen.service.ICuisineService;
import com.cen.entity.Cuisine;

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
@RequestMapping("/cuisine")
public class CuisineController {

    @Resource
    private ICuisineService cuisineService;
    //新增或修改
    @PostMapping("/save")
    public Result save(@RequestBody Cuisine cuisine) {
        return Result.success(cuisineService.saveOrUpdate(cuisine));
    }
    //删除
    @PostMapping("/delete")
    public Result delete(@RequestBody Cuisine cuisine){ //@RequestBody把前台的json对象转成java的对象
        return Result.success(cuisineService.removeById(cuisine.getId()));
    }
    //批量删除
    @PostMapping("/del/batch")
    public Result Batch(@RequestBody List<Integer> ids){
        return Result.success(cuisineService.removeBatchByIds(ids));
    }
    //根据id获取
    @GetMapping("/getById")
    public Result findOne(@PathVariable Cuisine cuisine) {
        return Result.success(cuisineService.getById(cuisine.getId()));
    }
    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                           @RequestParam(defaultValue = "10") Integer pageSize,
                           @RequestParam(defaultValue = "") String name) {
        QueryWrapper<Cuisine> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id"); //设置id倒序
        queryWrapper.like(Strings.isNotEmpty(name),"name",name);
        return Result.success(cuisineService.page(new Page<>(pageNum, pageSize),queryWrapper));
    }
}

