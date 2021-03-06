package com.emall.utils;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 分页模型类
 * @param <T>
 */
@Data
public class PageModel<T> {
    @NotNull(message = "页码不能为空")
    private int currentNo;          //当前页数

    private int totalPages;         //总页数

    private int pageSize;           //每页数据条数

    private int count;             //数据总条数

    private List<T> list;          //查询结果

    public void setTotalPages() {
        totalPages = count % pageSize > 0 ? (count / pageSize) + 1 : count / pageSize;
    }
}
