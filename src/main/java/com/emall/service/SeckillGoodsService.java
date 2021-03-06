package com.emall.service;

import com.emall.dao.SeckillGoodsMapper;
import com.emall.entity.SeckillGoods;
import com.emall.redis.RedisKeyUtil;
import com.emall.result.Result;
import com.emall.utils.FutureRunnable;
import com.emall.utils.PageModel;
import com.emall.utils.SnowflakeIdWorker;
import com.emall.utils.UploadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 秒杀商品业务层
 */
@Service
public class SeckillGoodsService {
    @Resource
    SeckillGoodsMapper seckillGoodsMapper;

    @Resource
    RedisTemplate redisTemplate;

    @Resource
    SnowflakeIdWorker snowflakeIdWorker;

    @Resource
    UploadUtil uploadUtil;

    @Resource
    ScheduledExecutorService scheduleThreadPool;

    private static final Logger logger = LoggerFactory.getLogger(SeckillGoodsService.class);

    /**
     * 管理员分页查询全部秒杀商品
     * @param pageModel
     * @return
     */
    public PageModel queryAllPaged(PageModel pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        List seckillGoodsList = seckillGoodsMapper.queryAll(limit, offset);
        int count = seckillGoodsMapper.count();

        pageModel.setCount(count);
        pageModel.setList(seckillGoodsList);
        pageModel.setTotalPages();

        return pageModel;
    }

    /**
     * 管理员根据秒杀商品关键字分页查询
     * @param keyWord
     * @param pageModel
     * @return
     */
    public PageModel selectByKeyWordPaged(String keyWord, PageModel pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        List seckillGoodsList = seckillGoodsMapper.queryByKeyWord(keyWord, limit, offset);
        int count = seckillGoodsMapper.countByKeyWord(keyWord);

        pageModel.setCount(count);
        pageModel.setList(seckillGoodsList);
        pageModel.setTotalPages();

        return pageModel;
    }

    /**
     * 根据秒杀商品id从缓存查询商品
     * @param seckillGoodsId
     * @return
     */
    public SeckillGoods selectBySeckillGoodsIdFromCache(String seckillGoodsId) {
        String seckillGoodsKey = RedisKeyUtil.SECKILL_GOODS_PREFIX + seckillGoodsId;
        if (redisTemplate.hasKey(seckillGoodsKey)) {
            return (SeckillGoods) redisTemplate.opsForValue().get(seckillGoodsKey);
        }

        return null;
    }

    /**
     * 根据秒杀商品id从数据库查询商品
     * @param seckillGoodsId
     * @return
     */
    public SeckillGoods selectBySeckillGoodsId(String seckillGoodsId) {
        return seckillGoodsMapper.selectBySeckillGoodsId(seckillGoodsId);
    }

    /**
     * 根据秒杀商品id删除缓存与数据库记录
     * @param seckillGoodsId
     * @return
     */
    public boolean deleteBySeckillGoodsId(String seckillGoodsId) {
        int status = selectBySeckillGoodsId(seckillGoodsId).getSeckillGoodsStatus();
        if (status == 1 || status == 2) {
            return false;
        }

        return seckillGoodsMapper.deleteBySeckillGoodsId(seckillGoodsId) != 0;
    }

    /**
     * 上架秒杀商品
     * @param seckillGoodsId
     * @return
     */
    @Transactional
    public boolean put(String seckillGoodsId, Date startTime, Date endTime) {
        String seckillGoodsKey = RedisKeyUtil.SECKILL_GOODS_PREFIX + seckillGoodsId;
        String seckillStockKey = RedisKeyUtil.seckillStockById(seckillGoodsId);

        SeckillGoods seckillGoods = selectBySeckillGoodsId(seckillGoodsId);
        seckillGoods.setSeckillGoodsStartTime(startTime);
        seckillGoods.setSeckillGoodsEndTime(endTime);
        seckillGoods.setSeckillGoodsStatus(1);

        boolean flag = seckillGoodsMapper.put(seckillGoods) != 0;
        long end = endTime.getTime() / 1000;
        long now = System.currentTimeMillis() / 1000;
        //秒杀商品缓存 结束10分钟后时失效
        redisTemplate.opsForValue().set(seckillGoodsKey, seckillGoods, end - now + 1800, TimeUnit.SECONDS);
        //秒杀库存缓存
        redisTemplate.opsForValue().set(seckillStockKey, seckillGoods.getSeckillGoodsStock(), end - now + 1800, TimeUnit.SECONDS);
        redisTemplate.opsForList().rightPush(RedisKeyUtil.seckillGoodsAll(), seckillGoodsKey);

        //定时任务
        FutureRunnable task = new FutureRunnable() {
            @Override
            public void run() {
                long start = startTime.getTime() / 1000;
                long end = endTime.getTime() / 1000;
                long now = System.currentTimeMillis() / 1000;
                if (now < start) {
                    logger.info("秒杀商品" + seckillGoodsId + "准备中");
                } else if (now == start) {
                    seckillGoodsMapper.changeStatus(seckillGoodsId, SeckillGoods.ONGOING);
                    logger.info("秒杀商品" + seckillGoodsId + "开始");
                } else if (now < end) {
                    logger.info("秒杀商品" + seckillGoodsId + "进行中");
                } else if (now > end) {
                    seckillGoodsMapper.changeStatus(seckillGoodsId, SeckillGoods.COMPLETE);
                    logger.info("秒杀商品" + seckillGoodsId + "已结束");
                    getFuture().cancel(false);
                }
            }
        };

        Future future = scheduleThreadPool.scheduleAtFixedRate(task, 1, 1, TimeUnit.SECONDS);
        task.setFuture(future);

        return flag;
    }


