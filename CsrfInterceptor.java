package com.config;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Set;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Minimal CSRF protection without Spring Security.
 * Every session gets a random token (exposed to JSPs as ${sessionScope.csrfToken});
 * every state-changing request must send it back as the "_csrf" form field.
 */
public class CsrfInterceptor implements HandlerInterceptor {

    public static final String SESSION_ATTR = "csrfToken";
    public static final String PARAM = "_csrf";

    private static final Set<String> SAFE_METHODS = Set.of("GET", "HEAD", "OPTIONS", "TRACE");
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession(true);

        String token = (String) session.getAttribute(SESSION_ATTR);
        if (token == null) {
            byte[] bytes = new byte[32];
            RANDOM.nextBytes(bytes);
            token = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
            session.setAttribute(SESSION_ATTR, token);
        }

        if (SAFE_METHODS.contains(request.getMethod())) {
            return true;
        }

        String sent = request.getParameter(PARAM);
        if (sent != null && MessageDigest.isEqual(
                token.getBytes(StandardCharsets.UTF_8), sent.getBytes(StandardCharsets.UTF_8))) {
            return true;
        }

        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or missing CSRF token");
        return false;
    }
}
