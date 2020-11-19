<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/20
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //销毁Session对象
    session.invalidate();

    //跳转页面：首页
    response.sendRedirect("index.jsp");
%>
