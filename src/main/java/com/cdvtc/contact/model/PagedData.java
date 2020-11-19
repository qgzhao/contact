package com.cdvtc.contact.model;

import java.util.List;

/**
 * 分页数据（通讯录列表及分页相关信息封装）
 */
public class PagedData {
    private int pageSize = 10; //分页大小
    private int pageIndex = 1; //当前页（第几页）
    private int totalSize; //总行数
    private List<Contact> data; //数据（当前分页）


    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getTotalSize() {
        return totalSize;
    }

    public void setTotalSize(int totalSize) {
        this.totalSize = totalSize;
    }

    public List<Contact> getData() {
        return data;
    }

    public void setData(List<Contact> data) {
        this.data = data;
    }

    /**
     * 获取开始行
     *
     * @return
     */
    public int getFirstRow() {
        int firstRow = (pageIndex - 1) * pageSize + 1;
        return firstRow > 0 ? firstRow : 1;
    }

    /**
     * 获取结束行
     *
     * @return
     */
    public int getLastRow() {
        int lastRow = pageIndex * pageSize;
        return lastRow > totalSize ? totalSize : lastRow;
    }

    /**
     * 获取总页数
     *
     * @return
     */
    public int getTotalPages() {
        int totalPages = totalSize / pageSize;
        return totalSize % pageSize == 0 ? totalPages : totalPages + 1;
    }

    /**
     * 获取上一页
     *
     * @return
     */
    public int getPreviousPage() {
        return pageIndex <= 1 ? 1 : pageIndex - 1;
    }

    /**
     * 获取下一页
     */
    public int getNextPage() {
        int totalPages = getTotalPages();
        return pageIndex >= totalPages ? totalPages : pageIndex + 1;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageSize=" + pageSize +
                ", gageIndex=" + pageIndex +
                ", totalSize=" + totalSize +
                ", data=" + data +
                '}';
    }
}
