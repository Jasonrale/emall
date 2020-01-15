$(document).ready(function () {
    navInfo();

    var from = getUrlParam("from");
    if (from === "cart") {
        fromCartInit(JSON.parse(sessionStorage.getItem("cartItemIdList")), JSON.parse(sessionStorage.getItem("totalPrice")));
    } else {
        var count = getUrlParam("count");
        if (count != null && count.trim() !== "") {
            normalInit(JSON.parse(sessionStorage.getItem("buyGoods")), count);
            normalSubmit(JSON.parse(sessionStorage.getItem("buyGoods")), count);
        } else {
            var seckillGoodsId = getUrlParam("seckillGoodsId");
            if (seckillGoodsId != null && seckillGoodsId.trim() !== "") {
                var path = getUrlParam("path");
                initSeckill(seckillGoodsId, path);
                seckillSubmit(seckillGoodsId, path);
            }
        }
    }
});

/**
 * 验证path
 * @param seckillGoodsId
 * @param path
 * @returns {boolean}
 */
function pathValid(seckillGoodsId, path) {
    var result = false;

    $.ajax({
        type: "GET",
        async: false,
        url: "/emall/seckill/" + seckillGoodsId + "/" + path + "/checkPath",
        success: function (data) {
            result = data.status;

        }
    });

    return result;
}

/**
 * 购物车订单数据初始化
 */
function fromCartInit(cartItemIdList, totalPrice) {
    queryAllShipping();

    $.ajax({
        type: "POST",
        url: "/emall/cartItem/orderConfirm",
        data: JSON.stringify(cartItemIdList),
        contentType: 'application/json;charset=UTF-8',
        success: function (data) {
            if (data.status === true) {
                var cartItemList = data.obj;
                sessionStorage.setItem("cartItemList", JSON.stringify(cartItemList));

                for (var i = 0; i < cartItemList.length; i++) {
                    var cartItem = cartItemList[i];

                    var element = "<tr>" +
                        '<td class="cell-img">' +
                        '<a href="../../goods/detail.html?goodsId=' + cartItem.goodsId + '" target="_blank">' +
                        '<img class="p-img" src="' + cartItem.goodsImage + '" alt="' + cartItem.goodsName + '"/>' +
                        "</a>" +
                        "</td>" +
                        '<td class="cell-info">' +
                        '<a class="link" href="../../goods/detail.html?goodsId=' + cartItem.goodsId + '" target="_blank">' + cartItem.goodsName + "</a>" +
                        "</td>" +
                        '<td class="cell-price">' + "￥" + cartItem.goodsPrice + "</td>" +
                        '<td class="cell-count">' + cartItem.goodsCount + "</td>" +
                        '<td class="cell-total">' + "￥" + cartItem.cartItemSubtotal + "</td>" +
                        "</tr>";

                    $(".product-table").append(element);
                }

                $(".submit-total").html("￥" + totalPrice);

                fromCartSubmit(JSON.parse(sessionStorage.getItem("cartItemList")), JSON.parse(sessionStorage.getItem("totalPrice")));
            } else {
                layer.msg(data.msg, {time: 1000}, function () {
                    $(window).attr("location", "cart.html")
                })
            }
        }
    });
}

/**
 * 普通订单确认数据初始化(立即购买)
 * @param buyGoods
 * @param count
 */
function normalInit(buyGoods, count) {
    queryAllShipping();

    var goods = buyGoods;
    var element = "<tr>" +
        '<td class="cell-img">' +
        '<a href="../../goods/detail.html?goodsId=' + goods.goodsId + '" target="_blank">' +
        '<img class="p-img" src="' + goods.goodsImage + '" alt="' + goods.goodsName + '"/>' +
        "</a>" +
        "</td>" +
        '<td class="cell-info">' +
        '<a class="link" href="../../goods/detail.html?goodsId=' + goods.goodsId + '" target="_blank">' + goods.goodsName + "</a>" +
        "</td>" +
        '<td class="cell-price">' + "￥" + goods.goodsPrice + "</td>" +
        '<td class="cell-count">' + count + "</td>" +
        '<td class="cell-total">' + "￥" + count * goods.goodsPrice + "</td>" +
        "</tr>";
    $(".product-table").append(element);
    $(".submit-total").html("￥" + count * goods.goodsPrice);
}

/**
 * 秒杀订单确认数据初始化
 * @param seckillGoodsId
 * @param path
 */
function initSeckill(seckillGoodsId, path) {
    if (!pathValid(seckillGoodsId, path) || path === null || path.trim() === "") {
        layer.msg("请求非法", {time: 1000}, function () {
            $(window).attr("location", "../../index.html");
        });
        $("#submit").attr("disabled", true);
    } else {
        seckillOrder(seckillGoodsId);
        queryAllShipping();
    }
}

/**
 * 秒杀订单确认信息
 */
