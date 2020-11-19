package com.cdvtc.contact.servlet;

import com.cdvtc.contact.dao.ContactDao;
import com.cdvtc.contact.dao.ContactDaoImpl;
import com.cdvtc.contact.model.ClassInfo;
import com.cdvtc.contact.model.Contact;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet(name = "ExportServlet", urlPatterns = "/export")
public class ExportServlet extends HttpServlet {

    private ContactDao dao = new ContactDaoImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");//设置request的编码方式，防止中文乱码
        String fileName = "通讯录导出.xls";//设置导出的文件名称
        String contentType = "application/vnd.ms-excel";//定义导出文件的格式的字符串
        String recommendedName = new String(fileName.getBytes("GBK"), "iso_8859_1");//设置文件名称的编码格式
        response.setContentType(contentType);//设置导出文件格式
        response.setHeader("Content-Disposition", "attachment; filename=" + recommendedName);//
        response.resetBuffer();

        //将输出流传递给JXL进行写Excel工作簿内容
        WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());

        List<ClassInfo> classInfoList = dao.getAllClassInfos(); //获取所有班级
        try {
            for (int i=0; i<classInfoList.size(); i++) {
                ClassInfo classInfo = classInfoList.get(i);
                WritableSheet sheet = workbook.createSheet(classInfo.getName(), i);
                createClassSheet(sheet, classInfo); //创建sheet(按照班级）
            }
            workbook.write();  //执行写操作
            workbook.close();  //关闭工作簿
        } catch (WriteException e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建班级工作表（Sheet）
     */
    private void createClassSheet(WritableSheet sheet, ClassInfo classInfo) throws WriteException {
        //第一行设置列名:创建数组
        String[] titles = {"姓名", "性别", "学号", "手机号码", "电子邮件", "QQ号码"};
        Label label = null;
        //设置列名
        for (int i = 0; i < titles.length; i++) {
            label = new Label(i, 0, titles[i]);
            sheet.addCell(label);
        }

        //追加数据
        List<Contact> contacts = dao.getContacts(classInfo.getId());
        for (int i = 0; i < contacts.size(); i++) {
            Contact contact = contacts.get(i);

            label = new Label(0, i+1, contact.getName()); //第1列：姓名
            sheet.addCell(label);

            label = new Label(1, i+1, "m".equalsIgnoreCase(contact.getSex()) ? "男" : "女"); //第2列：性别
            sheet.addCell(label);

            label = new Label(2, i+1, contact.getStuid()); //第3列：学号
            sheet.addCell(label);

            label = new Label(3, i+1, contact.getMobile()); //第4列：手机号码
            sheet.addCell(label);

            label = new Label(4, i+1, contact.getEmail()); //第5列：电子邮件
            sheet.addCell(label);

            label = new Label(5, i+1, contact.getQq()); //第6列：QQ号码
            sheet.addCell(label);
        }
    }
}
