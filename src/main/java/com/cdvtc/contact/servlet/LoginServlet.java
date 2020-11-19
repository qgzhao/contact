package com.cdvtc.contact.servlet;

import com.cdvtc.contact.dao.ContactDao;
import com.cdvtc.contact.dao.ContactDaoImpl;
import com.cdvtc.contact.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取参数
        String account = request.getParameter("account");
        String password = request.getParameter("password");

        ContactDao dao = new ContactDaoImpl();
        Admin admin = dao.getAdmin(account, password);
        // if("admin".equals(account) && "admin".equals(password)){
        if(admin != null) { //验证-成功：跳转到首页
            HttpSession session = request.getSession();  //从request得到session对象(Servlet中必须这样处理）
            session.setAttribute("admin", admin); //保存管理员对象到Session
            response.sendRedirect("index.jsp");
        } else {  //验证-失败：返回（前转）到：登陆页面
            //传递错误信息
            request.setAttribute("error", "账户或密码错误！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       doPost(request, response);
    }
}
