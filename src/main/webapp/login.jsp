<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/20
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0040)http://localhost:8080/contract/login.jsp -->
<HTML>
<HEAD><TITLE>login</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <META http-equiv=pragma content=no-cache>
    <META http-equiv=cache-control content=no-cache>
    <META http-equiv=expires content=0>
    <META http-equiv=keywords content=keyword1,keyword2,keyword3>
    <META http-equiv=description content="This is my page"><!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <META content="MSHTML 6.00.2900.5726" name=GENERATOR>
</HEAD>
<style>
    body {
        text-align: center;
        margin: 0;
    }

    #login {
        margin: 0 auto;
        width: 300px;
        background-color: #eaf2d3;
    }

    .error {
        color: red;
    }
</style>
<BODY>
<div id="login">
    <H3>系统登陆 </H3>
    <FORM action="loginServlet" method="post">
        <TABLE>
            <TBODY>
            <TR>
                <TD align=right>账号：</TD>
                <TD><INPUT style="WIDTH: 160px; HEIGHT: 26px" name=account></TD>
            </TR>
            <TR>
                <TD align=right>密码：</TD>
                <TD><INPUT style="WIDTH: 160px; HEIGHT: 26px" type=password name=password>
                </TD>
            </TR>
            <TR>
                <TD></TD>
                <TD><INPUT type=submit value=登陆> <INPUT type=reset value=重置>
                </TD>
            </TR>
            </TBODY>
        </TABLE>
        <% if(request.getAttribute("error") != null){%>
        <p class="error">
            <%=request.getAttribute("error")%>
        </p>
        <%}%>
        <DIV>返回 <A href="http://localhost:8080/contract/main.jsp">主页面</A>
        </DIV>
    </FORM>
</div>
</BODY>
</HTML>

