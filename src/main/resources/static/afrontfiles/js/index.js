$(document).ready(function () {
    isLogin();
});

/**
 * 判断是否登录
 */
function isLogin() {
    $.ajax({
        type: "GET",
        url: "/user/isLogin",
        success: function (data) {
            if (data.status === true) {
                $("#login").css("display", "none");
                $("#welcome").css("display", "inline");
                $("#loginName").css("display", "inline").html(data.obj.uname);
                $("#logout").css("display", "inline");
            }
        }
    });
}