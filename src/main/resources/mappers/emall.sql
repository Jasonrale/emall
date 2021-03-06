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

 Date: 28/02/2020 03:45:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`  (
                              `cart_item_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车明细id',
                              `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车用户id',
                              `goods_id`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品id',
                              `goods_name`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品名称',
                              `goods_count`        int(255)                                                NOT NULL COMMENT '购物车商品数量',
                              `goods_price`        decimal(65, 2)                                          NOT NULL COMMENT '购物车商品价格',
                              `goods_image`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购物车商品图片地址',
                              `cart_item_subtotal` decimal(65, 2)                                          NOT NULL COMMENT '购物车明细小计',
                              PRIMARY KEY (`cart_item_id`) USING BTREE,
                              INDEX `idx_user_id` (`user_id`) USING BTREE COMMENT '购物车用户id索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为购物车明细表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_item
-- ----------------------------
INSERT INTO `cart_item`
VALUES ('682442747201716224', '605210786658254848', '609419030247243776', 'Apple iPhone XR 64GB 白色 移动联通电信4G手机 双卡双待', 1,
        4899.00, 'http://192.168.153.130/images/2019/08/09/609419030213689344.jpg', 4899.00);
INSERT INTO `cart_item`
VALUES ('682442767841886208', '605210786658254848', '609423585345273856', 'OPPO Find X 全网通4G手机', 1, 5499.00,
        'http://192.168.153.130/images/2019/08/09/609423585307525120.jpg', 5499.00);
INSERT INTO `cart_item`
VALUES ('682442782366760960', '605210786658254848', '612293309745856512', '三星 Galaxy Note10+5G 全网通5G手机', 1, 10999.00,
        'http://192.168.153.130/images/2019/08/17/612293309640998912.jpg', 10999.00);
INSERT INTO `cart_item`
VALUES ('682442851224649728', '605210786658254848', '611673381086953472', 'Apple iPad mini 5 2019年新款平板电脑', 1, 2888.00,
        'http://192.168.153.130/images/2019/08/15/611673380227121152.jpg', 2888.00);
INSERT INTO `cart_item`
VALUES ('682790448917381120', '605196406440853504', '609420471418486784', '华为 HUAWEI 麦芒 8 全网通双4G手机', 1, 1699.00,
        'http://192.168.153.130/images/2019/08/09/609420471313629184.jpg', 1699.00);
INSERT INTO `cart_item`
VALUES ('682791037927686144', '605196406440853504', '609419407587803136', 'Apple iPhone XS 64GB 金色 移动联通电信4G手机', 1,
        7399.00, 'http://192.168.153.130/images/2020/02/26/682144970391420928.jpg', 7399.00);
INSERT INTO `cart_item`
VALUES ('682791054545518592', '605196406440853504', '609419744935673856', '一加 OnePlus 7 Pro全网通4G手机', 1, 4499.00,
        'http://192.168.153.130/images/2019/08/09/609419744822427648.jpg', 4499.00);
INSERT INTO `cart_item`
VALUES ('682794052583686144', '605211133124542464', '609420471418486784', '华为 HUAWEI 麦芒 8 全网通双4G手机', 1, 1699.00,
        'http://192.168.153.130/images/2019/08/09/609420471313629184.jpg', 1699.00);
INSERT INTO `cart_item`
VALUES ('682794079192350720', '605211133124542464', '609422552434999296', 'OPPO K3 全网通4G手机', 2, 1499.00,
        'http://192.168.153.130/images/2019/08/11/610227318928965632.jpg', 2998.00);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
                             `category_id`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别id',
                             `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别名称',
                             PRIMARY KEY (`category_id`) USING BTREE,
                             UNIQUE INDEX `idx_category_name` (`category_name`) USING BTREE COMMENT '商品类别名称唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为商品类别表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('609417220304404480', '3C配件');
INSERT INTO `category` VALUES ('609417374889672704', '内衣');
INSERT INTO `category` VALUES ('609416868628791296', '冰箱');
INSERT INTO `category` VALUES ('609417553567023104', '半成品菜');
INSERT INTO `category` VALUES ('609417150616043520', '平板电脑');
INSERT INTO `category` VALUES ('609417336595677184', '手提包');
INSERT INTO `category` VALUES ('609417120333168640', '手机');
INSERT INTO `category` VALUES ('609417176427790336', '数码相机');
INSERT INTO `category` VALUES ('609417303360012288', '旅行箱');
INSERT INTO `category` VALUES ('609416915500138496', '洗衣机');
INSERT INTO `category` VALUES ('609416971783503872', '热水器');
INSERT INTO `category` VALUES ('609417511527514112', '生鲜');
INSERT INTO `category` VALUES ('609416894931271680', '电视');
INSERT INTO `category` VALUES ('609417667182329856', '白酒');
INSERT INTO `category` VALUES ('609416948245069824', '空调');
INSERT INTO `category` VALUES ('609417039383101440', '笔记本电脑');
INSERT INTO `category` VALUES ('609417688522948608', '红酒');
INSERT INTO `category` VALUES ('609417258346741760', '衣服');
INSERT INTO `category` VALUES ('609417782689267712', '进口洋酒');
INSERT INTO `category` VALUES ('609417628733145088', '进口牛奶');
INSERT INTO `category` VALUES ('609417584911056896', '速冻专区');
INSERT INTO `category` VALUES ('609417488584671232', '零食');
INSERT INTO `category` VALUES ('609417278848499712', '鞋子');
INSERT INTO `category` VALUES ('609417715861422080', '饮料');
INSERT INTO `category` VALUES ('609417753731792896', '鸡尾酒');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
                          `goods_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品id',
                          `goods_name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
                          `goods_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品描述',
                          `category_id`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类别id',
                          `goods_price`    decimal(65, 2)                                          NOT NULL COMMENT '商品价格',
                          `goods_stock`    int(255)                                                NOT NULL COMMENT '商品库存',
                          `goods_image`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片地址',
                          `goods_details`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情',
                          `goods_status`   int(255)                                                NOT NULL COMMENT '商品状态',
                          PRIMARY KEY (`goods_id`) USING BTREE,
                          INDEX `idx_goods_status` (`goods_status`) USING BTREE COMMENT '商品状态索引',
                          INDEX `idx_category_id` (`category_id`) USING BTREE COMMENT '商品类别id索引',
                          FULLTEXT INDEX `idx_goods_name` (`goods_name`) WITH PARSER `ngram`
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为商品表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods`
VALUES ('609418584468226048', 'Apple iPhone XS Max 64GB 深空灰色 移动联通电信4G手机 双卡双待', '新一代iPhone！6.5英寸大屏旗舰，A12仿生芯片流畅体验，支持双卡！',
        '609417120333168640', 7399.00, 93, 'http://192.168.153.130/images/2019/08/09/609418584409505792.jpg',
        'http://192.168.153.130/images/2019/08/09/609418584409505793.jpg', 1);
