package com.cdvtc.contact.dao;

import com.cdvtc.contact.db.DBConnection;
import com.cdvtc.contact.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDaoImpl implements ContactDao {
    DBConnection db = new DBConnection();
    @Override
    public List<Contact> getAllContacts() {

        try {
            // 获取连接
            Connection con = db.getConnection();
            // 执行查询
            Statement st = con.createStatement();
            ResultSet resultSet = st.executeQuery("select * from contact");

            // 处理查询结果
            List<Contact> contacts = new ArrayList<Contact>(); // 申明通讯录列表，用于存放通讯录
            while(resultSet.next()){
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");

                Contact contact = new Contact();
                contact.setId(id);
                contact.setName(name);
//                contact.setClassId(resultSet.getInt("classId"));
                int classId = resultSet.getInt("classId");
                contact.setClassInfo(this.getClassInfo(classId)); // （1）获取班级信息对象 （2）将班级信息对象存入通讯录中

                contact.setStuid(resultSet.getString("stuid"));
                contact.setEmail(resultSet.getString("email"));
                contact.setMobile(resultSet.getString("mobile"));
                contact.setQq(resultSet.getString("qq"));
                contact.setSex(resultSet.getString("sex"));

                contacts.add(contact); // 将通讯录对象存入通讯录列表
            }

            // 关闭连接，释放资源
            resultSet.close();
            st.close();
            con.close();

            return contacts;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Contact> getContacts(int classId) {

        try {
            // 获取连接
            Connection con = db.getConnection();
            // 执行查询
            Statement st = con.createStatement();
            ResultSet resultSet = st.executeQuery("select * from contact where classId="+classId);

            // 处理查询结果
            List<Contact> contacts = new ArrayList<Contact>(); // 申明通讯录列表，用于存放通讯录
            while(resultSet.next()){
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");

                Contact contact = new Contact();
                contact.setId(id);
                contact.setName(name);

//                contact.setClassId(resultSet.getInt("classId"));
//                contact.setClassInfo(this.getClassInfo(classId)); // （1）获取班级信息对象 （2）将班级信息对象存入通讯录中
                ClassInfo classInfo = new ClassInfo();
                classInfo.setId(classId);
                contact.setClassInfo(classInfo);
                contact.setStuid(resultSet.getString("stuid"));
                contact.setEmail(resultSet.getString("email"));
                contact.setMobile(resultSet.getString("mobile"));
                contact.setQq(resultSet.getString("qq"));
                contact.setSex(resultSet.getString("sex"));

                contacts.add(contact); // 将通讯录对象存入通讯录列表
            }

            // 关闭连接，释放资源
            resultSet.close();
            st.close();
            con.close();

            return contacts;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void addContact(Contact contact) throws SQLException {
        // 获取数据库连接
        Connection con = db.getConnection();

        PreparedStatement pst = con.prepareStatement("insert into contact(name, stuid, sex, classId, mobile, email,qq) values(?,?,?,?,?,?,?)");
        pst.setString(1, contact.getName());  // 填充参数（？=>姓名）
        pst.setString(2, contact.getStuid());
        pst.setString(3, contact.getSex());
        pst.setInt(4, contact.getClassInfo().getId());
        pst.setString(5, contact.getMobile());
        pst.setString(6, contact.getEmail());
        pst.setString(7, contact.getQq());

        pst.executeUpdate();
        pst.close();
        con.close();
    }

    @Override
    public List<ClassInfo> getAllClassInfos() {
        try {
            // 获取连接
            Connection con = db.getConnection();
            // 执行查询
            Statement st = con.createStatement();
            ResultSet resultSet = st.executeQuery("select * from classInfo");

            // 处理查询结果
            List<ClassInfo> classInfos = new ArrayList<ClassInfo>(); // 申明班级列表，用于存在所有班级对象
            while(resultSet.next()){
                ClassInfo classInfo = new ClassInfo();
                classInfo.setId(resultSet.getInt("id"));
                classInfo.setName(resultSet.getString("name"));

                classInfos.add(classInfo); // 将班级对象加入列表
            }

            // 关闭连接，释放资源
            resultSet.close();
            st.close();
            con.close();

            return classInfos;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean isContactExisted(String stuid) {

        try {
            // 获取连接
            Connection con = db.getConnection();
            PreparedStatement pst = con.prepareStatement("select * from contact where stuid = ?");
            pst.setString(1, stuid);

            //执行查询
            ResultSet rs = pst.executeQuery();

            //处理结果集
            if(rs.next()) {
                // 关闭连接，释放资源
                rs.close();
                pst.close();
                con.close();

                return true;
            }

            // 关闭连接，释放资源
            rs.close();
            pst.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Admin getAdmin(String account, String password) {
        try {
            // 获取连接
            Connection con = db.getConnection();
            PreparedStatement pst = con.prepareStatement("select * from admin where account = ? and password = ?");
            pst.setString(1, account);
            pst.setString(2, password);

            //执行查询
            ResultSet rs = pst.executeQuery();

            //处理结果集
            if(rs.next()) {
                Admin admin = new Admin();
                admin.setAccount(account);
                admin.setPassword(password);
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));

                // 关闭连接，释放资源
                rs.close();
                pst.close();
                con.close();

                return admin;
            }

            // 关闭连接，释放资源
            rs.close();
            pst.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据班级ID获取班级信息
     * @param classId
     * @return
     */
    private ClassInfo getClassInfo(int classId) {

        // 获取数据库连接
        try {
            Connection con = db.getConnection();

            // 执行查询
            Statement st = con.createStatement();
            ResultSet resultSet = st.executeQuery("select * from classinfo where id = "+classId);

            // 处理结果集
            if(resultSet.next()){
                ClassInfo classInfo = new ClassInfo();
                classInfo.setId(classId);
                classInfo.setName(resultSet.getString("name"));

                // 关闭连接，释放资源
                resultSet.close();
                st.close();
                con.close();
                return classInfo;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateContact(Contact contact) {
        try {
            Connection con = db.getConnection();

            PreparedStatement pst = con.prepareStatement("update contact set name=?, stuid=?, sex=?, classId=?, mobile=?, email=?,qq=?  where id=?");

            pst.setString(1, contact.getName());
            pst.setString(2, contact.getStuid());
            pst.setString(3, contact.getSex());
            pst.setInt(4, contact.getClassInfo().getId());
            pst.setString(5, contact.getMobile());
            pst.setString(6, contact.getEmail());
            pst.setString(7, contact.getQq());
            pst.setInt(8, contact.getId());

            pst.executeUpdate();

            // 关闭连接，释放资源
            pst.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
    public Contact getContact(int id) {
        Contact contact = new Contact();

        try {
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from contact where id=" + id);

            if (rs.next()) {
                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setStuid(rs.getString("stuid"));
                contact.setSex(rs.getString("sex"));
                contact.setClassInfo(this.getClassInfo(rs.getInt("classId")));
                contact.setEmail(rs.getString("email"));
                contact.setMobile(rs.getString("mobile"));
                contact.setQq(rs.getString("qq"));
            }

            // 关闭连接，释放资源
            rs.close();
            st.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contact;
    }

    @Override
    public void deleteContact(int id) {
        try {
            Connection con = db.getConnection();
            PreparedStatement pst = con.prepareStatement("delete from contact where id=? and sex=? and classId=?");
            pst.setInt(1, id);

            pst.executeUpdate();
            pst.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Contact> queryContacts(String filter, String sex, int classId) {
        List<Contact> contacts = new ArrayList<Contact>();

        try {
            String sql = "select * from contact where (name like ? or stuid like ? or mobile like ? or qq like ? or email like ?)";
            if("m".equals(sex) || "f".equals(sex)){
                sql += " and sex='"+sex+"'";
            }
            if(classId > 0){
                sql += " and classId="+classId;
            }

            Connection con = db.getConnection();
            PreparedStatement pst =  con.prepareStatement(sql);
            String filterStr = "%" + filter + "%";
            pst.setString(1, filterStr);
            pst.setString(2, filterStr);
            pst.setString(3, filterStr);
            pst.setString(4, filterStr);
            pst.setString(5, filterStr);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Contact contact = new Contact();

                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setStuid(rs.getString("stuid"));
                contact.setSex(rs.getString("sex"));
                contact.setClassInfo(this.getClassInfo(rs.getInt("classId")));
                contact.setEmail(rs.getString("email"));
                contact.setMobile(rs.getString("mobile"));
                contact.setQq(rs.getString("qq"));
                contacts.add(contact);
            }

            rs.close();
            pst.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return contacts;
    }

    @Override
    public PagedData queryPagedContacts(String filter, String sex, int classId, int pageIndex) {
        return queryPagedContacts(filter, sex, classId, pageIndex, 10);
    }

    @Override
    public PagedData queryPagedContacts(String filter, String sex, int classId, int pageIndex, int pageSize) {
        PagedData page = new PagedData();
        page.setPageIndex(pageIndex);
        page.setPageSize(pageSize);


        try {
            //生成查询条件
            String sql = "from contact where (name like ? or stuid like ? or mobile like ? or qq like ? or email like ?)";
            if("m".equals(sex) || "f".equals(sex)){
                sql += " and sex='"+sex+"'";
            }
            if(classId > 0){
                sql += " and classId="+classId;
            }
            String filterStr = "%" + filter + "%";

            // 获取总行数
            Connection con = db.getConnection();
            PreparedStatement totalPst = con.prepareStatement("select count(*)" + sql);
            totalPst.setString(1, filterStr);
            totalPst.setString(2, filterStr);
            totalPst.setString(3, filterStr);
            totalPst.setString(4, filterStr);
            totalPst.setString(5, filterStr);
            ResultSet totalRs =totalPst.executeQuery();
            if(totalRs.next()){
                page.setTotalSize(totalRs.getInt(1));
            }


            // 获取分页数据
            int offset = (pageIndex-1)*pageSize; //计算查询开始行数
            PreparedStatement pst =  con.prepareStatement("select * " + sql + " limit "+offset+"," + pageSize);

            pst.setString(1, filterStr);
            pst.setString(2, filterStr);
            pst.setString(3, filterStr);
            pst.setString(4, filterStr);
            pst.setString(5, filterStr);

            ResultSet rs = pst.executeQuery();
            List<Contact> contacts = new ArrayList<Contact>();
            while (rs.next()) {
                Contact contact = new Contact();

                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setStuid(rs.getString("stuid"));
                contact.setSex(rs.getString("sex"));
                contact.setClassInfo(this.getClassInfo(rs.getInt("classId")));
                contact.setEmail(rs.getString("email"));
                contact.setMobile(rs.getString("mobile"));
                contact.setQq(rs.getString("qq"));
                contacts.add(contact);
            }
            page.setData(contacts);

            rs.close();
            pst.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return page;
    }

    @Override
    public List<StatItem> statContacts() {
        List<StatItem> statItems = new ArrayList<StatItem>();
        try {
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select c.name as cname, sex, count(*) as count from contact left join classinfo as c on contact.classId = c.id group by c.name, sex");
            while(rs.next()) {
                String sex = rs.getString("sex");
                if(sex == null || sex.length() == 0) { //sex为空不加入统计
                    continue;
                } else{
                    StatItem statItem = new StatItem();
                    //翻译性别名称
                    statItem.setSex("m".equalsIgnoreCase(sex)? "男": "女");

                    statItem.setClassName(rs.getString("cname"));
                    statItem.setCount(rs.getInt("count"));

                    statItems.add(statItem);
                }
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return statItems;
    }

    public static void main(String[] args) {
//        ContactDao dao = new ContactDaoImpl();
//        List<Contact> list = dao.getAllContacts();
//        System.out.println("总行数：" + list.size());
////        for(int i=0; i<list.size(); i++){
//////            Contact  contact = list.get(i);
//////            System.out.println("姓名：" + contact.getName());
//////        }
//
//        for(Contact contact: list){
//            System.out.println("姓名：" + contact.getName());
//        }

        ContactDaoImpl dao = new ContactDaoImpl();
//        System.out.println(dao.getClassInfo(1).toString());
//        System.out.println(dao.getAllClassInfos());
//        System.out.println(dao.queryPagedContacts("", "", 0, 2, 12));
        System.out.println(dao.statContacts());
    }
}
