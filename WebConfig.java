package com.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // 1. CSRF token on every page, verified on every POST
        registry.addInterceptor(new CsrfInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/error");

        // 2. Everything except the public pages needs a login
        //    (add exclusions here if you later serve static files, e.g. "/css/**")
        registry.addInterceptor(new AuthInterceptor(false))
                .addPathPatterns("/**")
                .excludePathPatterns("/", "/login", "/register", "/error");

        // 3. Restaurant / menu management is admin-only
        registry.addInterceptor(new AuthInterceptor(true))
                .addPathPatterns(
                        "/restaurants/add",
                        "/restaurants/save",
                        "/restaurants/delete/**",
                        "/food/add/**",
                        "/food/save",
                        "/food/delete/**");
    }
}
