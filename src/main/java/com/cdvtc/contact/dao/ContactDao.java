package com.cdvtc.contact.dao;

import com.cdvtc.contact.model.*;

import java.sql.SQLException;
import java.util.List;

public interface ContactDao {

    /**
     * 获取所有通讯录
     * @return 通讯录列表（List）
     */
    List<Contact> getAllContacts();


    /**
     * 获取班级通讯录(注意：结果中不再包含班级详细信息对象）
     * @param classId
     * @return
     */
    List<Contact> getContacts(int classId);

    /**
     * 增加通讯录
     * @param contact
     */
    void addContact(Contact contact) throws SQLException;

    /**
     * 获取所有班级信息
     * @return
     */
    List<ClassInfo> getAllClassInfos();

    /**
     * 判断给定学号的通讯录是否存在
     * @param stuid
     * @return true:存在，false:不存在
     */
    boolean isContactExisted(String stuid);


    /**
     * 根据账户、密码获取管理员信息
      * @param account
     * @param password
     * @return 管理员对象，null: 管理员对象不存在
     */
    Admin getAdmin(String account, String password);

    /**
     * 根据ID获取通讯录
     * @param id
     * @return
     */
    Contact getContact(int id);

    /**
     * 更新通讯录
     * @param contact
     */
    void updateContact(Contact contact);

    /**
     * 删除通讯录
     * @param id
     */
    void deleteContact(int id);

    /**
     * 模糊查询通讯录
     * @param filter
     * @return
     */
    List<Contact> queryContacts(String filter, String sex, int classId);


    /**
     * 模糊查询（分页）
     * @param filter
     * @param sex
     * @param classId
     * @param pageIndex
     * @return
     */
    PagedData queryPagedContacts(String filter, String sex, int classId, int pageIndex);

    /**
     * 模糊查询（分页）
     * @param filter
     * @param sex
     * @param classId
     * @param pageIndex
     * @param pageSize
     * @return
     */
    PagedData queryPagedContacts(String filter, String sex, int classId, int pageIndex, int pageSize);


    /**
     * 统计通讯录（根据班级、性别统计人数）
     * @return
     */
    List<StatItem> statContacts();
}
