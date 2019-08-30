package com.emall.utils;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * Druid数据库连接池配置
 */
public class DruidConfig {
    private static final Logger logger = LoggerFactory.getLogger(DruidConfig.class);

    @Bean
    public ServletRegistrationBean<StatViewServlet> druidServlet() {
        logger.info("init Druid Servlet Configuration ");
        ServletRegistrationBean<StatViewServlet> servletRegistrationBean = new ServletRegistrationBean<>(new StatViewServlet(), "/druid/*");
        // IP白名单
        servletRegistrationBean.addInitParameter("allow", "10.18.160.177,127.0.0.1");
        //控制台管理用户
        servletRegistrationBean.addInitParameter("loginUsername", "jason");
        servletRegistrationBean.addInitParameter("loginPassword", "123456");
        //是否能够重置数据 禁用HTML页面上的“Reset All”功能
        servletRegistrationBean.addInitParameter("resetEnable", "false");
        return servletRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean<WebStatFilter> filterRegistrationBean() {
        FilterRegistrationBean<WebStatFilter> filterRegistrationBean = new FilterRegistrationBean<>(new WebStatFilter());
        filterRegistrationBean.addUrlPatterns("/*");
        filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
        return filterRegistrationBean;
    }

    //解决 spring.datasource.filters=stat,wall,log4j 无法正常注册进去

    @Data
    //@ConfigurationProperties(prefix = "spring.datasource")
    @Configuration
    class DataSourceProperties {
        @Value("spring.datasource.url")
        private String url;

        @Value("spring.datasource.username")
        private String username;

        @Value("spring.datasource.password")
        private String password;

        @Value("spring.datasource.driverClassName")
        private String driverClassName;

        @Value("spring.datasource.filters")
        private String filters;

        @Value("spring.datasource.initialSize")
        private int initialSize;

        @Value("spring.datasource.minIdle")
        private int minIdle;

        @Value("spring.datasource.maxActive")
        private int maxActive;

        @Value("spring.datasource.maxWait")
        private int maxWait;

        @Value("spring.datasource.timeBetweenEvictionRunsMillis")
        private int timeBetweenEvictionRunsMillis;

        @Value("spring.datasource.minEvictableIdleTimeMillis")
        private int minEvictableIdleTimeMillis;

        @Value("spring.datasource.validationQuery")
        private String validationQuery;

        @Value("spring.datasource.testWhileIdle")
        private boolean testWhileIdle;

        @Value("spring.datasource.testOnBorrow")
        private boolean testOnBorrow;

        @Value("spring.datasource.testOnReturn")
        private boolean testOnReturn;

        @Value("spring.datasource.poolPreparedStatements")
        private boolean poolPreparedStatements;

        @Value("spring.datasource.maxPoolPreparedStatementPerConnectionSize")
        private int maxPoolPreparedStatementPerConnectionSize;

        @Value("spring.datasource.connectionProperties")
        private String connectionProperties;

        @Value("spring.datasource.useGlobalDataSourceStat")
        private boolean useGlobalDataSourceStat;

        @Bean     //声明其为Bean实例
        @Primary  //在同样的DataSource中，首先使用被标注的DataSource
        public DataSource dataSource() {
            DruidDataSource datasource = new DruidDataSource();
            datasource.setUrl(url);
            datasource.setUsername(username);
            datasource.setPassword(password);
            datasource.setDriverClassName(driverClassName);

            //configuration
            try{
                datasource.setFilters(filters);
            } catch (SQLException e) {
                logger.error("druid configuration initialization filter: " + e);
                System.err.println("druid configuration initialization filter: " + e);
            }
            datasource.setInitialSize(initialSize);
            datasource.setMinIdle(minIdle);
            datasource.setMaxActive(maxActive);
            datasource.setMaxWait(maxWait);
            datasource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
            datasource.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);
            datasource.setValidationQuery(validationQuery);
            datasource.setTestWhileIdle(testWhileIdle);
            datasource.setTestOnBorrow(testOnBorrow);
            datasource.setTestOnReturn(testOnReturn);
            datasource.setPoolPreparedStatements(poolPreparedStatements);
            datasource.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);
            datasource.setConnectionProperties(connectionProperties);
            datasource.setUseGlobalDataSourceStat(useGlobalDataSourceStat);
            return datasource;
        }
    }
}
