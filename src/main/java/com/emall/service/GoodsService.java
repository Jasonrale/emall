package com.emall.service;

import com.emall.dao.GoodsMapper;
import com.emall.dao.SeckillGoodsMapper;
import com.emall.entity.Goods;
import com.emall.entity.SeckillGoods;
import com.emall.redis.RedisKeyUtil;
import com.emall.result.Result;
import com.emall.utils.PageModel;
import com.emall.utils.SnowFlakeConfig;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Service
public class GoodsService {
    @Resource
    GoodsMapper goodsMapper;

    @Resource
    SeckillGoodsMapper seckillGoodsMapper;

    @Resource
    RedisTemplate redisTemplate;

    @Resource
    SnowFlakeConfig.SnowflakeIdWorker snowflakeIdWorker;

    /**
     * 分页查询全部商品
     * @param pageModel
     * @return
     */
    public PageModel<Goods> queryAll(PageModel<Goods> pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        List<Goods> goodsList = goodsMapper.queryAll(limit, offset);
        long count = goodsMapper.count();

        pageModel.setCount(count);
        pageModel.setList(goodsList);
        pageModel.setTotalPages();

        return pageModel;
    }


    /**
     * 根据商品id查询商品并缓存
     * @param goodsId
     * @return
     */
    public Goods selectByGoodsId(String goodsId) {
        String goodsKey = RedisKeyUtil.GOODS_PREFIX + goodsId;
        if (redisTemplate.hasKey(goodsKey)) {
            return (Goods) redisTemplate.opsForValue().get(goodsKey);
        }

        Goods goods = goodsMapper.selectByGoodsId(goodsId);
        redisTemplate.opsForValue().set(goodsKey, goods);
        return goods;
    }

    /**
     * 根据关键字分页查询商品列表
     * @param keyWord
     * @param pageModel
     * @return
     */
    public PageModel<Goods> selectByKeyWord(String keyWord, PageModel<Goods> pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        keyWord = '%' + keyWord + '%';
        List<Goods> goodsList = goodsMapper.selectByKeyWord(keyWord, limit, offset);
        long count = goodsMapper.countByKeyWord(keyWord);

        pageModel.setCount(count);
        pageModel.setList(goodsList);
        pageModel.setTotalPages();

        return pageModel;
    }

    /**
     * 根据商品类别id分页查询商品列表
     * @param categoryId
     * @param pageModel
     * @return
     */
    public PageModel<Goods> selectByCategoryId(String categoryId, PageModel<Goods> pageModel) {
        long limit = pageModel.getPageSize();
        long offset = (pageModel.getCurrentNo() - 1) * limit;

        List<Goods> goodsList = goodsMapper.selectByCategoryId(categoryId, limit, offset);
        long count = goodsMapper.countByCategoryId(categoryId);

        pageModel.setCount(count);
        pageModel.setList(goodsList);
        pageModel.setTotalPages();

        return pageModel;
    }

    /**
     * 商品添加
     *
     * @param goods
     * @param imageFile
     * @param detailFile
     * @param path
     * @return
     */
    @Transactional
    public Result<Goods> insert(Goods goods, MultipartFile imageFile, MultipartFile detailFile, String path) {
        List<String> urlList = upLoadToServer(imageFile, detailFile, path);

        goods.setGoodsId(String.valueOf(snowflakeIdWorker.nextId()));
        goods.setGoodsImage(urlList.get(0));
        goods.setGoodsDetails(urlList.get(1));

        return goodsMapper.insert(goods) != 0 ? Result.success("商品添加成功", goods) : Result.error("商品添加失败");
    }

    /**
     * 商品修改
     *
     * @param goods
     * @param imageFile
     * @param detailFile
     * @param path
     * @return
     */
    @Transactional
    public Result<Goods> update(Goods goods, MultipartFile imageFile, MultipartFile detailFile, String path) {
        String goodsKey = RedisKeyUtil.goodsByGoodsId(goods);
        if (redisTemplate.hasKey(goodsKey)) {
            redisTemplate.delete(goodsKey);
        }

        if (imageFile == null && detailFile == null) {
            if (goodsMapper.updateByGoodsIdSelective(goods) != 0) {
                return Result.success("商品修改成功", goods);
            }
        } else if (imageFile != null && detailFile != null) {
            List<String> urlList = upLoadToServer(imageFile, detailFile, path);
            goods.setGoodsImage(urlList.get(0));
            goods.setGoodsDetails(urlList.get(1));
            if (goodsMapper.updateByGoodsIdSelective(goods) != 0) {
                return Result.success("商品修改成功", goods);
            }
        } else if (imageFile != null) {
            List<String> urlList = upLoadToServer(imageFile, null, path);
            goods.setGoodsImage(urlList.get(0));
            if (goodsMapper.updateByGoodsIdSelective(goods) != 0) {
                return Result.success("商品修改成功", goods);
            }
        } else {
            List<String> urlList = upLoadToServer(null, detailFile, path);
            goods.setGoodsDetails(urlList.get(0));
            if (goodsMapper.updateByGoodsIdSelective(goods) != 0) {
                return Result.success("商品修改成功", goods);
            }
        }

        return Result.error("商品修改失败");
    }

