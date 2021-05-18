<%@ page language="java" import="java.util.*,java.sql.*,com.cn.dao.*"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>

<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />

		<link rel="stylesheet" type="text/css" href="<%=path%>/css/base.css" />
		<script type="text/javascript" src="<%=path%>/js/popup.js">
		</script>
		<script type='text/javascript'
			src='<%=path%>/dwr/interface/loginService.js'>
		</script>
		<script type='text/javascript' src='<%=path%>/dwr/engine.js'>
		</script>
		<script type='text/javascript' src='<%=path%>/dwr/util.js'>
		</script>
		<script language="javascript">
var i = 0;
function catelogAll() {
	if (i == 0) {
		document.getElementById("indicator").style.display = "block";
		loginService.catelogAll(callback);
		i = 1;
	}

}
function callback(data) {
	document.getElementById("indicator").style.display = "none";
	DWRUtil.addOptions("catelog_id", data, "id", "name");
}

function up() {
	var pop = new Popup( {
		contentType : 1,
		isReloadOnClose : false,
		width : 400,
		height : 200
	});
	pop.setContent("contentUrl", "<%=path%>/upload/upload.jsp");
	pop.setContent("title", "文件上传");
	pop.build();
	pop.show();
}

function check() {
	if (document.formAdd.catelog_id.value == 0) {
		alert("请选择类别");
		return false;
	}

	return true;
}
</script>
	</head>
	<%
		DB dbm = new DB();
		Connection conn = dbm.getCon();
		String id = request.getParameter("id");
		String sql = "select * from t_goods where id='" + id + "'";
		PreparedStatement stat = conn.prepareStatement(sql);
		ResultSet rs = stat.executeQuery();
		rs.next();
		System.out.println(rs.getString("jiage") + "");
	%>

	<body leftmargin="2" topmargin="9"
		background='<%=path%>/img/allbg.gif' onload="catelogAll()">
		<form action="<%=path%>/goods?type=goodsUpdate" name="formAdd"
			method="post">
			<table width="98%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
				<tr bgcolor="#E7E7E7">
					<td height="14" colspan="4" background="<%=path%>/img/wbg.gif">
						&nbsp;商品修改&nbsp;
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						类别：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<table border="0">
							<tr>
								<td>
									<select name="catelog_id" id="catelog_id" style="width: 150px;"
										onclick="catelogAll()">
										<option value="0">
											请选择类别
										</option>
									</select>
								</td>
								<td>
									<img id="indicator" src="<%=path%>/img/loading.gif"
										style="display: none" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						编号：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="bianhao" size="40"
							value="<%=rs.getString("bianhao")%>" />
						<input type="hidden" name="id" size="60" value="<%=id%>" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						名称：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="mingcheng" size="40"
							value="<%=rs.getString("mingcheng")%>" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						介绍：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						  <textarea rows="10" cols="50" name="jieshao">
						     <%=rs.getString("jieshao") %>
						    </textarea>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						品牌：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="pinpai" size="40"
							value="<%=rs.getString("pinpai")%>" />
					</td>
				</tr>
				
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						图片：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="fujian" value="<%=rs.getString("fujian")%>" id="fujian" size="40"
							readonly="readonly" />
						<input type="button" value="上传" onclick="up()" />
						<input type="hidden" name="fujian" id="fujian" value="<%=rs.getString("fujian")%>"/>
					</td>
				</tr>

				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						价格：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="jiage" size="40"
							value="<%=rs.getString("jiage")%>"
							onpropertychange="onchange1(this.value)"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onafterpaste="this.value=this.value.replace(/\D/g,'')" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='red';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"> 
					<td colspan="2" align="center" bgcolor="#FFFFFF" align="left">
						<input type="submit" value="提交" onclick="return check()" />
						&nbsp;
						<input type="reset" value="重置" />
						&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</body>
	<%
		if (rs != null)
			rs.close();
		if (stat != null)
			stat.close();
		if (conn != null)
			conn.close();
	%>
</html>
