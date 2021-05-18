<%@ page language="java" import="java.util.*,java.sql.*,com.cn.dao.*"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<%
	String path = request.getContextPath();
%>

<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />

		<link rel="stylesheet" type="text/css" href="<%=path%>/css/base.css" />

		<script language="javascript">
</script>
	</head>
	<%
		DB dbm = new DB();
		Connection conn = dbm.getCon();
		String id = request.getParameter("id");
		String sql = "select * from t_catelog where id='" + id + "'";
		PreparedStatement stat = conn.prepareStatement(sql);
		ResultSet rs = stat.executeQuery();
		rs.next();
	%>
	<body leftmargin="2" topmargin="9"
		background='<%=path%>/img/allbg.gif'>
		<form action="<%=path%>/catelog?type=catelogUpdate" name="formAdd"
			method="post">
			<table width="98%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
				<tr bgcolor="#E7E7E7">
					<td height="14" colspan="4" background="<%=path%>/img/wbg.gif">
						&nbsp;商品类别&nbsp;
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						类别名称：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="name" size="40"
							value="<%=rs.getString("name")%>" />
						<input type="hidden" name="id" size="60" value="<%=id%>" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">

					<td width="75%" bgcolor="#FFFFFF" colspan="2" align="center">
						<input type="submit" value="提交" />
						&nbsp;
						<input type="reset" value="重置" />
						&nbsp;
					</td>
				</tr>
			</table>
		</form>
		<%
			if (rs != null)
				rs.close();
			if (stat != null)
				stat.close();
			if (conn != null)
				conn.close();
		%>
	</body>
</html>
