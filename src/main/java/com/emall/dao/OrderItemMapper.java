package com.emall.dao;

import com.emall.entity.OrderItem;

public interface OrderItemMapper {
    int deleteByPrimaryKey(Integer oiId);

    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    OrderItem selectByPrimaryKey(Integer oiId);

    int updateByPrimaryKeySelective(OrderItem record);

    int updateByPrimaryKey(OrderItem record);
}