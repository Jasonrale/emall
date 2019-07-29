﻿$(document).ready(function () {
    userInfoInit();
});

/**
 * 用户个人信息初始化
 */
function userInfoInit() {
    $.ajax({
        type: "GET",
        url: "/user/isLogin",
        success: function (data) {
            if (data.status === true) {
                $("#login").css("display", "none");
                $("#welcome").css("display", "inline");
                $("#loginName").css("display", "inline").html(data.obj.uname);
                $("#logout").css("display", "inline");

                $("#userName").html(data.obj.uname);
                $("#sex").html(data.obj.usex === 1 ? "男" : "女");
                $("#mobileNumber").html(data.obj.umobileNumber);
            }
        }
    });
}