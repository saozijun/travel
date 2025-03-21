package com.cen.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cen.common.Result;
import javax.annotation.Resource;
import java.util.List;

import com.cen.service.IRouteService;
import com.cen.entity.Route;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author volcano
 * @since 2025-03-21
 */
@RestController
@RequestMapping("/route")
public class RouteController {

    @Resource
    private IRouteService routeService;
    //新增或修改
    @PostMapping("/save")
    public Result save(@RequestBody Route route) {
        return Result.success(routeService.saveOrUpdate(route));
    }
    //删除
    @PostMapping("/delete")
    public Result delete(@RequestBody Route route){ //@RequestBody把前台的json对象转成java的对象
        return Result.success(routeService.removeById(route.getId()));
    }
    //批量删除
    @PostMapping("/del/batch")
    public Result Batch(@RequestBody List<Integer> ids){
        return Result.success(routeService.removeBatchByIds(ids));
    }
    //根据id获取
    @GetMapping("/getById")
    public Result findOne(@PathVariable Route route) {
        return Result.success(routeService.getById(route.getId()));
    }
    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                           @RequestParam(defaultValue = "10") Integer pageSize,
                           @RequestParam(defaultValue = "") String name) {
        QueryWrapper<Route> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id"); //设置id倒序
        queryWrapper.like(Strings.isNotEmpty(name),"name",name);
        return Result.success(routeService.page(new Page<>(pageNum, pageSize),queryWrapper));
    }
}

