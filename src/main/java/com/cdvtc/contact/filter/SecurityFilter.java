package com.cdvtc.contact.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SecurityFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest)req;
        HttpSession session = httpRequest.getSession();
        if(session.getAttribute("admin") == null){  //权限验证，未登陆则重置页面至首页
            HttpServletResponse httpResponse = (HttpServletResponse)resp;
            httpResponse.sendRedirect("index.jsp");
            return;  //结束过滤，否则还会进入相应页面
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
