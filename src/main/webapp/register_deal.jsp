<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.model.Contact" %>
<%@ page import="com.cdvtc.contact.model.ClassInfo" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //获取参数
    request.setCharacterEncoding("UTF8");  // 设置参数编码为UTF8
    String name = request.getParameter("name");
    System.out.println("name:" + name);

    String sex = request.getParameter("sex");
    String stuid = request.getParameter("stuid");
    int classId = Integer.parseInt(request.getParameter("classId"));
    String mobile = request.getParameter("mobile");
    String qq = request.getParameter("qq");
    String email = request.getParameter("email");

    String error_name = null;
    String error_mobile = null;
    String error_stuid = null;
    //验证
    if (name == null || name.length() < 2) {
        error_name = "姓名不能为空！";
    }

    if (mobile == null || mobile.length() < 11) {
    error_mobile = "手机号码格式不正确！";
    }

    ContactDao dao = new ContactDaoImpl();
    if(dao.isContactExisted(stuid)) {
        error_stuid = "学号已经存在！";
    }


    if (error_name == null && error_mobile == null && error_stuid == null) {  //成功-写入数据库，返回主页面
        // 将数据写入数据库
        Contact contact = new Contact();
        contact.setName(name);
        contact.setSex(sex);
        ClassInfo classInfo = new ClassInfo();
        classInfo.setId(classId);
        contact.setStuid(stuid);
        contact.setClassInfo(classInfo);
        contact.setQq(qq);
        contact.setMobile(mobile);
        contact.setEmail(email);


        dao.addContact(contact);

        response.sendRedirect("index.jsp");  // 返回主页（重置）
    } else { //失败-返回注册页面（提示错误）
        request.setAttribute("error_name", error_name);  // 将姓名错误信息存入request对象（在注册页面中显示对应错误信息）
        request.setAttribute("error_mobile", error_mobile);
        request.setAttribute("error_stuid", error_stuid);

        request.getRequestDispatcher("register.jsp").forward(request, response);  // 前置页面至：注册页面
    }
%>
