package com.emall.dao;

import com.emall.entity.Order;
import com.emall.vo.OrderManageVo;
import com.emall.vo.OrderVo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface OrderMapper {
    int count();

    int countByUserId(@Param("userId") String userId);

    List<OrderVo> queryCurrentUser(@Param("userId") String userId, @Param("limit") long limit, @Param("offset") long offset);

    int insert(Order order);

    Order selectByOrderId(@Param("orderId") String orderId);

    int orderCancel(@Param("orderId") String orderId);

    int pay(@Param("orderId") String orderId, Date currentDate);

    List<OrderManageVo> queryAll(@Param("limit") long limit, @Param("offset") long offset);

    List<OrderManageVo> queryAllByUserId(@Param("userId") String userId, @Param("limit") long limit, @Param("offset") long offset);

    OrderManageVo queryByOrderId(@Param("orderId") String orderId);

    int send(@Param("orderId") String orderId, Date currentDate);

    int received(@Param("orderId") String orderId, Date currentDate);
}