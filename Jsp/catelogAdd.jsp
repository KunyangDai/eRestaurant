<%@ page language="java" pageEncoding="UTF-8"%>
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

		<script language="javascript">
function check() {

	if (document.formAdd.name.value == 0) {
		alert("请输入名称");
		return false;

	}

	return true;
}
</script>
	</head>

	<body leftmargin="2" topmargin="9"
		background='<%=path%>/img/allbg.gif'>
		<form action="<%=path%>/catelog?type=catelogAdd" name="formAdd"
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
						<input type="text" name="name" size="40" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="75%" bgcolor="#FFFFFF" colspan="2" align="center">
						<input type="submit" value="提交" onclick="return check()" />
						&nbsp;
						<input type="reset" value="重置" />
						&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
