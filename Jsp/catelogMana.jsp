<%@ page language="java" pageEncoding="UTF-8"%>
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
function catelogDel(id) {
	if (confirm('您确定删除吗？')) {
		window.location.href = "<%=path%>/catelog?type=catelogDel&id=" + id;
	}
}

function catelogAdd() {
	var url = "<%=path%>/admin/catelog/catelogAdd.jsp";
	window.location.href = url;
}
</script>
	</head>

	<body leftmargin="2" topmargin="2"
		background='<%=path%>/img/allbg.gif'>
		<table width="98%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
			<tr bgcolor="#E7E7E7">
				<td height="14" colspan="4" background="<%=path%>/img/wbg.gif">
					&nbsp;商品类别&nbsp;
				</td>
			</tr>
			<tr align="center" bgcolor="#FAFAF1" height="22">
				<td width="10%">
					序号
				</td>
				<td width="80%">
					类别名称
				</td>
				<td width="10%">
					操作
				</td>
			</tr>
			<c:forEach items="${requestScope.catelogList}" var="catelog"
				varStatus="sta">
				<tr align='center' bgcolor="#FFFFFF">
					<td bgcolor="#FFFFFF" align="center">
						${sta.index+1}
					</td>
					<td bgcolor="#FFFFFF" align="center">
						${catelog.name}
					</td>
					<td bgcolor="#FFFFFF" align="center">
						<a onclick="catelogDel(${catelog.id})" href="#">删除</a>|
						<a class="pn-loperator"
							href="<%=path%>/admin/catelog/catelogEdit.jsp?id=${catelog.id}">修改</a>
					</td>
				</tr>
			</c:forEach>
		</table>

		<table width='98%' border='0'
			style="margin-top: 8px; margin-left: 8px;">
			<tr>
				<td>
					<input type="button" value="添加类别" style="width: 80px;"
						onclick="catelogAdd()" />
				</td>
			</tr>
		</table>
	</body>
</html>
