package com.emall.controller;

import com.emall.entity.Category;
import com.emall.result.Result;
import com.emall.service.CategoryService;
import com.emall.utils.PageModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * 商品类别控制层
 */
@Controller
@RequestMapping("/category")
public class CategoryController {
    private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

    @Resource
    CategoryService categoryService;

    /**
     * 分页查询所有商品类别
     * @return
     */
    @GetMapping("/admin")
    @ResponseBody
    public Result<PageModel> adminQueryAll(@Valid PageModel<Category> pageModel) {
        logger.info("查询所有商品类别--第" + pageModel.getCurrentNo() + "页，每页" + pageModel.getPageSize() + "条数据");
        return Result.success("查询所有品类成功", categoryService.adminQueryAll(pageModel));
    }

    /**
     * 根据商品类别id查询商品类别
     * @return
     */
    @GetMapping("/{categoryId}/categoryId")
    @ResponseBody
    public Result<Category> selectByCategoryId(@PathVariable("categoryId") String categoryId) {
        logger.info("根据商品类别id：" + categoryId + "查询商品类别");
        return Result.success("查询商品类别成功", categoryService.selectByCategoryId(categoryId));
    }

    /**
     * 添加商品类别
     * @return
     */
    @PutMapping("/admin")
    @ResponseBody
    public Result<String> insert(String categoryName) {
        logger.info("添加商品类别--" + categoryName);
        if (StringUtils.isEmpty(categoryName)) {
            return Result.error("类别名称不能为空");
        }
        return categoryService.insert(categoryName) ? Result.success("添加类别成功", categoryName) : Result.error("添加类别失败");
    }

    /**
     * 修改商品类别
     * @return
     */
    @PostMapping("/admin")
    @ResponseBody
    public Result<Category> update(@Valid @RequestBody Category category) {
        logger.info("修改商品类别--" + category);
        return categoryService.update(category) ? Result.success("修改类别名称成功", category) : Result.error("修改类别名称失败");
    }

    /**
     * 删除商品类别
     * @return
     */
    @DeleteMapping("/admin")
    @ResponseBody
    public Result<Category> delete(@RequestBody String categoryId) {
        logger.info("删除商品类别");
        return categoryService.delete(categoryId) ? Result.success("删除商品类别成功", null) : Result.error("删除商品类别失败");
    }
}
