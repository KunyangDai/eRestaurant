<%@ page language="java" import="com.cn.dao.*,java.sql.*"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<script type="text/javascript"
			src="<%=path%>/My97DatePicker/WdatePicker.js">
		</script>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/base.css" />
		<script type="text/javascript" src="<%=path%>/js/popup.js">
		</script>

	</head>

	<body background='<%=path%>/img/allbg.gif'>
		<table width='98%' border='0'
			style="margin-top: 8px; margin-left: 9px;">
			<tr>
				<td>
					<form method="post" action="<%=path%>/admin/xiao/goodsxl.jsp">
						时间范围：
						<input type="text" name="bdate" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
						-
						<input type="text" name="edate" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
						<input type="submit" value="查询" />
					</form>
				</td>
			</tr>
		</table>

		<table width="98%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
			<tr bgcolor="#E7E7E7">
				<td height="14" colspan="9" background="<%=path%>/img/wbg.gif">
					销量查看&nbsp;
				</td>
			</tr>
			<tr align="center" bgcolor="#FAFAF1">
				<td width="10%">
					排行
				</td>

				<td width="15%">
					商品品名称
				</td>
				<td width="15%">
					商品品价格
				</td>



				<td width="10%">
					销量
				</td>

			</tr>
			<%
				String asql = "";
				String bdate = request.getParameter("bdate");
				if (bdate != null && bdate.length() > 0) {
					asql = asql + " and  tor.shijian>='" + bdate + "'";
				}

				String edate = request.getParameter("edate");
				if (edate != null && edate.length() > 0) {
					asql = asql + " and  tor.shijian<='" + edate + "'";
				}

				String sql = "select * from (select sum(goods_quantity) as xiaoliang,goods_id as gid from t_orderitem toi,t_order tor where toi.order_id=tor.id  "
						+ asql
						+ " group by goods_id order by sum(goods_quantity) desc) xiao,t_goods tg where xiao.gid=tg.id";
				Object[] params = {};
				DB mydb = new DB();
				String info = "";
				int i = 0;
				try {
					mydb.doPstm(sql, params);
					ResultSet rs = mydb.getRs();
					while (rs.next()) {
						i++;
			%>
			<tr align='center' bgcolor="#FFFFFF">
				<td bgcolor="#FFFFFF" align="center">
					<%=i%>
				</td>

				<td bgcolor="#FFFFFF" align="center">
					<%=rs.getString("mingcheng")%>
				</td>
				<td bgcolor="#FFFFFF" align="center">
					<%=rs.getString("jiage")%>
				</td>

				<td bgcolor="#FFFFFF" align="center">
					<%=rs.getInt("xiaoliang")%>
				</td>

			</tr>
			<%
				}
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				mydb.closed();
			%>


		</table>


	</body>
</html>