function seckillOrder(seckillGoodsId) {
    $.ajax({
        type: "GET",
        async: false,
        url: "/emall/seckillGoods/" + seckillGoodsId + "/seckillGoodsId",
        success: function (data) {
            if (data.status === true) {
                var seckillGoods = data.obj.seckillGoods;
                var element = "<tr>" +
                    '<td class="cell-img">' +
                    '<a href="../../goods/detail.html?goodsId=' + seckillGoods.seckillGoodsId + '" target="_blank">' +
                    '<img class="p-img" src="' + seckillGoods.seckillGoodsImage + '" alt="' + seckillGoods.seckillGoodsName + '"/>' +
                    "</a>" +
                    "</td>" +
                    '<td class="cell-info">' +
                    '<a class="link" href="../../goods/detail.html?goodsId=' + seckillGoods.seckillGoodsId + '" target="_blank">' + seckillGoods.seckillGoodsName + "</a>" +
                    "</td>" +
                    '<td class="cell-price">' + "￥" + seckillGoods.seckillGoodsPrice + "</td>" +
                    '<td class="cell-count">1</td>' +
                    '<td class="cell-total">' + "￥" + seckillGoods.seckillGoodsPrice + "</td>" +
                    "</tr>";
                $(".product-table").append(element);
                $(".submit-total").html("￥" + seckillGoods.seckillGoodsPrice);
            }
        }
    });
}

/**
 * 查询所有收货信息
 */
function queryAllShipping() {
    $.ajax({
        type: "GET",
        url: "/emall/shipping/all",
        success: function (data) {
            if (data.status === true) {
                var shippingList = data.obj;
                $(".panel-body.address-con").empty();
                if (shippingList.length === 0) {
                    var ele = '<div class="address active">' +
                        '<div class="address-add">' +
                        '<div class="address-new">' +
                        '<div class="text" onclick="newShipping()">使用新地址</div>' +
                        "</div>" +
                        "</div>" +
                        "</div>";

                    $(".panel-body.address-con").append(ele);
                } else {
                    for (var i = 0; i < shippingList.length; i++) {
                        var shippingId = shippingList[i].shippingId;
                        var elementHead;
                        if (i === 0) {
                            elementHead = '<div class="address active" id="' + shippingId + '">';
                        } else {
                            elementHead = '<div class="address" id="' + shippingId + '">';
                        }
                        var element = elementHead +
                            '<div class="address-item" id="item:' + shippingId + '" onclick="select(this)">' +
                            '<div class="address-title" id="name:' + shippingId + '">' + shippingList[i].shippingName + "</div>" +
                            '<div class="address-detail" id="detail:' + shippingId + '">' + shippingList[i].shippingAddress + "</div>" +
                            '<div class="mobile-number" id="mobile:' + shippingId + '">' + shippingList[i].shippingMobileNumber + "</div>" +
                            '<div class="address-opera">' +
                            '<span class="link address-update" onclick="updateShipping(' + "'" + shippingId + "'" + ')">编辑</span>' +
                            '<span class="link address-delete" onclick="deleteShipping(' + "'" + shippingId + "'" + ')">删除</span>' +
                            "</div>" +
                            "</div>" +
                            '<div class="address-add" onclick="newShipping()">' +
                            '<div class="address-new">' +
                            '<div class="text">使用新地址</div>' +
                            "</div>" +
                            "</div>" +
                            "</div>";

                        $(".panel-body.address-con").append(element);
                    }
                }
            }
        }
    });
}

function select(ele) {
    var id = $(ele).attr("id");
    var shippingId = id.split(":")[1];
    $(".address.active").attr("class", "address");
    document.getElementById("" + shippingId).className = "address active";
}

/**
 * 新建收货信息
 */
function newShipping() {
    $("#update").css("display", "none");
    $("#add").css("display", "block");
    var str = "'new'";
    $("#shippingSave").replaceWith('<a class="btn address-btn" id="shippingSave" onclick="shippingSave(' + str + ')">保存</a>');
    $("#modal").css("display", "block");
}

/**
 * 修改收货信息
 */
function updateShipping(shippingId) {
    $("#add").css("display", "none");
    $("#update").css("display", "block");
    $("#shippingId").val(shippingId);
    $("#shippingName").val(document.getElementById("name:" + shippingId).innerHTML);
    $("#shippingAddress").val(document.getElementById("detail:" + shippingId).innerHTML);
    $("#shippingMobileNumber").val(document.getElementById("mobile:" + shippingId).innerHTML);

    var str = "'update'";
    $("#shippingSave").replaceWith('<a class="btn address-btn" id="shippingSave" onclick="shippingSave(' + str + ')">保存</a>');
    $("#modal").css("display", "block");
}

/**
 * 删除收货信息
 */