INSERT INTO `goods`
VALUES ('609419030247243776', 'Apple iPhone XR 64GB 白色 移动联通电信4G手机 双卡双待', '6.1英寸视网膜显示屏，A12仿生芯片，面容识别，无线充电，支持双卡！',
        '609417120333168640', 4899.00, 92, 'http://192.168.153.130/images/2019/08/09/609419030213689344.jpg',
        'http://192.168.153.130/images/2019/08/09/609419030213689345.jpg', 1);
INSERT INTO `goods`
VALUES ('609419407587803136', 'Apple iPhone XS 64GB 金色 移动联通电信4G手机', 'XS采用A12仿生芯片，更强大的全面屏，更出色的iPhone！',
        '609417120333168640', 7399.00, 97, 'http://192.168.153.130/images/2020/02/26/682144970391420928.jpg',
        'http://192.168.153.130/images/2019/08/09/609419407545860097.jpg', 1);
INSERT INTO `goods`
VALUES ('609419744935673856', '一加 OnePlus 7 Pro全网通4G手机', '2K+90Hz 流体屏 骁龙855旗舰 4800万超广角三摄 8GB+256GB 星雾蓝 全面屏拍照游戏手机',
        '609417120333168640', 4499.00, 97, 'http://192.168.153.130/images/2019/08/09/609419744822427648.jpg',
        'http://192.168.153.130/images/2019/08/09/609419744822427649.jpg', 1);
INSERT INTO `goods`
VALUES ('609420269345308672', '华为 HUAWEI nova 5i Pro全网通双4G手机', '前置3200万人像超级夜景4800万AI四摄极点全面屏6GB+128GB翡冷翠',
        '609417120333168640', 2199.00, 95, 'http://192.168.153.130/images/2019/08/09/609420269194313728.jpg',
        'http://192.168.153.130/images/2019/08/09/609420269194313729.jpg', 1);
INSERT INTO `goods` VALUES ('609420471418486784', '华为 HUAWEI 麦芒 8 全网通双4G手机', '超广角AI三摄 高清珍珠屏 大存储 6GB+128GB 幻夜黑 ', '609417120333168640', 1699.00, 100, 'http://192.168.153.130/images/2019/08/09/609420471313629184.jpg', 'http://192.168.153.130/images/2019/08/09/609420471313629185.jpg', 1);
INSERT INTO `goods`
VALUES ('609420987007500288', '华为 HUAWEI P30 Pro 全网通版双4G手机', '超感光徕卡四摄10倍混合变焦麒麟980芯片屏内指纹 8GB+128GB极光色',
        '609417120333168640', 4988.00, 99, 'http://192.168.153.130/images/2019/08/09/609420986760036352.jpg',
        'http://192.168.153.130/images/2019/08/09/609420986760036353.jpg', 0);
INSERT INTO `goods`
VALUES ('609421425396154368', '华为 HUAWEI P20全网通双4G手机', 'AI智慧徕卡双摄全面屏游戏手机 6GB+64GB 极光色  双卡双待', '609417120333168640',
        2758.00, 97, 'http://192.168.153.130/images/2019/08/09/609421425228382208.jpg',
        'http://192.168.153.130/images/2019/08/09/609421425228382209.jpg', 1);
INSERT INTO `goods`
VALUES ('609421744234561536', '华为 HUAWEI Mate20 X (5G) 双模全网通手机', '7nm工艺5G旗舰芯片全面屏超大广角徕卡三摄8GB+256GB翡冷翠5G',
        '609417120333168640', 6199.00, 96, 'http://192.168.153.130/images/2019/08/09/609421744037429248.jpg',
        'http://192.168.153.130/images/2019/08/09/609421744037429249.jpg', 1);
INSERT INTO `goods`
VALUES ('609422172431056896', '华为 HUAWEI Mate 20 Pro 全网通双4G手机', '屏内指纹版麒麟980芯片全面屏超大广角徕卡三摄8GB+128GB极光色',
        '609417120333168640', 5099.00, 99, 'http://192.168.153.130/images/2019/08/09/609422172334587904.jpg',
        'http://192.168.153.130/images/2019/08/09/609422172334587905.jpg', 1);
INSERT INTO `goods`
VALUES ('609422552434999296', 'OPPO K3 全网通4G手机', '高通骁龙710 升降摄像头 VOOC闪充 6GB+64GB 电波蓝  全面屏拍照游戏智能手机', '609417120333168640',
        1499.00, 99, 'http://192.168.153.130/images/2019/08/11/610227318928965632.jpg',
        'http://192.168.153.130/images/2019/08/11/610227374172143616.jpg', 1);
