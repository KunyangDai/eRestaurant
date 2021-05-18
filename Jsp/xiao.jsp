<%@ page language="java" import="com.cn.dao.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />

		<link rel="stylesheet" type="text/css" href="<%=path%>/css/base.css" />
		<script type="text/javascript" src="<%=path%>/js/popup.js">
		</script>
		<script language="JavaScript" src="<%=path%>/js/public.js"
			type="text/javascript">
		</script>
		<script language="JavaScript"
			src="<%=path%>/FusionCharts/JS/FusionCharts.js">
		</script>
	</head>

	<body background='<%=path%>/img/allbg.gif'>

		<div align="center" id="chartdiv1">

		</div>

		<%
			String sql = "select * from (select sum(goods_quantity) as xiaoliang,goods_id as gid from t_orderitem group by goods_id order by sum(goods_quantity) desc) xiao,t_goods tg where xiao.gid=tg.id";
			Object[] params = {};
			DB mydb = new DB();
			String info = "";
			try {
				mydb.doPstm(sql, params);
				ResultSet rs = mydb.getRs();
				while (rs.next()) {
					info = info + "<set name='" + rs.getString("mingcheng")
							+ "' value='" + rs.getInt("xiaoliang") + "' />";
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mydb.closed();
		%>

		<script type="text/javascript">
var myChart = new FusionCharts("<%=path%>/FusionCharts/Charts/Pie3D.swf",
		"myChartId", "1000", "400");
var strXML = "<chart caption='销量统计报表' baseFontSize='15'><%=info%></chart>";
myChart.setDataXML(strXML);

myChart.render("chartdiv1");

$(document).ready(function() {
	var $messageInfo = $("#messageInfo").val();
	if ($messageInfo != null && $messageInfo != "") {
		$.messager.show( {
			title : '提示',
			msg : $messageInfo,
			timeout : 2000,
			showType : 'slide'
		});
		$("#messageInfo").val("");
	}
});
</script>
	</body>
</html>
