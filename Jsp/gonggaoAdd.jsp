<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
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
function check() {

	if (document.formAdd.title.value == 0) {
		alert("请输入标题");
		return false;

	}

	return true;
}
</script>
	</head>

	<body leftmargin="2" topmargin="9"
		background='<%=path%>/img/allbg.gif'>
		<form action="<%=path%>/gonggao?type=gonggaoAdd" name="formAdd"
			method="post">
			<table width="98%" align="center" border="0" cellpadding="4"
				cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
				<tr bgcolor="#EEF4EA">
					<td colspan="3" background="<%=path%>/img/wbg.gif" class='title'>
						<span>新闻公告</span>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						标题：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="title" size="60" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						内容：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
					  <textarea rows="10" cols="30" name="content">
						
						    </textarea>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
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
</html>