INSERT INTO `goods`
VALUES ('609422911064768512', 'OPPO Reno 全面屏拍照游戏智能手机', '4800万超清像素 NFC 超清夜景 8GB+256GB 雾海绿 全网通 双卡双待手机 ',
        '609417120333168640', 2999.00, 99, 'http://192.168.153.130/images/2019/08/09/609422911014436864.jpg',
        'http://192.168.153.130/images/2019/08/09/609422911014436865.jpg', 1);
INSERT INTO `goods`
VALUES ('609423197086941184', 'OPPO R17 Pro 全网通4G手机', '全面屏拍照手机 6GB+128GB 雾光渐变  双卡双待', '609417120333168640', 2699.00, 96,
        'http://192.168.153.130/images/2019/08/09/609423197049192448.jpg',
        'http://192.168.153.130/images/2019/08/09/609423197049192449.jpg', 0);
INSERT INTO `goods`
VALUES ('609423585345273856', 'OPPO Find X 全网通4G手机', '冰珀蓝 8GB+256GB  双卡双待手机', '609417120333168640', 5499.00, 99,
        'http://192.168.153.130/images/2019/08/09/609423585307525120.jpg',
        'http://192.168.153.130/images/2019/08/09/609423585307525121.jpg', 0);
INSERT INTO `goods`
VALUES ('609424249760776192', 'vivo X27 全网通4G手机', '8GB+128GB大内存 雀羽蓝 零界全面屏AI三摄 ', '609417120333168640', 2698.00, 98,
        'http://192.168.153.130/images/2019/08/09/609424249681084416.jpg',
        'http://192.168.153.130/images/2019/08/09/609424249681084417.jpg', 1);
INSERT INTO `goods`
VALUES ('609425717100281856', '小米9 SE 全网通4G手机', '4800万超广角三摄 骁龙712 水滴全面屏 游戏智能拍照手机 6GB+64GB 全息幻彩蓝', '609417120333168640',
        1799.00, 94, 'http://192.168.153.130/images/2019/08/09/609425717037367296.jpg',
        'http://192.168.153.130/images/2019/08/09/609425717037367297.jpg', 1);
INSERT INTO `goods`
VALUES ('610149310432018432', 'Apple 2019新品 Macbook Pro 15.4  笔记本电脑', '九代八核i9 16G 512G 深空灰 笔记本电脑 轻薄本【带触控栏】',
        '609417039383101440', 20399.00, 95, 'http://192.168.153.130/images/2019/08/11/610149309567991808.jpg',
        'http://192.168.153.130/images/2019/08/11/610149309567991809.jpg', 1);
INSERT INTO `goods`
VALUES ('610217472913571840', 'Apple 2019新品 Macbook Pro 13.3  笔记本电脑', '八代i5 8G 256G 深空灰 苹果笔记本电脑 轻薄本【带触控栏】',
        '609417039383101440', 13099.00, 98, 'http://192.168.153.130/images/2019/08/11/610217472674496512.jpg',
        'http://192.168.153.130/images/2019/08/11/610217472787742720.jpg', 1);
INSERT INTO `goods`
VALUES ('611673381086953472', 'Apple iPad mini 5 2019年新款平板电脑', '7.9英寸（64G WLAN版/A12芯片 MUQY2CH/A）金色',
        '609417150616043520', 2888.00, 90, 'http://192.168.153.130/images/2019/08/15/611673380227121152.jpg',
        'http://192.168.153.130/images/2019/08/15/611673380667523072.jpg', 1);
INSERT INTO `goods`
VALUES ('611685537438236672', '华为平板电脑 M6 10.8英寸', '麒麟980影音娱乐平板电脑4GB+128GB WiFi（香槟金）', '609417150616043520', 2699.00, 99,
        'http://192.168.153.130/images/2019/08/15/611685537098498048.jpg',
        'http://192.168.153.130/images/2019/08/15/611685537316601856.jpg', 1);
INSERT INTO `goods`
VALUES ('612291425505116160', '荣耀V20 游戏手机', ' 麒麟980芯片 魅眼全视屏 4800万深感相机 6GB+128GB 幻影蓝 移动联通电信4G全面屏手机',
        '609417120333168640', 2099.00, 95, 'http://192.168.153.130/images/2019/08/17/612291425354121216.jpg',
        'http://192.168.153.130/images/2019/08/17/612291425396064256.jpg', 0);
INSERT INTO `goods`
VALUES ('612291962610909184', 'vivo Z5 6GB+128GB 全网通4G手机', '极光幻境 4800万超广角AI三摄手机 22.5W快充 4500mAh大电池',
        '609417120333168640', 1898.00, 90, 'http://192.168.153.130/images/2019/08/17/612291962531217408.jpg',
        'http://192.168.153.130/images/2019/08/17/612291962564771840.jpg', 1);
INSERT INTO `goods`
VALUES ('612292618377756672', 'vivo X27Pro 8GB+256GB大内存 全网通4G手机', '黑珍珠 4800万AI三摄全面屏拍照手机', '609417120333168640', 3598.00,
        98, 'http://192.168.153.130/images/2019/08/17/612292618272899072.jpg',
        'http://192.168.153.130/images/2019/08/17/612292618319036416.jpg', 1);
INSERT INTO `goods`
VALUES ('612293309745856512', '三星 Galaxy Note10+5G 全网通5G手机', '12GB+256GB 莫奈彩 (SM-N9760）智能S pen 骁龙855双卡双待',
        '609417120333168640', 10999.00, 100, 'http://192.168.153.130/images/2019/08/17/612293309640998912.jpg',
        'http://192.168.153.130/images/2019/08/17/612293309666164736.jpg', 1);
