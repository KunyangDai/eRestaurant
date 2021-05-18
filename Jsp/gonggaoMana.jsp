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

		<script language="JavaScript" src="<%=path%>/js/public.js"
			type="text/javascript">
		</script>

		<script language="javascript">
function gonggaoAdd() {
	var url = "<%=path%>/admin/gonggao/gonggaoAdd.jsp";
	window.location.href = url;
}

function gonggaoDetail(id) {
	var url = "<%=path%>/gonggao?type=gonggaoDetail&id=" + id;
	var n = "";
	var w = "480px";
	var h = "500px";
	var s = "resizable:no;help:no;status:no;scroll:yes";
	openWin(url, n, w, h, s);
}

function gonggaoDel(id) {
	if (confirm('您确定删除吗？')) {
		window.location.href = "<%=path%>/gonggao?type=gonggaoDel&id=" + id;
	}
}
</script>
	</head>

	<body background='<%=path%>/img/allbg.gif'>
		<table width="98%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
			<tr bgcolor="#E7E7E7">
				<td colspan="4" background="<%=path%>/img/wbg.gif">
					&nbsp;新闻公告&nbsp;
				</td>
			</tr>
			<tr align="center" bgcolor="#FAFAF1">
				<td width="25%">
					标题
				</td>
				<td width="25%">
					发布时间
				</td>
				<td width="25%">
					内容
				</td>
				<td width="25%">
					操作
				</td>
			</tr>
			<c:forEach items="${requestScope.gonggaoList}" var="gonggao">
				<tr align='center' bgcolor="#FFFFFF">
					<td bgcolor="#FFFFFF" align="center">
						${gonggao.title}
					</td>
					<td bgcolor="#FFFFFF" align="center">
						${gonggao.shijian}
					</td>
					<td bgcolor="#FFFFFF" align="center">
						<a href="#" onclick="gonggaoDetail(${gonggao.id})"
							class="pn-loperator">查看内容</a>
					</td>
					<td bgcolor="#FFFFFF" align="center">
						<a class="pn-loperator"
							  onclick="gonggaoDel(${gonggao.id})" href="#">删除</a>|
						<a class="pn-loperator"
							href="<%=path%>/admin/gonggao/gonggaoEdit.jsp?id=${gonggao.id}">修改</a>
					</td>
				</tr>
			</c:forEach>
		</table>

		<table width='98%' border='0'
			style="margin-top: 8px; margin-left: 8px;">
			<tr>
				<td>
					<input type="button" value="添加新闻公告" style="width: 100px;"
						onclick="gonggaoAdd()" />
				</td>
			</tr>
		</table>
	</body>
</html>