function deleteShipping(shippingId) {
    layer.confirm("您确定要删除该收货地址吗？",
        {btn: ["确定", "取消"]},
        function () {
            $.ajax({
                type: "DELETE",
                url: "/emall/shipping",
                data: shippingId,
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if (data.status === true) {
                        layer.msg(data.msg, {time: 1000}, function () {
                            window.location.reload();
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
        },
        function () {
            layer.closeAll();
        }
    );
}
/**
 * 保存收货信息
 */
function shippingSave(type) {
    var shippingName = $("#shippingName").val();
    var shippingAddress = $("#shippingAddress").val();
    var shippingMobileNumber = $("#shippingMobileNumber").val();
    var shippingId = $("#shippingId").val();

    if (shippingName === undefined || shippingName.trim() === "") {
        layer.msg("收货人姓名不能为空");
        return false;
    } else if (shippingAddress === undefined || shippingAddress.trim() === "") {
        layer.msg("收货人地址不能为空");
        return false;
    } else if (!mobileValid(shippingMobileNumber)) {
        layer.msg("手机号码格式不正确！");
        return false;
    }

    if (type === "new") {
        var shipping = {
            "shippingName": shippingName,
            "shippingAddress": shippingAddress,
            "shippingMobileNumber": shippingMobileNumber
        };
        $.ajax({
            type: "PUT",
            url: "/emall/shipping",
            data: JSON.stringify(shipping),
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if (data.status === true) {
                    layer.msg(data.msg, {time: 1000}, function () {
                        shippingCancel();
                        queryAllShipping();
                    });
                } else {
                    layer.msg(data.msg);
                }
            }
        });
    } else {
        var shipping = {
            "shippingId": shippingId,
            "shippingName": shippingName,
            "shippingAddress": shippingAddress,
            "shippingMobileNumber": shippingMobileNumber
        };
        $.ajax({
            type: "POST",
            url: "/emall/shipping",
            data: JSON.stringify(shipping),
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if (data.status === true) {
                    layer.msg(data.msg);
                    shippingCancel();
                    queryAllShipping();
                } else {
                    layer.msg(data.msg);
                }
            }
        });
    }
}

/**
 * 取消已填写收货信息
 */
function shippingCancel() {
    $("#modal").css("display", "none");
    $("#shippingName").val("");
    $("#shippingAddress").val("");
    $("#shippingMobileNumber").val("");
}

/**
 * 购物车订单提交
 * @param cartItemList
 * @param totalPrice
 */
function fromCartSubmit(cartItemList, totalPrice) {
    $("#submit").click(function () {
        var cartOrderSubmitVo = {
            cartItemList: cartItemList,
            shippingId: $(".address.active").attr("id"),
            totalPrice: totalPrice
        };

        $.ajax({
            type: "PUT",
            url: "/emall/order/cart",
            data: JSON.stringify(cartOrderSubmitVo),
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if (data.status === true) {
                    layer.msg(data.msg, {time: 1200}, function () {
                        $(window).attr("location", "orderDetail.html?orderId=" + data.obj)
                    });
                } else {
                    layer.msg(data.msg, {time: 1000}, function () {
                        $(window).attr("location", "../../index.html");
                    });
                }
            }
        });
    });
}

/**
 * 普通订单提交（立即购买）
 * @param buyGoods
 * @param count
 */
function normalSubmit(buyGoods, count) {
    $("#submit").click(function () {
        var orderSubmitVo = {
            goods: buyGoods,
            shippingId: $(".address.active").attr("id"),
            count: count
        };

        $.ajax({
            type: "PUT",
            url: "/emall/order/normal",
            data: JSON.stringify(orderSubmitVo),
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if (data.status === true) {
                    layer.msg(data.msg, {time: 1200}, function () {
                        $(window).attr("location", "orderDetail.html?orderId=" + data.obj)
                    });
                } else {
                    layer.msg(data.msg, {time: 1000}, function () {
                        $(window).attr("location", "../../index.html");
                    });
                }
            }
        });
    });
}

/**
 * 秒杀订单提交
 * @param seckillGoodsId
 * @param path
 */
function seckillSubmit(seckillGoodsId, path) {
    $("#submit").click(function () {
        var json = {
            seckillGoodsId: seckillGoodsId,
            shippingId: $(".address.active").attr("id"),
            path: path
        };

        $.ajax({
            type: "PUT",
            url: "/emall/seckillOrder",
            data: json,
            success: function (data) {
                if (data.status === true) {
                    layer.msg(data.msg, {time: 1200}, function () {
                        $(window).attr("location", "orderDetail.html?orderId=" + data.obj)
                    });
                } else {
                    layer.msg(data.msg, {time: 1000}, function () {
                        $(window).attr("location", "../../index.html");
                    });
                }
            }
        });
    });
}

/**
 * 验证手机号码
 */
function mobileValid(mobileNumber) {
    var result = true;
    var mobileValidate = /^(1[3-9])\d{9}$/;

    if (!(mobileValidate.test(mobileNumber))) {
        result = false;
    }

    return result;
}