    /**
     * 上传到Ftp服务器
     *
     * @param imageFile
     * @param detailFile
     * @param path
     * @return
     */
    @Transactional
    public List<String> upLoadToServer(MultipartFile imageFile, MultipartFile detailFile, String path) {
        String tmpPath = "E:/ImageTemp" + path;

        File dir = new File(tmpPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        FTPClient ftp = new FTPClient();

        List<String> urlList = new ArrayList<>();
        InputStream imageLocal = null;
        InputStream detailLocal = null;
        try {
            ftp.connect("192.168.153.130", 21);
            ftp.login("ftpadmin", "123456");
            String ftpPath = "/home/ftpadmin/emall/images/";

            Date currentDate = new Date();
            String dateStr = new SimpleDateFormat("yyyy/MM/dd").format(currentDate);
            for (String pathStr : dateStr.split("/")) {
                ftpPath += pathStr + "/";
                boolean flag = ftp.changeWorkingDirectory(ftpPath);
                if (!flag) {
                    ftp.makeDirectory(ftpPath);
                }
            }
            //指定上传路径
            ftp.changeWorkingDirectory(ftpPath);
            //指定上传文件的类型  二进制文件
            ftp.setFileType(FTP.BINARY_FILE_TYPE);

            if (imageFile != null) {
                imageLocal = upload(imageFile, path, tmpPath, ftpPath, ftp, urlList);
            }

            if (detailFile != null) {
                detailLocal = upload(detailFile, path, tmpPath, ftpPath, ftp, urlList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            File del = new File(tmpPath);
            delAllFile(del);

            try {
                if (imageLocal != null) {
                    imageLocal.close();
                }
                if (detailLocal != null) {
                    detailLocal.close();
                }
                //退出
                ftp.logout();
                //断开连接
                ftp.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return urlList;
    }

    @Transactional
    public InputStream upload(MultipartFile clientFile, String path, String tmpPath, String ftpPath, FTPClient ftp, List<String> urlList) {
        InputStream inputLocal = null;

        try {
            //文件名称
            String clientFileName = clientFile.getOriginalFilename();
            //临时图片文件路径
            File client = new File(path, Objects.requireNonNull(clientFileName));

            //浏览器端上传文件到临时文件夹
            clientFile.transferTo(client);

            //临时文件
            File tmp = new File(tmpPath + clientFileName);
            //ftp流
            inputLocal = new FileInputStream(tmp);
            //文件新名称
            String newFileName = getFileName(clientFileName);
            //临时文件再上传到图片服务器
            ftp.storeFile(newFileName, inputLocal);
            //图片在服务器上的url
            String url = ftpPath.replace("/home/ftpadmin/emall", "http://192.168.153.130") + newFileName;
            urlList.add(url);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return inputLocal;
    }

    /**
     * 随机生成文件名称
     *
     * @param primitiveFileName
     * @return
     */
    public String getFileName(String primitiveFileName) {
        //使用uuid生成文件名
        String fileName = String.valueOf(snowflakeIdWorker.nextId());
        //获取文件后缀
        String suffix = primitiveFileName.substring(primitiveFileName.lastIndexOf("."));

        return fileName + suffix;
    }

    /**
     * 删除临时文件夹下所有文件
     *
     * @param dir
     */
    public void delAllFile(File dir) {
        if (!dir.exists()) {
            return;
        } else if (!dir.isDirectory()) {
            return;
        }

        String[] tempList = dir.list();
        if (tempList == null) {
            return;
        }

        File temp;
        String path = dir.getPath();
        for (String s : tempList) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + s);
            } else {
                temp = new File(path + File.separator + s);
            }
            temp.delete();
        }
    }

    public boolean pull(String goodsId) {
        String goodsKey = RedisKeyUtil.GOODS_PREFIX + goodsId;
        if (redisTemplate.hasKey(goodsKey)) {
            redisTemplate.delete(goodsKey);
        }
        return goodsMapper.pull(goodsId) != 0;
    }

    public boolean put(String goodsId) {
        String goodsKey = RedisKeyUtil.GOODS_PREFIX + goodsId;
        if (redisTemplate.hasKey(goodsKey)) {
            redisTemplate.delete(goodsKey);
        }
        return goodsMapper.put(goodsId) != 0;
    }
}