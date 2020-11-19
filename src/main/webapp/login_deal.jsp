<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.model.Admin" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/20
  Time: 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%



    //获取参数
    String account = request.getParameter("account");
    String password = request.getParameter("password");

    ContactDao dao = new ContactDaoImpl();
    Admin admin = dao.getAdmin(account, password);
    // if("admin".equals(account) && "admin".equals(password)){
    if(admin != null) { //验证-成功：跳转到首页
        session.setAttribute("admin", admin); //保存管理员对象到Session
        response.sendRedirect("index.jsp");
    } else {  //验证-失败：返回（前转）到：登陆页面
        //传递错误信息
        request.setAttribute("error", "账户或密码错误！");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>