INSERT INTO `goods`
VALUES ('612293817084674048', '三星 Galaxy A80 8GB+128GB 全网通4G手机', '太空黑 （SM-A8050） 180°炫转三摄 骁龙730G 全网通4G 双卡双待手机',
        '609417120333168640', 3799.00, 99, 'http://192.168.153.130/images/2019/08/17/612293816992399360.jpg',
        'http://192.168.153.130/images/2019/08/17/612293817034342400.jpg', 1);
INSERT INTO `goods`
VALUES ('612294174229659648', '三星 Galaxy S10 8GB+128GB 全网通4G游戏手机', '皓玉白（SM-G9730）超感官全视屏骁龙855双卡双待', '609417120333168640',
        5999.00, 98, 'http://192.168.153.130/images/2019/08/17/612294172551938048.jpg',
        'http://192.168.153.130/images/2019/08/17/612294172581298176.jpg', 1);
INSERT INTO `goods`
VALUES ('612298026198761472', '惠普（HP）战99-74 15.6英寸 工作站 设计本 笔记本', 'E-2176M/16GB*2/1TSSD+2T/Win10 Pro/4G独显/4K屏',
        '609417039383101440', 18499.00, 95, 'http://192.168.153.130/images/2019/08/17/612298026081320960.jpg',
        'http://192.168.153.130/images/2019/08/17/612298026119069696.jpg', 1);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
                          `order_id`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
                          `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单用户id',
                          `order_payment`      decimal(65, 2)                                          NOT NULL COMMENT '订单总付款',
                          `order_status`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单状态',
                          `order_create_time`  timestamp(0)                                            NOT NULL COMMENT '订单创建时间',
                          `order_payment_time` timestamp(0)                                            NULL DEFAULT NULL COMMENT '订单支付时间',
                          `order_send_time`    timestamp(0)                                            NULL DEFAULT NULL COMMENT '订单商品发货时间',
                          `order_end_time`     timestamp(0)                                            NULL DEFAULT NULL COMMENT '订单完成时间',
                          `shipping_id`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单收货地址',
                          PRIMARY KEY (`order_id`) USING BTREE,
                          INDEX `idx_user_id` (`user_id`) USING BTREE COMMENT '订单用户id索引',
                          INDEX `idx_order_status` (`order_status`) USING BTREE COMMENT '订单状态索引',
                          INDEX `idx_user_id_order_status` (`user_id`, `order_status`) USING BTREE COMMENT '订单用户id与订单状态联合索引',
                          INDEX `idx_user_id_order_id` (`user_id`, `order_id`) USING BTREE COMMENT '订单用户id与订单id联合索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为订单表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order`
VALUES ('682750273667465216', '605196406440853504', 7657.00, '4', '2020-02-28 00:45:50', NULL, NULL, NULL,
        '613836499053445120');
INSERT INTO `order`
VALUES ('682750312267644928', '605196406440853504', 4786.00, '1', '2020-02-28 00:45:59', NULL, NULL, NULL,
        '613847900761358336');
INSERT INTO `order`
VALUES ('682750568438956032', '605196406440853504', 6898.00, '1', '2020-02-28 00:47:00', NULL, NULL, NULL,
        '613848033091649536');
INSERT INTO `order`
VALUES ('682750606934278144', '605196406440853504', 7897.00, '1', '2020-02-28 00:47:10', NULL, NULL, NULL,
        '613836499053445120');
INSERT INTO `order`
VALUES ('682750636785139712', '605196406440853504', 7399.00, '1', '2020-02-28 00:47:17', NULL, NULL, NULL,
        '616111732397441024');
INSERT INTO `order`
VALUES ('682750666753441792', '605196406440853504', 1898.00, '2', '2020-02-28 00:47:24', '2020-02-28 02:18:18',
        '2020-02-28 03:42:28', NULL, '613836499053445120');
INSERT INTO `order`
VALUES ('682750698751787008', '605196406440853504', 10999.00, '4', '2020-02-28 00:47:31', NULL, NULL, NULL,
        '613848033091649536');
INSERT INTO `order`
VALUES ('682750741856649216', '605196406440853504', 7896.00, '3', '2020-02-28 00:47:42', '2020-02-28 02:08:47',
        '2020-02-28 03:42:31', '2020-02-28 03:43:41', '613848033091649536');
INSERT INTO `order`
VALUES ('682767599343239168', '605196406440853504', 20399.00, '0', '2020-02-28 01:54:41', '2020-02-28 02:08:11', NULL,
        NULL, '613836499053445120');
INSERT INTO `order`
VALUES ('682767657287548928', '605196406440853504', 13099.00, '0', '2020-02-28 01:54:55', '2020-02-28 03:43:30', NULL,
        NULL, '616111732397441024');
INSERT INTO `order`
VALUES ('682767680964395008', '605196406440853504', 18499.00, '1', '2020-02-28 01:55:00', NULL, NULL, NULL,
        '613836499053445120');
INSERT INTO `order`
VALUES ('682767706847444992', '605196406440853504', 2888.00, '0', '2020-02-28 01:55:07', '2020-02-28 02:08:02', NULL,
        NULL, '613847900761358336');
INSERT INTO `order`
VALUES ('682770856459370496', '605196406440853504', 3799.00, '3', '2020-02-28 02:07:37', '2020-02-28 03:37:34',
        '2020-02-28 03:42:47', '2020-02-28 03:43:24', '613847900761358336');
INSERT INTO `order`
VALUES ('682770892094177280', '605196406440853504', 6199.00, '1', '2020-02-28 02:07:46', NULL, NULL, NULL,
        '613847900761358336');
INSERT INTO `order`
VALUES ('682790509244055552', '605196406440853504', 3598.00, '3', '2020-02-28 03:25:43', '2020-02-28 03:37:26',
        '2020-02-28 03:42:49', '2020-02-28 03:43:17', '616111732397441024');
