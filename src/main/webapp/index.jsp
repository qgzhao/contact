<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.model.Contact" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cdvtc.contact.model.Admin" %>
<%@ page import="com.cdvtc.contact.model.ClassInfo" %>
<%@ page import="com.cdvtc.contact.model.PagedData" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/9/22
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0031)http://localhost:8080/contract/ -->
<HTML>
<HEAD><TITLE>main</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <META http-equiv=pragma content=no-cache>
    <META http-equiv=cache-control content=no-cache>
    <META http-equiv=expires content=0>
    <META http-equiv=keywords content=keyword1,keyword2,keyword3>
    <META http-equiv=description content="This is my page"><!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <STYLE type=text/css>#customers {
        WIDTH: 100%;
        FONT-FAMILY: "Trebuchet MS", Arial, Helvetica, sans-serif;
        BORDER-COLLAPSE: collapse
    }

    #customers TD {
        BORDER-RIGHT: #98bf21 1px solid;
        PADDING-RIGHT: 7px;
        BORDER-TOP: #98bf21 1px solid;
        PADDING-LEFT: 7px;
        FONT-SIZE: 1em;
        PADDING-BOTTOM: 2px;
        BORDER-LEFT: #98bf21 1px solid;
        PADDING-TOP: 3px;
        BORDER-BOTTOM: #98bf21 1px solid
    }

    #customers TH {
        BORDER-RIGHT: #98bf21 1px solid;
        PADDING-RIGHT: 7px;
        BORDER-TOP: #98bf21 1px solid;
        PADDING-LEFT: 7px;
        FONT-SIZE: 1em;
        PADDING-BOTTOM: 2px;
        BORDER-LEFT: #98bf21 1px solid;
        PADDING-TOP: 3px;
        BORDER-BOTTOM: #98bf21 1px solid
    }

    #customers TH {
        FONT-SIZE: 1.1em;
        PADDING-BOTTOM: 4px;
        COLOR: #ffffff;
        PADDING-TOP: 5px;
        BACKGROUND-COLOR: #a7c942;
        TEXT-ALIGN: left
    }

    #customers TR.alt TD {
        COLOR: #000000;
        BACKGROUND-COLOR: #eaf2d3
    }
    </STYLE>

    <META content="MSHTML 6.00.2900.5726" name=GENERATOR>
</HEAD>
<BODY>
<DIV style="TEXT-ALIGN: right">
    在线人数：${onlineCount}
    通讯录 <A
        href="register.jsp">注册</A> 管理员
    <%--  <%--%>
    <%--    Admin admin =  (Admin)session.getAttribute("admin");--%>

    <%--    if(admin != null) {--%>
    <%--  %>--%>
    <%--  <A href="logout.jsp">退出</A>--%>
    <%--  <%} else {%>--%>
    <%--  <A href="login.jsp">登陆</A>--%>
    <%--  <%}%>--%>
    <c:if test="${sessionScope['admin'] ne null}">
        <A href="logout.jsp">退出</A>
    </c:if>
    <c:if test="${sessionScope['admin'] eq null}">
        <A href="login.jsp">登陆</A>
    </c:if>
</DIV>

<%--<%--%>
<%--  if(admin != null){--%>
<%--%>--%>
<%--<DIV><SPAN>当前用户:<%=admin.getAccount()%>[<%=admin.getName()%>]</SPAN> </DIV>--%>
<%--<%}%>--%>
<c:if test="${sessionScope['admin'] ne null}">
    <DIV>
        <SPAN>当前用户:${sessionScope['admin'].account}[${sessionScope['admin'].name}]</SPAN>
    </DIV>
</c:if>
<H3>通讯录列表</H3>
<div>
    <%
        //获取参数
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        String classIdStr = request.getParameter("classId");
        String pageIndexStr = request.getParameter("pageIndex");
        int classId = 0;
        int pageIndex = 1;
        if (classIdStr != null) {
            classId = Integer.parseInt(classIdStr);
        }

        if (name == null) {
            name = "";
        }

        if (pageIndexStr != null) {
            pageIndex = Integer.parseInt(pageIndexStr);
        }

        pageContext.setAttribute("name", name);
        pageContext.setAttribute("sex", sex);
        pageContext.setAttribute("classId", classId);


        ContactDao dao = new ContactDaoImpl();
        //        List<Contact> contactList = dao.queryContacts(name, sex, classId);
        //        pageContext.setAttribute("contactList", contactList); // 设置变量，EL表达式中需要取值

        PagedData paged = dao.queryPagedContacts(name, sex, classId, pageIndex);
        pageContext.setAttribute("paged", paged); // 设置变量，EL表达式中需要取值

        List<ClassInfo> classInfoList = dao.getAllClassInfos();
    %>
    <form>
        性别：<select name="sex">
        <option value="">所有</option>
        <option value="m" <%="m".equals(sex) ? "selected" : ""%>>男</option>
        <option value="f" <%="f".equals(sex) ? "selected" : ""%>>女</option>
    </select>
        班级：<select name=classId>
        <option value="0">所有</option>
        <% for (ClassInfo classInfo : classInfoList) { %>
        <option value=<%=classInfo.getId()%> <%=classInfo.getId() == classId ? "selected" : ""%>><%=classInfo.getName()%>
        </option>
        <%}%>
    </select>
        关键字：<input name="name" placeholder="请输入姓名、学号、电话号码等关键字" value="<%=name%>"> <input type="submit" value="查询">
    </form>
