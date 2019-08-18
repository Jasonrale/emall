$(document).ready(function () {
    userSkip();

    adminSkip();

    $(document).keyup(function (event) {
        if (event.keyCode === 13) {
            query();
        }
    });
});

//获取url后的参数
function getUrlParam(name) {
    var sValue = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]*)(\&?)", "i"));
    return sValue ? sValue[1] : sValue;
}


//展示loading
function showLoading(){
    return layer.msg('处理中...', {icon: 16, shade: [0.5, '#f5f5f5'], scrollbar: false, offset: '0px', time: 5000});
}

/**
 * 判断是否登录
 */
function userInfo() {
    $.ajax({
        type: "GET",
        url: "/user",
        success: function (data) {
            if (data.status === true) {
                $("#login").css("display", "none");
                $("#welcome").css("display", "inline");
                $("#loginName").css("display", "inline").html(data.obj.userName);
                $("#logout").css("display", "inline");
            }
        }
    });
}

/**
 * 获取管理员信息
 */
function adminInfo() {
    $.ajax({
        type: "GET",
        url: "/user/admin",
        success: function (data) {
            if (data.status === true) {
                $("#adminName").html(data.obj.userName);
            }
        }
    });
}

/**
 * 后台跳转功能
 */
function adminSkip() {
    $("#goodsSkip").click(function () {
        $(window).attr("location", "goodsManage.html");
    });

    $("#categorySkip").click(function () {
        $(window).attr("location", "categoryManage.html");
    });

    $("#orderSkip").click(function () {
        $(window).attr("location", "orderManage.html");
    });
}

/**
 * 用户端跳转功能
 */
function userSkip() {
    $("#login").click(function () {
        $(window).attr('location', '/user/login.html');
    });

    $("#logout").click(function () {
        $(window).attr("location", "/user/logout")
    });

    $(".logo").click(function () {
        $(window).attr('location', '/index.html');
    });

    $("#emall").click(function () {
        $(window).attr('location', '/index.html');
    });
}

/**
 * 通用关键字搜索框
 */
function query() {
    var keyWord = $("#keyWord").val();
    if (keyWord === undefined) {
        return false;
    } else if (keyWord.trim() === "") {
        return false;
    }

    $(window).attr('location', '/goods/goodsList.html?keyWord=' + encodeURI(keyWord));
}


Date.prototype.format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
};