    /**
     * 下架秒杀商品
     * @param seckillGoodsId
     * @return
     */
    public boolean pull(String seckillGoodsId) {
        boolean success = seckillGoodsMapper.pull(seckillGoodsId) != 0;

        //清除秒杀商品缓存
        if (success) {
            String seckillGoodsKey = RedisKeyUtil.SECKILL_GOODS_PREFIX + seckillGoodsId;
            String seckillStockKey = RedisKeyUtil.seckillStockById(seckillGoodsId);
            List<String> keys = new ArrayList<>();
            keys.add(seckillGoodsKey);
            keys.add(seckillStockKey);
            redisTemplate.delete(keys);
        }

        return success;
    }

    /**
     * 用户从缓存查询秒杀商品库存
     * @param seckillGoodsId
     * @return
     */
    public int stockBySeckillGoodsId(String seckillGoodsId) {
        String seckillStockKey = RedisKeyUtil.seckillStockById(seckillGoodsId);
        return (int) redisTemplate.opsForValue().get(seckillStockKey);
    }

    /**
     * 查看已上架的秒杀商品数
     * @return
     */
    public int countOnShelf() {
        return seckillGoodsMapper.countOnShelf();
    }

    /**
     * 用户端查询所有秒杀商品
     * @return
     */
    public List<SeckillGoods> queryAll() {
        String listKey = RedisKeyUtil.seckillGoodsAll();

        if (redisTemplate.hasKey(listKey)) {
            List<String> seckillGoodsKeyList = redisTemplate.opsForList().range(listKey, 0, -1);
            if (seckillGoodsKeyList == null || seckillGoodsKeyList.size() == 0) {
                return null;
            }
            return getFromRedis(seckillGoodsKeyList);
        }

        return null;
    }

    /**
     * 从缓存查询所有秒杀商品
     * @return
     */
    public List<SeckillGoods> getFromRedis(List<String> seckillGoodsKeyList) {
        List<SeckillGoods> seckillGoodsList = new ArrayList<>();

        for (String seckillGoodsKey : seckillGoodsKeyList) {
            if (redisTemplate.hasKey(seckillGoodsKey)) {
                //通过键获取商品对象填充到页面list
                seckillGoodsList.add((SeckillGoods) redisTemplate.opsForValue().get(seckillGoodsKey));
            } else {
                //若没有缓存说明秒杀已结束
                redisTemplate.opsForList().remove(RedisKeyUtil.seckillGoodsAll(), 0, seckillGoodsKey);
            }
        }

        return seckillGoodsList;
    }

    /**
     * 秒杀商品商品修改
     * @param seckillGoods
     * @param imageFile
     * @param detailFile
     * @param path
     * @return
     */
    @Transactional
    public Result<SeckillGoods> update(SeckillGoods seckillGoods, MultipartFile imageFile, MultipartFile detailFile, String path) {
        String seckillGoodsKey = RedisKeyUtil.seckillGoodsById(seckillGoods);

        if (redisTemplate.hasKey(seckillGoodsKey)) {
            redisTemplate.delete(seckillGoodsKey);
        }

        if (imageFile == null && detailFile == null) {
            if (seckillGoodsMapper.update(seckillGoods) != 0) {
                return Result.success("秒杀商品修改成功", seckillGoods);
            }
        } else if (imageFile != null && detailFile != null) {
            List<String> urlList = uploadUtil.uploadToServer(imageFile, detailFile, path);
            seckillGoods.setSeckillGoodsImage(urlList.get(0));
            seckillGoods.setSeckillGoodsDetails(urlList.get(1));
            if (seckillGoodsMapper.update(seckillGoods) != 0) {
                return Result.success("秒杀商品修改成功", seckillGoods);
            }
        } else if (imageFile != null) {
            List<String> urlList = uploadUtil.uploadToServer(imageFile, null, path);
            seckillGoods.setSeckillGoodsImage(urlList.get(0));
            if (seckillGoodsMapper.update(seckillGoods) != 0) {
                return Result.success("秒杀商品修改成功", seckillGoods);
            }
        } else {
            List<String> urlList = uploadUtil.uploadToServer(null, detailFile, path);
            seckillGoods.setSeckillGoodsDetails(urlList.get(0));
            if (seckillGoodsMapper.update(seckillGoods) != 0) {
                return Result.success("秒杀商品修改成功", seckillGoods);
            }
        }

        return Result.error("秒杀商品修改失败");
    }

    public Result<SeckillGoods> insert(SeckillGoods seckillGoods, MultipartFile imageFile, MultipartFile detailFile, String path) {
        List<String> urlList = uploadUtil.uploadToServer(imageFile, detailFile, path);

        seckillGoods.setSeckillGoodsId(String.valueOf(snowflakeIdWorker.nextId()));
        seckillGoods.setSeckillGoodsImage(urlList.get(0));
        seckillGoods.setSeckillGoodsDetails(urlList.get(1));

        return seckillGoodsMapper.insert(seckillGoods) != 0 ? Result.success("秒杀商品添加成功", seckillGoods) : Result.error("秒杀商品添加失败");
    }
}
