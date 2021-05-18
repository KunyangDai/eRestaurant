<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	</head>

	<body  background='<%=path%>/img/allbg.gif'>
		<form action="<%=path%>/admin?type=adminAdd" name="formAdd"
			method="post">
			<table width="98%" align="center" border="0" cellpadding="4"
				cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
				<tr bgcolor="#EEF4EA">
					<td colspan="3" background="<%=path%>/img/wbg.gif" class='title'>
						<span>管理员添加</span>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						帐号：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="userName" size="20" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						密码：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="userPw" size="20" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						类型：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<select name="userType">
							<option value="仓管员">
								仓管员
							</option>
							<option value="销售员">
								销售员
							</option>
							<option value="管理员">
								管理员
							</option>
						</select>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td  colspan="2" align="center" bgcolor="#FFFFFF" align="left">
						<input type="submit" value="提交" />
						&nbsp;
						<input type="reset" value="重置" />
						&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