INSERT INTO `order`
VALUES ('682793377527234560', '605196406440853504', 7597.00, '1', '2020-02-28 03:37:07', NULL, NULL, NULL,
        '613836499053445120');
INSERT INTO `order`
VALUES ('682794109714300928', '605211133124542464', 7399.00, '0', '2020-02-28 03:40:01', '2020-02-28 03:41:17', NULL,
        NULL, '682449925824315392');
INSERT INTO `order`
VALUES ('682794142530535424', '605211133124542464', 20399.00, '2', '2020-02-28 03:40:09', '2020-02-28 03:41:09',
        '2020-02-28 03:42:36', NULL, '682449925824315392');
INSERT INTO `order`
VALUES ('682794168195481600', '605211133124542464', 7399.00, '0', '2020-02-28 03:40:15', '2020-02-28 03:41:03', NULL,
        NULL, '682449925824315392');
INSERT INTO `order`
VALUES ('682794197308145664', '605211133124542464', 1898.00, '3', '2020-02-28 03:40:22', '2020-02-28 03:40:54',
        '2020-02-28 03:42:38', '2020-02-28 03:44:14', '682449925824315392');
INSERT INTO `order`
VALUES ('682794219378573312', '605211133124542464', 18499.00, '3', '2020-02-28 03:40:28', '2020-02-28 03:40:43',
        '2020-02-28 03:42:40', '2020-02-28 03:44:05', '682449925824315392');
INSERT INTO `order`
VALUES ('682794240660471808', '605211133124542464', 13099.00, '3', '2020-02-28 03:40:33', '2020-02-28 03:40:48',
        '2020-02-28 03:42:43', '2020-02-28 03:43:59', '682449925824315392');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
                               `order_item_id`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单明细id',
                               `order_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
                               `goods_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品id',
                               `goods_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品名称',
                               `goods_image`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单商品图片地址',
                               `goods_price`         decimal(65, 2)                                          NOT NULL COMMENT '订单商品价格',
                               `goods_count`         int(255)                                                NOT NULL COMMENT '订单商品数量',
                               `order_item_subtotal` decimal(65, 2)                                          NOT NULL COMMENT '订单明细小计',
                               PRIMARY KEY (`order_item_id`) USING BTREE,
                               INDEX `idx_order_id` (`order_id`) USING BTREE COMMENT '订单id普通索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item`
VALUES ('682750273721991168', '682750273667465216', '609419030247243776', 'Apple iPhone XR 64GB 白色 移动联通电信4G手机 双卡双待',
        'http://192.168.153.130/images/2019/08/09/609419030213689344.jpg', 4899.00, 1, 4899.00);
INSERT INTO `order_item`
VALUES ('682750274028175360', '682750273667465216', '609421425396154368', '华为 HUAWEI P20全网通双4G手机',
        'http://192.168.153.130/images/2019/08/09/609421425228382208.jpg', 2758.00, 1, 2758.00);
INSERT INTO `order_item`
VALUES ('682750312473165824', '682750312267644928', '612291962610909184', 'vivo Z5 6GB+128GB 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612291962531217408.jpg', 1898.00, 1, 1898.00);
INSERT INTO `order_item`
VALUES ('682750312489943040', '682750312267644928', '611673381086953472', 'Apple iPad mini 5 2019年新款平板电脑',
        'http://192.168.153.130/images/2019/08/15/611673380227121152.jpg', 2888.00, 1, 2888.00);
INSERT INTO `order_item`
VALUES ('682750568598339584', '682750568438956032', '609425717100281856', '小米9 SE 全网通4G手机',
        'http://192.168.153.130/images/2019/08/09/609425717037367296.jpg', 1799.00, 1, 1799.00);
INSERT INTO `order_item`
VALUES ('682750568627699712', '682750568438956032', '609422172431056896', '华为 HUAWEI Mate 20 Pro 全网通双4G手机',
        'http://192.168.153.130/images/2019/08/09/609422172334587904.jpg', 5099.00, 1, 5099.00);
INSERT INTO `order_item`
VALUES ('682750606946861056', '682750606934278144', '612294174229659648', '三星 Galaxy S10 8GB+128GB 全网通4G游戏手机',
        'http://192.168.153.130/images/2019/08/17/612294172551938048.jpg', 5999.00, 1, 5999.00);
INSERT INTO `order_item`
VALUES ('682750607043330048', '682750606934278144', '612291962610909184', 'vivo Z5 6GB+128GB 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612291962531217408.jpg', 1898.00, 1, 1898.00);
INSERT INTO `order_item`
VALUES ('682750636910968832', '682750636785139712', '609418584468226048',
        'Apple iPhone XS Max 64GB 深空灰色 移动联通电信4G手机 双卡双待',
        'http://192.168.153.130/images/2019/08/09/609418584409505792.jpg', 7399.00, 1, 7399.00);
INSERT INTO `order_item`
VALUES ('682750666807967744', '682750666753441792', '612291962610909184', 'vivo Z5 6GB+128GB 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612291962531217408.jpg', 1898.00, 1, 1898.00);
INSERT INTO `order_item`
VALUES ('682750698760175616', '682750698751787008', '612293309745856512', '三星 Galaxy Note10+5G 全网通5G手机',
        'http://192.168.153.130/images/2019/08/17/612293309640998912.jpg', 10999.00, 1, 10999.00);
INSERT INTO `order_item`
VALUES ('682750741957312512', '682750741856649216', '609420269345308672', '华为 HUAWEI nova 5i Pro全网通双4G手机',
        'http://192.168.153.130/images/2019/08/09/609420269194313728.jpg', 2199.00, 1, 2199.00);
