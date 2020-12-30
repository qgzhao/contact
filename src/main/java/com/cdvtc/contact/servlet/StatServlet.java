package com.cdvtc.contact.servlet;

import com.cdvtc.contact.dao.ContactDao;
import com.cdvtc.contact.dao.ContactDaoImpl;
import com.cdvtc.contact.model.StatItem;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "StatServlet", urlPatterns = "/stat")
public class StatServlet extends HttpServlet {
    private ContactDao dao = new ContactDaoImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<StatItem> statItems = dao.statContacts();

        String jsonStr = toJson(statItems);

        //向客户端发送JSON
        response.setContentType("text/json; charset=UTF-8");
        response.getOutputStream().write(jsonStr.getBytes("UTF-8"));
    }

    /**
     * 将统计数据转换成Echart所要求的JSON格式
     * @param statItems
     * @return
     */
    private String toJson(List<StatItem> statItems){

        //生成Echart所需格式：【category:['班级1', '班级2']，series:[{name:'男', data:[23,24]}, {name:'女', data:[6,8]}]】
        List<String> categories = new ArrayList<String>();  //存入所有班级
        for(StatItem item: statItems) {
            if(!categories.contains(item.getClassName())) {
                categories.add(item.getClassName());
            }
        }

        Gson gson=new Gson();
        JsonObject echartsJson = new JsonObject();
        echartsJson.add("category", gson.toJsonTree(categories));

        Map<String, List<Integer>> series = new HashMap<String, List<Integer>>();
        for(StatItem item: statItems) {
            if(!series.keySet().contains(item.getSex())) {
                series.put(item.getSex(), new ArrayList<Integer>()); //对所有性别，先存入空列表
            }
        }

        for(String sex: series.keySet()){ //为每个性别填写统计数据
            for (StatItem item: statItems) {
                if(item.getSex().equals(sex)) {
                    series.get(sex).add(item.getCount());
                }
            }
        }

        JsonArray seriesJson = new JsonArray();
        for(String sex: series.keySet()) {
            JsonObject sexJson = new JsonObject();
            sexJson.addProperty("name", sex);
            sexJson.addProperty("type", "bar");
            sexJson.add("data", gson.toJsonTree(series.get(sex)));
            seriesJson.add(sexJson);
        }
        echartsJson.add("series", seriesJson);

        return echartsJson.toString();
    }
}
