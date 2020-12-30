package com.cdvtc.contact.model;

/**
 * 统计项（用于统计班级、性别和人数）
 */
public class StatItem {
    private String className; //班级名称
    private String sex; //性别
    private Integer count; //统计数量

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "StatItem{" +
                "className='" + className + '\'' +
                ", sex='" + sex + '\'' +
                ", count=" + count +
                '}';
    }
}
