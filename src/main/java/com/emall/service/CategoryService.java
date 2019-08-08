package com.emall.service;

import com.emall.dao.CategoryMapper;
import com.emall.entity.Category;
import com.emall.exception.GeneralException;
import com.emall.utils.PageModel;
import com.emall.utils.SnowFlakeConfig;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CategoryService {
    @Resource
    private SnowFlakeConfig.SnowflakeIdWorker snowflakeIdWorker;

    @Resource
    CategoryMapper categoryMapper;

    public List<Category> QueryAll() {
        return categoryMapper.queryAll();
    }

    public boolean insert(String categoryName) throws GeneralException {
        Assert.isTrue(!categoryMapper.isExistByName(categoryName), "商品类别已存在");

        String categoryId = String.valueOf(snowflakeIdWorker.nextId());
        Category category = new Category(categoryId, categoryName);
        return categoryMapper.insert(category) != 0;
    }

    public PageModel<Category> adminQueryAll(PageModel<Category> pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        List<Category> categoryList;
        categoryList = categoryMapper.adminQueryAll(limit, offset);
        long count = categoryMapper.count();

        pageModel.setList(categoryList);
        pageModel.setCount(count);
        pageModel.setTotalPages();

        return pageModel;
    }

    public boolean update(Category category) {
        Assert.isTrue(!categoryMapper.isExistByName(category.getCategoryName()), "商品类别已存在");

        return categoryMapper.updateByPrimaryKey(category) != 0;
    }

    public boolean delete(String categoryId) {
        return categoryMapper.deleteByCategoryId(categoryId) != 0;
    }
}
