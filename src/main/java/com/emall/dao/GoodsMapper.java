package com.emall.dao;

import com.emall.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsMapper {
    int insert(Goods record);

    int deleteByPrimaryKey(String goodsId);

    int updateByPrimaryKey(Goods record);

    Goods selectByGoodsId(@Param("goodsId") String goodsId);

    List<Goods> queryAll(@Param("limit") long limit, @Param("offset") long offset);

    List<Goods> selectByKeyWord(@Param("keyWord") String keyWord, @Param("limit") long limit, @Param("offset") long offset);

    List<Goods> selectByCategoryId(@Param("categoryId") String categoryId, @Param("limit") long limit, @Param("offset") long offset);

    long count();

    long countByKeyWord(@Param("keyWord") String keyWord);

    long countByCategoryId(@Param("categoryId") String categoryId);
}