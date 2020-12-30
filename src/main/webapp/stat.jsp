<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/30
  Time: 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>班级通讯录统计</title>
    <meta charset="utf-8">
    <!-- 引入 ECharts -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.0.0/dist/echarts.min.js"></script>
    <!-- 引入 jquery -->
    <script src="http://lib.sinaapp.com/js/jquery/1.7.2/jquery.min.js"></script>
</head>
<body>
<!-- echarts图显示位置 -->
<div id="main" style="width: 800px;height:600px; margin: 0 auto"></div>
<div>
    返回 <a href="index.jsp">主页面</a>
</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart  = echarts.init(document.getElementById('main'));

    $.get('./stat').done(function (data) {
        myChart.setOption({
            title: {
                text: '通讯录（按班级、性别）统计图'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            xAxis: {
                type: 'category',
                data: data.category
            },
            yAxis: {},
            series: data.series,
            toolbox: { //可视化的工具箱
                show: true,
                feature: {
                    dataView: { //数据视图
                        show: true
                    },
                    restore: { //重置
                        show: true
                    },
                    dataZoom: { //数据缩放视图
                        show: true
                    },
                    saveAsImage: {//保存图片
                        show: true
                    }
                }
            }
        });
    });
</script>
</body>
</html>
