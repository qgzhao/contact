<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/21
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //获取参数
    int id  = Integer.parseInt(request.getParameter("id"));
    //调用DAO
    ContactDao dao = new ContactDaoImpl();
    dao.deleteContact(id);
    //跳转页面
    response.sendRedirect("index.jsp");
%>
