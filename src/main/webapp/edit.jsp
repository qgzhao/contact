<%@ page import="java.util.List" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.model.Contact" %>
<%@ page import="com.cdvtc.contact.model.ClassInfo" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/15
  Time: 9:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<!-- saved from url=(0048)http://localhost:8080/contract/register.jsp?id=6 -->
<html>
<head><title>edit</title>
    <meta http-equiv=content-type content="text/html; charset=gb2312">
    <meta http-equiv=pragma content=no-cache>
    <meta http-equiv=cache-control content=no-cache>
    <meta http-equiv=expires content=0>
    <meta http-equiv=keywords content=keyword1,keyword2,keyword3>
    <meta http-equiv=description content="this is my page"><!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <style>body {
        text-align: center
    }

    #register {
        padding-right: 10px;
        padding-left: 10px;
        padding-bottom: 10px;
        width: 600px;
        padding-top: 10px;
        background-color: #eaf2d3
    }
    .error{
        color: red;
    }
    </style>

    <meta content="mshtml 6.00.2900.5726" name=generator>
</head>
<body>
<h3>编辑通讯录 </h3>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ContactDao dao = new ContactDaoImpl();
    Contact contact = dao.getContact(id);
    List<ClassInfo> classInfoList = dao.getAllClassInfos();
%>
<div id=register style="margin:0 auto;">
    <form action="edit_deal.jsp" method=post>
        <input type=hidden value=<%=contact.getId()%> name=id>
        <table>
            <tbody>
            <tr>
                <td align=right>姓名：</td>
                <td><input value=<%=contact.getName()%> name=name></td>
                <td class="error">
                    ${error_name}
                </td>
            </tr>
            <tr>
                <td align=right>性别：</td>
                <td>男 <input type=radio <%="M".equalsIgnoreCase(contact.getSex())?"checked":""%> value=m name=sex>
                    女<input type=radio <%="F".equalsIgnoreCase(contact.getSex())?"checked":""%> value=m name=sex value=f name=sex>
                </td>
            </tr>
            <tr>
                <td align=right>学号：</td>
                <td><input value=<%=contact.getStuid()%> name=stuid readonly></td>
            </tr>
            <tr>
                <td align=right>班级：</td>
                <td><select name=classid>
                    <% for(ClassInfo classInfo: classInfoList){ %>
                       <option value=<%=classInfo.getId()%> <%=classInfo.getId()==contact.getClassInfo().getId()?"selected":""%>><%=classInfo.getName()%></option>
                    <%}%>
                </select>
                </td>
            </tr>
            <tr>
                <td align=right>手机号码：</td>
                <td><input value=<%=contact.getMobile()%> name=mobile></td>
                <td class="error">
                    ${error_mobile}
                </td>
            </tr>
            <tr>
                <td align=right>电子邮件：</td>
                <td><input value=<%=contact.getEmail()%> name=email></td>
            </tr>
            <tr>
                <td align=right>qq号码：</td>
                <td><input value=<%=contact.getQq()%> name=qq></td>
            </tr>
            <tr>
                <td></td>
                <td><input type=submit value=编辑> <input type=reset value=重置>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div>返回 <a href="index.jsp">主页面</a>
</div>
</body>
</html>