INSERT INTO `order_item`
VALUES ('682750741999255552', '682750741856649216', '609422911064768512', 'OPPO Reno 全面屏拍照游戏智能手机',
        'http://192.168.153.130/images/2019/08/09/609422911014436864.jpg', 2999.00, 1, 2999.00);
INSERT INTO `order_item`
VALUES ('682750742032809984', '682750741856649216', '609424249760776192', 'vivo X27 全网通4G手机',
        'http://192.168.153.130/images/2019/08/09/609424249681084416.jpg', 2698.00, 1, 2698.00);
INSERT INTO `order_item`
VALUES ('682767599368404992', '682767599343239168', '610149310432018432', 'Apple 2019新品 Macbook Pro 15.4  笔记本电脑',
        'http://192.168.153.130/images/2019/08/11/610149309567991808.jpg', 20399.00, 1, 20399.00);
INSERT INTO `order_item`
VALUES ('682767657354657792', '682767657287548928', '610217472913571840', 'Apple 2019新品 Macbook Pro 13.3  笔记本电脑',
        'http://192.168.153.130/images/2019/08/11/610217472674496512.jpg', 13099.00, 1, 13099.00);
INSERT INTO `order_item`
VALUES ('682767680981172224', '682767680964395008', '612298026198761472', '惠普（HP）战99-74 15.6英寸 工作站 设计本 笔记本',
        'http://192.168.153.130/images/2019/08/17/612298026081320960.jpg', 18499.00, 1, 18499.00);
INSERT INTO `order_item`
VALUES ('682767706860027904', '682767706847444992', '611673381086953472', 'Apple iPad mini 5 2019年新款平板电脑',
        'http://192.168.153.130/images/2019/08/15/611673380227121152.jpg', 2888.00, 1, 2888.00);
INSERT INTO `order_item`
VALUES ('682770856476147712', '682770856459370496', '612293817084674048', '三星 Galaxy A80 8GB+128GB 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612293816992399360.jpg', 3799.00, 1, 3799.00);
INSERT INTO `order_item`
VALUES ('682770892568133632', '682770892094177280', '609421744234561536', '华为 HUAWEI Mate20 X (5G) 双模全网通手机',
        'http://192.168.153.130/images/2019/08/09/609421744037429248.jpg', 6199.00, 1, 6199.00);
INSERT INTO `order_item`
VALUES ('682790509327941632', '682790509244055552', '612292618377756672', 'vivo X27Pro 8GB+256GB大内存 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612292618272899072.jpg', 3598.00, 1, 3598.00);
INSERT INTO `order_item`
VALUES ('682793377623703552', '682793377527234560', '609424249760776192', 'vivo X27 全网通4G手机',
        'http://192.168.153.130/images/2019/08/09/609424249681084416.jpg', 2698.00, 1, 2698.00);
INSERT INTO `order_item`
VALUES ('682793377804058624', '682793377527234560', '609419030247243776', 'Apple iPhone XR 64GB 白色 移动联通电信4G手机 双卡双待',
        'http://192.168.153.130/images/2019/08/09/609419030213689344.jpg', 4899.00, 1, 4899.00);
INSERT INTO `order_item`
VALUES ('682794109760438272', '682794109714300928', '609418584468226048',
        'Apple iPhone XS Max 64GB 深空灰色 移动联通电信4G手机 双卡双待',
        'http://192.168.153.130/images/2019/08/09/609418584409505792.jpg', 7399.00, 1, 7399.00);
INSERT INTO `order_item`
VALUES ('682794142664753152', '682794142530535424', '610149310432018432', 'Apple 2019新品 Macbook Pro 15.4  笔记本电脑',
        'http://192.168.153.130/images/2019/08/11/610149309567991808.jpg', 20399.00, 1, 20399.00);
INSERT INTO `order_item`
VALUES ('682794168224841728', '682794168195481600', '609419407587803136', 'Apple iPhone XS 64GB 金色 移动联通电信4G手机',
        'http://192.168.153.130/images/2020/02/26/682144970391420928.jpg', 7399.00, 1, 7399.00);
INSERT INTO `order_item`
VALUES ('682794197421391872', '682794197308145664', '612291962610909184', 'vivo Z5 6GB+128GB 全网通4G手机',
        'http://192.168.153.130/images/2019/08/17/612291962531217408.jpg', 1898.00, 1, 1898.00);
INSERT INTO `order_item`
VALUES ('682794219407933440', '682794219378573312', '612298026198761472', '惠普（HP）战99-74 15.6英寸 工作站 设计本 笔记本',
        'http://192.168.153.130/images/2019/08/17/612298026081320960.jpg', 18499.00, 1, 18499.00);
INSERT INTO `order_item`
VALUES ('682794240685637632', '682794240660471808', '610217472913571840', 'Apple 2019新品 Macbook Pro 13.3  笔记本电脑',
        'http://192.168.153.130/images/2019/08/11/610217472674496512.jpg', 13099.00, 1, 13099.00);

