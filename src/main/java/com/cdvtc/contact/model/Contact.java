package com.cdvtc.contact.model;

/**
 * 封装通讯录信息（每个对象代表一条通讯录）
 */
public class Contact {
    private int id;
    private String name;
    private String stuid;
    private String sex;
//    private int classId;
    private ClassInfo classInfo;
    private String mobile;
    private String qq;
    private String email;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStuid() {
        return stuid;
    }

    public void setStuid(String stuid) {
        this.stuid = stuid;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

//    public int getClassId() {
//        return classId;
//    }
//
//    public void setClassId(int classId) {
//        this.classId = classId;
//    }


    public ClassInfo getClassInfo() {
        return classInfo;
    }

    public void setClassInfo(ClassInfo classInfo) {
        this.classInfo = classInfo;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Contact{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", stuid='" + stuid + '\'' +
                ", sex='" + sex + '\'' +
                ", classInfo=" + classInfo +
                ", mobile='" + mobile + '\'' +
                ", qq='" + qq + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
