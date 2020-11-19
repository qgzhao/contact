<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.model.ClassInfo" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/13
  Time: 8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0043)http://localhost:8080/contract/register.jsp -->
<HTML>
<HEAD><TITLE>register</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <META http-equiv=pragma content=no-cache>
    <META http-equiv=cache-control content=no-cache>
    <META http-equiv=expires content=0>
    <META http-equiv=keywords content=keyword1,keyword2,keyword3>
    <META http-equiv=description content="This is my page"><!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <STYLE>BODY {
        TEXT-ALIGN: center
    }

    #register {
        PADDING-RIGHT: 10px;
        PADDING-LEFT: 10px;
        PADDING-BOTTOM: 10px;
        WIDTH: 600px;
        PADDING-TOP: 10px;
        BACKGROUND-COLOR: #eaf2d3
    }

    .error {
        color: red;
    }
    </STYLE>

    <META content="MSHTML 6.00.2900.5726" name=GENERATOR>
</HEAD>
<BODY>
<H3>注册个人通讯录 </H3>
<DIV id=register  style="margin:0 auto;">
    <FORM action="register_deal.jsp" method="post">
        <TABLE>
            <TBODY>
            <TR>
                <TD align=right>姓名：</TD>
                <TD><INPUT name=name  <%if(request.getParameter("name") != null){%>
                           value="<%=request.getParameter("name")%>"
                    <%}%>></TD>
                <td>
                    <% if (request.getAttribute("error_name") != null) { %>
                    <span class="error"><%=request.getAttribute("error_name")%> </span>
                    <%}%>
                </td>
            </TR>
            <TR>
                <TD align=right>性别：</TD>
                <TD>男 <INPUT type=radio value=M name=sex> 女 <INPUT type=radio value=F
                                                                   name=sex></TD>
            </TR>
            <TR>
                <TD align=right>学号：</TD>
                <TD><INPUT name=stuid></TD>
                <td>
                    <% if (request.getAttribute("error_stuid") != null) { %>
                    <span class="error"><%=request.getAttribute("error_stuid")%> </span>
                    <%}%>
                </td>
            </TR>
            <TR>
                <TD align=right>班级：</TD>
                <%
                    ContactDao dao = new ContactDaoImpl();
                    List<ClassInfo> classInfoList = dao.getAllClassInfos();
                %>
                <TD><SELECT name=classId>
                    <% for (ClassInfo classInfo : classInfoList) { %>
                    <OPTION value="<%=classInfo.getId()%>"><%=classInfo.getName()%>
                    </OPTION>
                    <%}%></SELECT>
                </TD>
            </TR>
            <TR>
                <TD align=right>手机号码：</TD>
                <TD><INPUT name=mobile></TD>
                <td>
                    <% if (request.getAttribute("error_mobile") != null) { %>
                    <span class="error"><%=request.getAttribute("error_mobile")%> </span>
                    <%}%>
                </td>
            </TR>
            <TR>
                <TD align=right>电子邮件：</TD>
                <TD><INPUT name=email></TD>
            </TR>
            <TR>
                <TD align=right>QQ号码：</TD>
                <TD><INPUT name=qq></TD>
            </TR>
            <TR>
                <TD></TD>
                <TD><INPUT type=submit value=注册> <INPUT type=reset value=重置>
                </TD>
            </TR>
            </TBODY>
        </TABLE>
    </FORM>
</DIV>
<DIV>返回 <A href="index.jsp">主页面</A>
</DIV>
</BODY>
</HTML>

