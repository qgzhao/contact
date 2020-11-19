<%@ page import="com.cdvtc.contact.model.Contact" %>
<%@ page import="com.cdvtc.contact.model.ClassInfo" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/15
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //获取参数
    request.setCharacterEncoding("UTF-8"); //设置编码，只针对POST提交有效
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String stuid = request.getParameter("stuid");
    int classid = Integer.parseInt(request.getParameter("classid"));
    String mobile = request.getParameter("mobile");
    String qq = request.getParameter("qq");
    String email = request.getParameter("email");
    int id = Integer.parseInt(request.getParameter("id"));
    //验证
    String error_name = null;
    String error_mobile = null;
    if(name == null || name.length()<2){
        error_name = "姓名不能为空！";
    }

    if(mobile == null || mobile.length()<11) {
        error_mobile = "手机号码格式不正确！";
    }

    if(error_name == null && error_mobile == null) {

        //调用DAO
        Contact contact = new Contact();
        contact.setId(id);
        contact.setSex(sex);
        contact.setQq(qq);
        contact.setName(name);
        contact.setMobile(mobile);
        contact.setStuid(stuid);
        contact.setEmail(email);
        ClassInfo classInfo = new ClassInfo();
        classInfo.setId(classid);
        contact.setClassInfo(classInfo);
        ContactDao dao = new ContactDaoImpl();
        dao.updateContact(contact);
        //页面跳转
        response.sendRedirect("index.jsp");
    } else {   //失败：返回注册页面（增加错误提示）
        request.setAttribute("error_name", error_name);
        request.setAttribute("error_mobile", error_mobile);

        request.getRequestDispatcher("edit.jsp?id="+id).forward(request, response);  //前转至页面：编辑页面
    }
%>