-- ----------------------------
-- Table structure for seckill_goods
-- ----------------------------
DROP TABLE IF EXISTS `seckill_goods`;
CREATE TABLE `seckill_goods`  (
                                  `seckill_goods_id`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品id',
                                  `seckill_goods_name`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品名称',
                                  `category_id`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品类别',
                                  `seckill_goods_describe`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品描述',
                                  `seckill_goods_stock`      int(255)                                                NOT NULL COMMENT '秒杀商品库存',
                                  `seckill_goods_price`      decimal(65, 2)                                          NOT NULL COMMENT '秒杀商品价格',
                                  `seckill_goods_image`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品图片',
                                  `seckill_goods_details`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品详情',
                                  `seckill_goods_start_time` timestamp(0)                                            NULL DEFAULT NULL COMMENT '秒杀开始时间',
                                  `seckill_goods_end_time`   timestamp(0)                                            NULL DEFAULT NULL COMMENT '秒杀结束时间',
                                  `seckill_goods_status`     int(255)                                                NOT NULL COMMENT '秒杀商品状态',
                                  PRIMARY KEY (`seckill_goods_id`) USING BTREE,
                                  INDEX `idx_seckill_goods_status` (`seckill_goods_status`) USING BTREE COMMENT '秒杀商品状态索引',
                                  FULLTEXT INDEX `idx_seckill_goods_name` (`seckill_goods_name`) WITH PARSER `ngram`
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为秒杀商品表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seckill_goods
-- ----------------------------
INSERT INTO `seckill_goods`
VALUES ('610776125458612224', 'Apple 2019新品 Macbook Pro 15.4  笔记本电脑', '609417039383101440',
        '九代八核i9 16G 512G 深空灰 笔记本电脑 轻薄本【带触控栏】', 3, 9.90,
        'http://192.168.153.130/images/2019/08/11/610149309567991808.jpg',
        'http://192.168.153.130/images/2019/08/11/610149309567991809.jpg', '2019-08-28 02:59:44', '2019-08-29 02:58:49',
        3);
INSERT INTO `seckill_goods`
VALUES ('610949710110261248', '耐克NIKE Air Jordan Legacy 312 NRG联名', '609417278848499712',
        'NRG联名 AJ312男篮球鞋 女神樱花粉白AT4040-106', 3, 9.90, 'http://192.168.153.130/images/2020/02/26/682147355583053824.jpg',
        'http://192.168.153.130/images/2019/08/13/610954262863675392.jpg', '2020-02-28 00:00:00', '2020-02-29 00:00:00',
        0);
INSERT INTO `seckill_goods`
VALUES ('610954262905618432', '华为HUAWEI MateBook X Pro 2019款', '609417039383101440',
        '英特尔酷睿i7 13.9英寸全面屏轻薄笔记本(i7 8G 512G MX250 3K触控) 灰', 3, 9.90,
        'http://192.168.153.130/images/2019/08/13/610949709950877696.jpg',
        'http://192.168.153.130/images/2019/08/13/610949710051540992.jpg', '2020-02-26 04:40:26', '2020-02-29 00:00:00',
        2);
INSERT INTO `seckill_goods`
VALUES ('612344137449996288', 'Apple iPhone XR (A2108) 256GB 全网通4G手机', '609417120333168640',
        '珊瑚色 A12仿生处理器 移动联通电信4G手机 双卡双待', 3, 9.90, 'http://192.168.153.130/images/2019/08/17/612344137357721600.jpg',
        'http://192.168.153.130/images/2019/08/17/612344137403858944.jpg', '2020-02-26 04:50:00', '2020-02-29 00:00:00',
        2);
INSERT INTO `seckill_goods`
VALUES ('612438698197254144', 'Apple AirPods 配充电盒 苹果蓝牙耳机', '609417220304404480',
        '新款配备有线充电盒的AirPods，Apple新款蓝牙耳机，升级更有魅力！', 3, 9.90,
        'http://192.168.153.130/images/2019/08/18/612438697735880704.jpg',
        'http://192.168.153.130/images/2019/08/18/612438698109173760.jpg', '2020-02-27 00:00:00', '2020-02-28 00:00:00',
        1);
INSERT INTO `seckill_goods`
VALUES ('612440749979467776', 'Apple iPad mini 5 2019年新款平板电脑 7.9英寸', '609417150616043520',
        '（256G WLAN+Cellular版/A12芯片/Retina屏/MUXY2CH/A）银色', 3, 9.90,
        'http://192.168.153.130/images/2019/08/18/612440749715226624.jpg',
        'http://192.168.153.130/images/2019/08/18/612440749929136128.jpg', '2020-02-27 00:00:00', '2020-02-28 00:00:00',
        1);
INSERT INTO `seckill_goods`
VALUES ('612448816896933888', 'MishkaNYC 圆领短袖 大眼球 T恤', '609417258346741760', '男士短袖T恤圆领 mishka女半袖上衣大眼球潮牌情侣装多色', 10, 1.10,
        'http://192.168.153.130/images/2019/08/18/612448816787881984.png',
        'http://192.168.153.130/images/2019/08/18/612448816829825024.jpg', '2020-02-27 00:00:00', '2020-02-28 00:00:00',
        1);
INSERT INTO `seckill_goods`
VALUES ('612449440669630464', 'MishkaNYC新品情侣装T恤', '609417258346741760', 'mishka潮牌复古超市系列 短袖T恤男 休闲 女半袖', 8, 1.10,
        'http://192.168.153.130/images/2019/08/18/612449440543801344.jpg',
        'http://192.168.153.130/images/2019/08/18/612449440564772864.jpg', '2020-02-28 00:00:00', '2020-02-29 00:00:00',
        1);
INSERT INTO `seckill_goods`
VALUES ('612451007317671936', 'MishkaNYC 短袖T恤男女情侣款短袖体恤', '609417258346741760', 'mishka 大眼球印花潮彩虹贴布2019春季新品上衣', 10, 1.10,
        'http://192.168.153.130/images/2019/08/18/612451007246368768.jpg',
        'http://192.168.153.130/images/2019/08/18/612451007284117504.jpg', NULL, NULL, 0);
INSERT INTO `seckill_goods`
VALUES ('612456549113135104', 'Air Jordan Legacy 312 AJ312 球鞋 沙漠迷彩', '609417278848499712',
        'Air Jordan Legacy 312 AJ312 球鞋 NRG联名三合一沙漠迷彩 AV3922', 5, 3.30,
        'http://192.168.153.130/images/2019/08/18/612456547468967936.jpg',
        'http://192.168.153.130/images/2019/08/18/612456547510910976.jpg', NULL, NULL, 0);
INSERT INTO `seckill_goods`
VALUES ('612456943927164928', 'Air Jordan Legacy 312 AJ312 球鞋 湖人', '609417278848499712',
        'Air Jordan Legacy 312 AJ312 球鞋 NRG联名三合一湖人 AV3922', 5, 3.30,
        'http://192.168.153.130/images/2019/08/18/612456943272853504.jpg',
        'http://192.168.153.130/images/2019/08/18/612456943834890240.jpg', NULL, NULL, 0);
INSERT INTO `seckill_goods`
VALUES ('612457825909604352', 'Air Jordan Legacy AJ312 球鞋 黑金漆皮', '609417278848499712',
        'Air Jordan Legacy AJ312 NRG联名三合一 黑金漆皮', 5, 3.30,
        'http://192.168.153.130/images/2019/08/18/612457825821523968.jpg',
        'http://192.168.153.130/images/2019/08/18/612457825855078400.jpg', NULL, NULL, 0);

-- ----------------------------
-- Table structure for seckill_order
-- ----------------------------
DROP TABLE IF EXISTS `seckill_order`;
CREATE TABLE `seckill_order`  (
                                  `seckill_order_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀订单id',
                                  `order_id`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
                                  `user_id`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀订单用户id',
                                  `seckill_goods_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '秒杀商品id',
                                  PRIMARY KEY (`seckill_order_id`) USING BTREE,
                                  UNIQUE INDEX `idx_user_id_seckill_goods_id` (`user_id`, `seckill_goods_id`) USING BTREE COMMENT '用户id与秒杀商品id组合索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为秒杀订单表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping`  (
                             `shipping_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货信息id',
                             `user_id`                varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货地址用户id',
                             `shipping_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人名称',
                             `shipping_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人手机号码',
                             `shipping_address`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货详细地址',
                             PRIMARY KEY (`shipping_id`) USING BTREE,
                             INDEX `idx_user_id` (`user_id`) USING BTREE COMMENT '收货地址用户id索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为收货地址表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping
-- ----------------------------
INSERT INTO `shipping` VALUES ('613836499053445120', '605196406440853504', 'Jason', '18584839287', '四川省成都市双流区天府大道南段成都玩家2栋2单元');
INSERT INTO `shipping` VALUES ('613847900761358336', '605196406440853504', 'Martin', '18584839287', '四川省成都市双流区天府大道南段成都玩家2栋2单元');
INSERT INTO `shipping` VALUES ('613848033091649536', '605196406440853504', 'Avicii', '18584839287', '四川省成都市双流区天府大道南段成都玩家2栋2单元');
INSERT INTO `shipping` VALUES ('616111732397441024', '605196406440853504', 'Kshmr', '18584839287', '四川省成都市双流区天府大道南段成都玩家2栋2单元');
INSERT INTO `shipping`
VALUES ('617823144937259008', '605210786658254848', 'xxx', '18584839287', '四川省成都市双流区');
INSERT INTO `shipping`
VALUES ('682449925824315392', '605211133124542464', 'Avicii', '18584839287', '四川省成都市双流区');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `user_id`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
                         `user_name`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
                         `user_password`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
                         `user_sex`           int(255)                                                NOT NULL COMMENT '用户性别',
                         `user_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户手机号码',
                         `user_role`          int(255)                                                NOT NULL COMMENT '用户角色',
                         `user_salt`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码盐值',
                         PRIMARY KEY (`user_id`) USING BTREE,
                         UNIQUE INDEX `idx_user_name` (`user_name`) USING BTREE COMMENT '用户名称唯一索引',
                         INDEX `idx_user_role` (`user_role`) USING BTREE COMMENT '用户角色索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '此表为用户表。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES ('605196406440853504', 'jason', 'f2d048a64a44c49324ee88c7df1d85ea687b5d711981aab8866918af68950c23', 1,
        '18584839287', 0, '91c4f002482e96ce7b178ea6703a04e0');
INSERT INTO `user` VALUES ('605210786658254848', 'martin', '1e62c6ac6d44bf9ac0d4c236253d0ace274d0219a90d4594552e557938e85e91', 1, '13096383242', 0, 'aea6ecc9c5f7f88e92175cfb18e49379');
INSERT INTO `user` VALUES ('605211133124542464', 'avicii', '6ea7067d466ee427dce601b7c2ec9b7339fca633dd693e62966bcf33b57fb14d', 1, '18584839287', 0, '532a33db8091d760436163ba208d7c45');
INSERT INTO `user` VALUES ('605215057864818688', 'miko', 'ef708a3e7461f4ad9388e0fae4dc7c077adc1108d3d9fc70534bfcceee9c6b0a', 1, '18584839287', 0, 'ae85f3330a9eebd2bd16be46f2dac7ba');
INSERT INTO `user` VALUES ('605902437106057216', 'admin', '38cdaa5ea08fe82297175cef94a82765c05cdc9cd3f8508c74a255641eadab6b', 1, '18584839287', 1, 'fa9526430cfb1ed2f2b7822c99658150');
INSERT INTO `user` VALUES ('607288353687076864', 'siliy', '8343053de3a74b80ab648ca35b3b9f680d5d393700cdb0badfac93998e498876', 1, '13096383242', 0, 'b9015affe33e98b48e7cc2f0a9783ca2');
INSERT INTO `user` VALUES ('610133241646546944', 'xxx', 'fbe1ec0d626c801f0e7625202254b9f96aa68615eecf5722e37dcd935dc354de', 1, '18584839287', 0, 'e6a20646a4b4aafbf400e2c1ca43ee2c');

SET FOREIGN_KEY_CHECKS = 1;
