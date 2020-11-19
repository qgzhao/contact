# Web通讯录系统

#### 介绍
&emsp;&emsp;Web通讯录系统，功能包括通讯录列表、导出Excel 、分页显示、新增通讯录、管理员登陆与退出、编辑和删除通讯录。  

#### 技术特点
&emsp;&emsp;系统中用到的技术包括JSP、Servlet、Filter、Listener 、JSTL、JDBC等，未使用框架，适合Java Web初学者学习使用。


#### 使用说明
&emsp;&emsp;系统基于Idea开发，使用maven构建，可以很容易移植到Eclipse for EE（或MyEclipse）。数据库使用mysql8.0，可使用脚本[contact.sql](contact.sql)创建数据库表，
并修改数据库[JDBC配置](src/main/java/com/cdvtc/contact/db/DBConnection.java)
。