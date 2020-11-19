package com.cdvtc.contact.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener()
public class OnlineCountListener implements HttpSessionListener {

    public int count=0;//记录session的数量
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {//监听session的创建
        count++;
        httpSessionEvent.getSession().getServletContext().setAttribute("onlineCount", count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {//监听session的撤销
        count--;
        httpSessionEvent.getSession().getServletContext().setAttribute("onlineCount", count);
    }
}
