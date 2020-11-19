package com.cdvtc.contact.db;

import java.sql.*;

public class DBConnection {

    /**
     * 获取数据库连接
     */
    public Connection getConnection() throws SQLException {

        // 注册驱动类
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // 获取连接,URL
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/contact?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Shanghai&&"
                + "user=root&password=123456");

        return con;
    }

    public static void main(String[] args) throws SQLException {
        DBConnection db = new DBConnection();
        Connection con =  db.getConnection();
        // 获取数据
        Statement st = con.createStatement();
        ResultSet resultSet = st.executeQuery("select * from contact");// 执行SQL查询
        while(resultSet.next()){
           String name = resultSet.getString("name"); // 获取指定列（这里用列表）
           System.out.println("姓名："+ name);
        }
        con.close();
    }
}
