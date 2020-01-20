package com.emall.exception;

import com.emall.result.Result;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 全局异常处理器
 */
@ControllerAdvice
@ResponseBody
public class GlobalExceptionHandler {

    @ExceptionHandler(value = GeneralException.class)
    public Result ExceptionHandler(HttpServletRequest request, GeneralException exception) {
        return Result.error(exception.getMessage());
    }

    @ExceptionHandler(value = BindException.class)
    public Result ExceptionHandler(HttpServletRequest request, BindException exception) {
        ObjectError error = exception.getAllErrors().get(0);
        return Result.error(error.getDefaultMessage());
    }

    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public Result ExceptionHandler(HttpServletRequest request, MethodArgumentNotValidException exception) {
        FieldError fieldError = exception.getBindingResult().getFieldError();
        assert fieldError != null;
        return Result.error(fieldError.getDefaultMessage());
    }

    @ExceptionHandler(value = UnknownAccountException.class)
    public Result ExceptionHandler(HttpServletRequest request, UnknownAccountException exception) {
        return Result.error(exception.getMessage());
    }

    @ExceptionHandler(value = IncorrectCredentialsException.class)
    public Result ExceptionHandler(HttpServletRequest request, IncorrectCredentialsException exception) {
        return Result.error(exception.getMessage());
    }

    @ExceptionHandler(value = IllegalArgumentException.class)
    public Result ExceptionHandler(HttpServletRequest request, IllegalArgumentException exception) {
        return Result.error(exception.getMessage());
    }

}
