/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.153.130
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : 192.168.153.130:3306
 Source Schema         : emall

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 12/08/2019 00:31:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`
(
    `cart_item_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车明细id',
    `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车用户id',
    `goods_id`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品id',
    `goods_count`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品数量',
    `goods_price`        decimal(65, 2)                                          NOT NULL COMMENT '购物车商品价格',
    `goods_image`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品图片地址',
    `cart_item_subtotal` decimal(65, 2)                                          NOT NULL COMMENT '购物车明细小计',
    PRIMARY KEY (`cart_item_id`) USING BTREE,
    INDEX `user_id` (`user_id`) USING BTREE COMMENT '购物车用户id索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为购物车明细表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`
(
    `category_id`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别id',
    `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别名称',
    PRIMARY KEY (`category_id`) USING BTREE,
    UNIQUE INDEX `category_name` (`category_name`) USING BTREE COMMENT '商品类别名称唯一索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为商品类别表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category`
VALUES ('609417220304404480', '3C配件');
INSERT INTO `category`
VALUES ('609417374889672704', '内衣');
INSERT INTO `category`
VALUES ('609416868628791296', '冰箱');
INSERT INTO `category`
VALUES ('609417553567023104', '半成品菜');
INSERT INTO `category`
VALUES ('609417258346741760', '女装');
INSERT INTO `category`
VALUES ('609417278848499712', '帽子');
INSERT INTO `category`
VALUES ('609417150616043520', '平板电脑');
INSERT INTO `category`
VALUES ('609417336595677184', '手提包');
INSERT INTO `category`
VALUES ('609417120333168640', '手机');
INSERT INTO `category`
VALUES ('609417176427790336', '数码相机');
INSERT INTO `category`
VALUES ('609417303360012288', '旅行箱');
INSERT INTO `category`
VALUES ('609416915500138496', '洗衣机');
INSERT INTO `category`
VALUES ('609416971783503872', '热水器');
INSERT INTO `category`
VALUES ('609417511527514112', '生鲜');
INSERT INTO `category`
VALUES ('609416894931271680', '电视');
INSERT INTO `category`
VALUES ('609417667182329856', '白酒');
INSERT INTO `category`
VALUES ('609416948245069824', '空调');
INSERT INTO `category`
VALUES ('609417039383101440', '笔记本电脑');
INSERT INTO `category`
VALUES ('609417688522948608', '红酒');
INSERT INTO `category`
VALUES ('609417782689267712', '进口洋酒');
INSERT INTO `category`
VALUES ('609417628733145088', '进口牛奶');
INSERT INTO `category`
VALUES ('609417584911056896', '速冻专区');
INSERT INTO `category`
VALUES ('609417488584671232', '零食');
INSERT INTO `category`
VALUES ('609417715861422080', '饮料');
INSERT INTO `category`
VALUES ('609417753731792896', '鸡尾酒');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`
(
    `goods_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品id',
    `goods_name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
    `goods_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品描述',
    `category_id`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别id',
    `goods_price`    decimal(65, 2)                                          NOT NULL COMMENT '商品价格',
    `goods_stock`    int(255)                                                NOT NULL COMMENT '商品库存',
    `goods_image`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片地址',
    `goods_details`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情',
    `goods_status`   int(255)                                                NOT NULL COMMENT '商品状态',
    `goods_activity` int(255)                                                NOT NULL COMMENT '商品活动',
    PRIMARY KEY (`goods_id`) USING BTREE,
    INDEX `goods_name` (`goods_name`) USING BTREE COMMENT '商品名称索引',
    INDEX `goods_status` (`goods_status`) USING BTREE COMMENT '商品状态索引',
    INDEX `category_id` (`category_id`) USING BTREE COMMENT '商品类别id索引',
    INDEX `goods_activity` (`goods_activity`) USING BTREE COMMENT '商品活动索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为商品表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods`
VALUES ('609418584468226048', 'Apple iPhone XS Max 64GB 深空灰色 移动联通电信4G手机 双卡双待', '新一代iPhone！6.5英寸大屏旗舰，A12仿生芯片流畅体验，支持双卡！',
        '609417120333168640', 7899.00, 100, 'http://192.168.153.130/images/2019/08/09/609418584409505792.jpg',
        'http://192.168.153.130/images/2019/08/09/609418584409505793.jpg', 0, 1);
INSERT INTO `goods`
VALUES ('609419030247243776', 'Apple iPhone XR 64GB 白色 移动联通电信4G手机 双卡双待', '6.1英寸视网膜显示屏，A12仿生芯片，面容识别，无线充电，支持双卡！',
        '609417120333168640', 4899.00, 100, 'http://192.168.153.130/images/2019/08/09/609419030213689344.jpg',
        'http://192.168.153.130/images/2019/08/09/609419030213689345.jpg', 0, 0);
INSERT INTO `goods`
VALUES ('609419407587803136', 'Apple iPhone XS 64GB 金色 移动联通电信4G手机', 'XS采用A12仿生芯片，更强大的全面屏，更出色的iPhone！',
        '609417120333168640', 7399.00, 100, 'http://192.168.153.130/images/2019/08/09/609419407545860096.jpg',
        'http://192.168.153.130/images/2019/08/09/609419407545860097.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609419744935673856', '一加 OnePlus 7 Pro', '2K+90Hz 流体屏 骁龙855旗舰 4800万超广角三摄 8GB+256GB 星雾蓝 全面屏拍照游戏手机',
        '609417120333168640', 4499.00, 100, 'http://192.168.153.130/images/2019/08/09/609419744822427648.jpg',
        'http://192.168.153.130/images/2019/08/09/609419744822427649.jpg', 0, 0);
INSERT INTO `goods`
VALUES ('609420269345308672', '华为 HUAWEI nova 5i Pro', '前置3200万人像超级夜景4800万AI四摄极点全面屏6GB+128GB翡冷翠全网通双4G手机',
        '609417120333168640', 2199.00, 100, 'http://192.168.153.130/images/2019/08/09/609420269194313728.jpg',
        'http://192.168.153.130/images/2019/08/09/609420269194313729.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609420471418486784', '华为 HUAWEI 麦芒 8', '超广角AI三摄 高清珍珠屏 大存储 6GB+128GB 幻夜黑 全网通双4G手机', '609417120333168640',
        1699.00, 100, 'http://192.168.153.130/images/2019/08/09/609420471313629184.jpg',
        'http://192.168.153.130/images/2019/08/09/609420471313629185.jpg', 0, 0);
INSERT INTO `goods`
VALUES ('609420987007500288', '华为 HUAWEI P30 Pro', '超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB极光色全网通版双4G手机',
        '609417120333168640', 4988.00, 100, 'http://192.168.153.130/images/2019/08/09/609420986760036352.jpg',
        'http://192.168.153.130/images/2019/08/09/609420986760036353.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609421425396154368', '华为 HUAWEI P20', 'AI智慧徕卡双摄全面屏游戏手机 6GB+64GB 极光色 全网通移动联通电信4G手机 双卡双待', '609417120333168640',
        2758.00, 100, 'http://192.168.153.130/images/2019/08/09/609421425228382208.jpg',
        'http://192.168.153.130/images/2019/08/09/609421425228382209.jpg', 0, 0);
INSERT INTO `goods`
VALUES ('609421744234561536', '华为 HUAWEI Mate20 X (5G)', '7nm工艺5G旗舰芯片全面屏超大广角徕卡三摄8GB+256GB翡冷翠5G双模全网通手机',
        '609417120333168640', 6199.00, 100, 'http://192.168.153.130/images/2019/08/09/609421744037429248.jpg',
        'http://192.168.153.130/images/2019/08/09/609421744037429249.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609422172431056896', '华为 HUAWEI Mate 20 Pro', '屏内指纹版麒麟980芯片全面屏超大广角徕卡三摄8GB+128GB极光色全网通双4G手机',
        '609417120333168640', 5099.00, 100, 'http://192.168.153.130/images/2019/08/09/609422172334587904.jpg',
        'http://192.168.153.130/images/2019/08/09/609422172334587905.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609422552434999296', 'OPPO K3', '高通骁龙710 升降摄像头 VOOC闪充 6GB+64GB 电波蓝 全网通4G 全面屏拍照游戏智能手机', '609417120333168640',
        1499.00, 100, 'http://192.168.153.130/images/2019/08/11/610227318928965632.jpg',
        'http://192.168.153.130/images/2019/08/11/610227374172143616.jpg', 0, 0);
INSERT INTO `goods`
VALUES ('609422911064768512', 'OPPO Reno', '4800万超清像素 NFC 超清夜景 8GB+256GB 雾海绿 全网通 双卡双待手机 全面屏拍照游戏智能手机',
        '609417120333168640', 2999.00, 100, 'http://192.168.153.130/images/2019/08/09/609422911014436864.jpg',
        'http://192.168.153.130/images/2019/08/09/609422911014436865.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609423197086941184', 'OPPO R17 Pro', '全面屏拍照手机 6GB+128GB 雾光渐变 全网通移动联通电信4G手机 双卡双待', '609417120333168640',
        2699.00, 100, 'http://192.168.153.130/images/2019/08/09/609423197049192448.jpg',
        'http://192.168.153.130/images/2019/08/09/609423197049192449.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609423585345273856', 'OPPO Find X', '冰珀蓝 8GB+256GB 全网通 移动联通电信全网通4G 双卡双待手机', '609417120333168640', 5499.00, 100,
        'http://192.168.153.130/images/2019/08/09/609423585307525120.jpg',
        'http://192.168.153.130/images/2019/08/09/609423585307525121.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609424249760776192', 'vivo X27', '8GB+128GB大内存 雀羽蓝 零界全面屏AI三摄 移动联通电信全网通4G手机', '609417120333168640', 2698.00,
        100, 'http://192.168.153.130/images/2019/08/09/609424249681084416.jpg',
        'http://192.168.153.130/images/2019/08/09/609424249681084417.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('609425717100281856', '小米9 SE', '4800万超广角三摄 骁龙712 水滴全面屏 游戏智能拍照手机 6GB+64GB 全息幻彩蓝 全网通4G双卡双待',
        '609417120333168640', 1799.00, 100, 'http://192.168.153.130/images/2019/08/09/609425717037367296.jpg',
        'http://192.168.153.130/images/2019/08/09/609425717037367297.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('610149310432018432', 'Apple 2019新品 Macbook Pro 15.4', '九代八核i9 16G 512G 深空灰 笔记本电脑 轻薄本【带触控栏】',
        '609417039383101440', 20399.00, 100, 'http://192.168.153.130/images/2019/08/11/610149309567991808.jpg',
        'http://192.168.153.130/images/2019/08/11/610149309567991809.jpg', 1, 0);
INSERT INTO `goods`
VALUES ('610217472913571840', 'Apple 2019新品 Macbook Pro 13.3', '八代i5 8G 256G 深空灰 苹果笔记本电脑 轻薄本【带触控栏】',
        '609417039383101440', 13099.00, 100, 'http://192.168.153.130/images/2019/08/11/610217472674496512.jpg',
        'http://192.168.153.130/images/2019/08/11/610217472787742720.jpg', 0, 0);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`
(
    `order_id`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
    `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单用户id',
    `order_payment`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单总付款',
    `order_status`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单状态',
    `order_create_time`  timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '订单创建时间',
    `order_payment_time` timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '订单支付时间',
    `order_send_time`    timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '订单商品发货时间',
    `order_end_time`     timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '订单完成时间',
    PRIMARY KEY (`order_id`) USING BTREE,
    INDEX `user_id` (`user_id`) USING BTREE COMMENT '订单用户id索引',
    INDEX `order_status` (`order_status`) USING BTREE COMMENT '订单状态索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为订单表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`
(
    `order_item_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单明细id',
    `order_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
    `goods_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品id',
    `goods_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品名称',
    `goods_image`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品图片地址',
    `goods_price`         decimal(65, 2)                                          NOT NULL COMMENT '订单商品价格',
    `goods_count`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品数量',
    `order_item_subtotal` decimal(65, 2)                                          NOT NULL COMMENT '订单明细小计',
    PRIMARY KEY (`order_item_id`) USING BTREE,
    UNIQUE INDEX `order_id` (`order_id`) USING BTREE COMMENT '订单id唯一索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为订单明细表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for seckill_goods
-- ----------------------------
DROP TABLE IF EXISTS `seckill_goods`;
CREATE TABLE `seckill_goods`
(
    `seckill_goods_id`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品id',
    `goods_id`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品id',
    `seckill_goods_name`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品名称',
    `seckill_goods_describe`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品描述',
    `seckill_goods_stock`      int(255)                                                NOT NULL COMMENT '秒杀商品库存',
    `seckill_goods_price`      decimal(65, 2)                                          NOT NULL COMMENT '秒杀商品价格',
    `seckill_goods_image`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品图片',
    `seckill_goods_details`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品详情',
    `seckill_goods_start_time` timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '秒杀开始时间',
    `seckill_goods_end_time`   timestamp(0)                                            NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '秒杀结束时间',
    `seckill_goods_status`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品状态',
    PRIMARY KEY (`seckill_goods_id`) USING BTREE,
    INDEX `seckill_goods_status` (`seckill_goods_status`) USING BTREE COMMENT '秒杀商品状态索引',
    UNIQUE INDEX `goods_id` (`goods_id`) USING BTREE COMMENT '商品id唯一索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为秒杀商品表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for seckill_order
-- ----------------------------
DROP TABLE IF EXISTS `seckill_order`;
CREATE TABLE `seckill_order`
(
    `seckill_order_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀订单id',
    `order_id`         varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '订单id',
    `user_id`          varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '秒杀订单用户id',
    `seckill_goods_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '秒杀商品id',
    PRIMARY KEY (`seckill_order_id`) USING BTREE,
    UNIQUE INDEX `order_id` (`order_id`) USING BTREE COMMENT '订单id索引',
    INDEX `user_id` (`user_id`) USING BTREE COMMENT '秒杀用户id索引',
    INDEX `seckill_goods_id` (`seckill_goods_id`) USING BTREE COMMENT '秒杀商品id索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为秒杀订单表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping`
(
    `shipping_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货信息id',
    `user_id`                varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货地址用户id',
    `shipping_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人名称',
    `shipping_mobile_number` int(255)                                                NOT NULL COMMENT '收货人手机号码',
    `shipping_address`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货详细地址',
    PRIMARY KEY (`shipping_id`) USING BTREE,
    INDEX `user_id` (`user_id`) USING BTREE COMMENT '收货地址用户id索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为收货地址表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
    `user_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
    `user_password`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
    `user_sex`           int(255)                                                NOT NULL COMMENT '用户性别',
    `user_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户手机号码',
    `user_role`          int(255)                                                NOT NULL COMMENT '用户角色',
    `user_salt`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码盐值',
    PRIMARY KEY (`user_id`) USING BTREE,
    UNIQUE INDEX `user_name` (`user_name`) USING BTREE COMMENT '用户名称唯一索引',
    INDEX `user_role` (`user_role`) USING BTREE COMMENT '用户角色索引'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '此表为用户表。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES ('605196406440853504', 'jason', 'f2d048a64a44c49324ee88c7df1d85ea687b5d711981aab8866918af68950c23', 1,
        '13096383242', 0, '91c4f002482e96ce7b178ea6703a04e0');
INSERT INTO `user`
VALUES ('605210786658254848', 'martin', '1e62c6ac6d44bf9ac0d4c236253d0ace274d0219a90d4594552e557938e85e91', 1,
        '13096383242', 0, 'aea6ecc9c5f7f88e92175cfb18e49379');
INSERT INTO `user`
VALUES ('605211133124542464', 'avicii', '6ea7067d466ee427dce601b7c2ec9b7339fca633dd693e62966bcf33b57fb14d', 1,
        '18584839287', 0, '532a33db8091d760436163ba208d7c45');
INSERT INTO `user`
VALUES ('605211886136328192', 'lily', '53fb5de5de68a8641099ca76ea107d0d5ad54c43cb1a5db6bdb3ec9207aaabd0', 1,
        '13096383242', 0, '40030bb1c809b9667bad0fb5eb73c43e');
INSERT INTO `user`
VALUES ('605212038012076032', 'akali', 'ef648b0e933ba6fca806e0f5423580a732690ac6cde7c4d69866fef3926f1b44', 1,
        '13096383242', 0, 'e92d5251962ee1d14b588468f67c6146');
INSERT INTO `user`
VALUES ('605212753275125760', 'bibi', '28e45ab3c1aad6450b201c6902ddef92ddad23766c8ede0dc11db7e1fb4ca16b', 1,
        '13096383242', 0, '0b9270e3a900f1cd305ea218765fe204');
INSERT INTO `user`
VALUES ('605214000254287872', 'kiki', 'a0638b63484ee975c336ac9004d2f3ad0ddb16162acbcc162e4292975fc2c242', 1,
        '13096383242', 0, 'fae93d1cb1fcc8f22ac2300a5b5fe138');
INSERT INTO `user`
VALUES ('605215057864818688', 'miko', 'ef708a3e7461f4ad9388e0fae4dc7c077adc1108d3d9fc70534bfcceee9c6b0a', 1,
        '18584839287', 0, 'ae85f3330a9eebd2bd16be46f2dac7ba');
INSERT INTO `user`
VALUES ('605902437106057216', 'admin', '38cdaa5ea08fe82297175cef94a82765c05cdc9cd3f8508c74a255641eadab6b', 1,
        '18584839287', 1, 'fa9526430cfb1ed2f2b7822c99658150');
INSERT INTO `user`
VALUES ('607288353687076864', 'siliy', '8343053de3a74b80ab648ca35b3b9f680d5d393700cdb0badfac93998e498876', 1,
        '13096383242', 0, 'b9015affe33e98b48e7cc2f0a9783ca2');
INSERT INTO `user`
VALUES ('607288471131783168', 'marry', 'bdfd935ccbce53e73d04507634b1002f2162aa9294ea5e817abbc16fb6480a9e', 1,
        '18584839287', 0, '1fdbca7f9396cb8882ecd187ddd6f376');
INSERT INTO `user`
VALUES ('607289081470124032', 'easy', '4aa074e53a0ade599cee79e08adf0be226af443d129ca75322824c8410adf7e5', 1,
        '13096383242', 0, 'b4013aa9a32927c9962c21cf74d27ebc');
INSERT INTO `user`
VALUES ('607290526634344448', 'open', 'a0e622bc1383b70a673a3f0c21e7928fce47d651d124b64730a39d85e5388367', 1,
        '13096383242', 0, '273857ac9c1fdcc9494ac1f51a0dab1b');
INSERT INTO `user`
VALUES ('610133241646546944', 'xxx', 'fbe1ec0d626c801f0e7625202254b9f96aa68615eecf5722e37dcd935dc354de', 1,
        '18584839287', 0, 'e6a20646a4b4aafbf400e2c1ca43ee2c');

SET FOREIGN_KEY_CHECKS = 1;