</div>
<p align="right"><a href="stat.jsp">统计图</a> <a href="export">导出Excel</a></p>
<TABLE id=customers>
    <THEAD>
    <TR>
        <TH witdh="10%">姓名</TH>
        <TH witdh="10%">性别</TH>
        <TH witdh="15%">学号</TH>
        <TH witdh="15%">班级</TH>
        <TH witdh="20%">手机号码</TH>
        <TH witdh="20%">电子邮件</TH>
        <TH witdh="10%">QQ号码</TH>
        <%--    <% if (session.getAttribute("admin") != null) {%>--%>
        <%--    <th witdh="10%">操作</th>--%>
        <%--    <% }%>--%>
        <c:if test="${sessionScope['admin'] ne null}">
            <TH witdh="10%">操作</TH>
        </c:if>
    </TR>
    </THEAD>
    <TBODY>
    <%
        //        // 获取通讯录列表数据
//        ContactDao dao = new ContactDaoImpl();
//        List<Contact>  contactList = dao.getAllContacts();
//        pageContext.setAttribute("contactList", contactList);  // 设置变量，EL表达式中需要取值
        boolean alt = false;
//        pageContext.setAttribute("alt", alt);
//    for(Contact contact: contactList) {
    %>
    <c:forEach items="${paged.data}" var="contact">

        <TR  <%if (alt) {%> class="alt" <%}%>>

            <TD>
                    <%-- <%=contact.getName()%> --%>
                    ${contact.name}
            </TD>
            <TD>
                    <%--      <% if(contact.getSex().equalsIgnoreCase("m")){%>--%>
                    <%--        男--%>
                    <%--      <%} else {%>--%>
                    <%--      女--%>
                    <%--      <%}%>--%>
                    <%--      <%=contact.getSex() == null ? "" : (contact.getSex().equalsIgnoreCase("m")? "男" : "女")%>--%>
                    ${contact.sex eq 'm' ? '男': '女'}
            </TD>
            <TD>
                    <%--      <%=contact.getStuid()%>--%>
                    ${contact.stuid}
            </TD>
            <TD>
                    <%--    <%=contact.getClassInfo().getName()%>--%>
                    ${contact.classInfo.name}
            </TD>
            <TD>
                    <%--    <%=contact.getMobile()%> --%>
                    ${contact.mobile}
            </TD>
            <TD>
                    <%--    <%=contact.getEmail()%>--%>
                    ${contact.email}
            </TD>
            <TD>
                    <%--    <%=contact.getQq()%>--%>
                    ${contact.qq}
            </TD>
                <%--    <% if (session.getAttribute("admin") != null) {%>--%>
                <%--    <td><a href="edit.jsp?id=<%=contact.getId()%>">编辑</a>--%>
                <%--      <a href="javascript:void(0)" onclick="deleteContact(<%=contact.getId()%>, <%=contact.getStuid()%>)">删除</a>--%>
                <%--    </td>--%>
                <%--    <% }%>--%>
            <c:if test="${sessionScope['admin'] ne null}">
                <TD>
                    <a href="edit.jsp?id=${contact.id}">编辑</a>
                    <a href="javascript:void(0)" onclick="deleteContact(${contact.id}, ${contact.stuid})">删除</a>
                </TD>
            </c:if>
        </TR>
        <%
            alt = !alt;
            //}
        %>
    </c:forEach>
    </TBODY>
</TABLE>
<p align="center">
    总共${paged.totalSize}行 当前显示${paged.firstRow}-${paged.lastRow}行
    共${paged.totalPages}页 当前第${paged.pageIndex}页
    <a href="${pageContext.request.requestURL}?classId=${classId}&sex=${sex}&name=${name}&pageIndex=1">首页</a>
    <a href="${pageContext.request.requestURL}?classId=${classId}&sex=${sex}&name=${name}&pageIndex=${paged.previousPage}">上一页</a>
    <a href="${pageContext.request.requestURL}?classId=${classId}&sex=${sex}&name=${name}&pageIndex=${paged.nextPage}">下一页</a>
    <a href="${pageContext.request.requestURL}?classId=${classId}&sex=${sex}&name=${name}&pageIndex=${paged.totalPages}">末页</a>
</p>
<script>
    function deleteContact(id, stuid) {
        var result = window.confirm("您确定要删除通讯录【stuid=" + stuid + "】吗？");
        if (result) {
            //执行删除
            window.location.href = 'delete.jsp?id=' + id;
        }
    }
</script>
</BODY>
</HTML>
