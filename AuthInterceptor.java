package com.config;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/** Requires a logged-in user; when adminOnly is true, also requires the ADMIN role. */
public class AuthInterceptor implements HandlerInterceptor {

    private final boolean adminOnly;

    public AuthInterceptor(boolean adminOnly) {
        this.adminOnly = adminOnly;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        if (adminOnly && !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admins only");
            return false;
        }

        return true;
    }
}
