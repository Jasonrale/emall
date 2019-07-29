package com.emall.controller;

import com.emall.entity.User;
import com.emall.result.Result;
import com.emall.service.UserService;
import com.emall.vo.LoginVo;
import com.emall.vo.UserUpdateVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    /**
     * 登录认证
     * @param loginVo
     * @return Result
     */
    @PostMapping("/loginValidate")
    @ResponseBody
    public Result<User> loginValidate(@Valid LoginVo loginVo) {
        //认证
        User user = login(loginVo);
        return Result.success("登录成功", user);
    }

    /**
     * 拦截未登录请求后的认证方法
     * @param loginVo
     * @param request
     * @return
     */
    @PostMapping("/authenticate")
    @ResponseBody
    public Result<User> authenticate(@Valid LoginVo loginVo, ServletRequest request) {
        //认证
        User user = login(loginVo);
        SavedRequest saveRequest = WebUtils.getSavedRequest(request);
        String url = saveRequest.getRequestUrl();
        return Result.success(url, user);
    }

    public User login(LoginVo loginVo) {
        logger.info("登录验证--" + "用户名：" + loginVo.getUName());
        //获得Subject对象
        Subject subject = SecurityUtils.getSubject();
        //将用户输入的用户名写密码封装到一个UsernamePasswordToken对象中
        UsernamePasswordToken token = new UsernamePasswordToken(loginVo.getUName(), loginVo.getUPassword());
        token.setRememberMe(true);
        subject.login(token);

        User user = (User) subject.getPrincipal();

        return user;
    }

    /**
     * 登录认证
     * @param
     * @return Result
     */
    @GetMapping("/isLogin")
    @ResponseBody
    public Result<Object> isLogin() {
        logger.info("获取登录用户中......");
        Object object = SecurityUtils.getSubject().getSession().getAttribute("CurrentUser");
        if (object != null) {
            return Result.success("已登录", object);
        }
        return Result.error("未登录");
    }

    /**
     * 注册验证
     * @param user
     * @return Result
     */
    @PutMapping("/registerValidate")
    @ResponseBody
    public Result<User> registerValidate(@Valid User user) {
        logger.info("注册验证--" + "用户名：" + user.getUName() + "  性别：" + user.getUSex()
                + "  手机号码：" + user.getUMobileNumber());
        return userService.registerValidate(user);
    }

    /**
     * 登出
     * @return
     */
    @GetMapping("/logout")
    public String logout() {
        SecurityUtils.getSubject().logout(); // session删除、RememberMe cookie也将被删除
        return "redirect:/user/login.html";
    }

    /**
     * 修改用户信息
     * @param userUpdateVo
     * @return Result
     */
    @PostMapping("/userUpdate")
    @ResponseBody
    public Result<UserUpdateVo> userUpdate(@Valid UserUpdateVo userUpdateVo) {
        logger.info("修改用户信息--" + "用户名：" + userUpdateVo.getUName() + "  性别：" + userUpdateVo.getUSex()
                + "  手机号码：" + userUpdateVo.getUMobileNumber());
        return userService.userUpdate(userUpdateVo);
    }


}
