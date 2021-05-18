<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<LINK href="<%=path%>/css/css.css" type=text/css rel=stylesheet>

	</head>

	<BODY text=#000000 leftMargin=0 topMargin=0>
		<div class="wrap">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0
				background="<%=path%>/img/reservation01.jpg">
				<TR>
					<TD align="center">
						<jsp:include flush="true" page="/qiantai/inc/incTop1.jsp"></jsp:include>
					</TD>
				</TR>
			</TABLE>


			<jsp:include flush="true" page="/qiantai/inc/incTop2.jsp"></jsp:include>
			<TABLE class=MainTable style="MARGIN-TOP: 0px" cellSpacing=0
				cellPadding=0 width="100%" align=center border=0>
				<TR>


					<TD class=Side vAlign=top align=right width="70%">

						<TABLE class=dragTable cellSpacing=0 cellPadding=0 width="100%"
							border=0>
							<TR>
								<TD class=head>
									<span class=TAG>热销商品</span>
									<span style="float: right"><a
										href="<%=path%>/goods?type=goodsManaQian">更多</a>&nbsp;</span>
								</TD>
							</TR>
							<TR align="left" height="180">
								<TD>
									<table cellspacing="8" cellpadding="1" align="center"
										border="0">
										<tr>
											<c:forEach items="${requestScope.paihangList}" var="goods"
												varStatus="sta">
												<c:if test="${sta.index%4==0}">
										</tr>
										<tr>
											</c:if>
											<td align="center">
												<a
													href="<%=path%>/goods?type=goodsDetailQian&id=${goods.id }">
													<img width="120" height="140"
														src="<%=path%>/${goods.fujian }"
														style="border: 1px solid #ccc; padding: 3px;" /> </a>
												<br>
												${goods.mingcheng } (￥:${goods.jiage }元)
											</td>
											</c:forEach>
										</tr>
									</table>
								</TD>
							</TR>
						</TABLE>
					</TD>
					<TD width="1">
						&nbsp;
					</TD>
					<TD class=Side rowspan="2" vAlign=top align=right width="30%">
						<jsp:include flush="true" page="/qiantai/inc/incLeft.jsp"></jsp:include>
					</TD>
				</TR>
				<TR>
					<TD class=Side vAlign=top align=right width="70%">

						<TABLE  class=dragTable cellSpacing=0 cellPadding=0 width="100%"
							border=0>
							<TR>
								<TD class=head  background="#F00" bgcolor="#F00">
									<span class=TAG >最新商品</span>
									<span style="float: right"><a
										href="<%=path%>/goods?type=goodsManaQian">更多</a>&nbsp;</span>
								</TD>
							</TR>
							<TR align="left" height="260">
								<TD>
									<table cellspacing="8" cellpadding="1" align="center"
										border="0">
										<tr>
											<c:forEach items="${requestScope.goodsList}" var="goods"
												varStatus="sta">
												<c:if test="${sta.index%4==0}">
										</tr>
										<tr>
											</c:if>
											<td align="center">
												<a
													href="<%=path%>/goods?type=goodsDetailQian&id=${goods.id }">
													<img width="120" height="140"
														src="<%=path%>/${goods.fujian }"
														style="border: 1px solid #ccc; padding: 3px;" /> </a>
												<br>
												${goods.mingcheng } (￥:${goods.jiage }元)
											</td>
											</c:forEach>
										</tr>
									</table>
								</TD>
							</TR>
						</TABLE>
					</TD>
					<TD width="1">
						&nbsp;
					</TD>
				</TR>
			</TABLE>

			<jsp:include flush="true" page="/qiantai/inc/incFoot.jsp"></jsp:include>
		</div>
	</BODY>
</html>
