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
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<LINK href="<%=path%>/css/css.css" type=text/css rel=stylesheet>
	</head>

	<BODY text=#000000 leftMargin=0 topMargin=0>
		<div class="wrap">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0
				background="<%=path%>/img/reservation01.jpg">
				<TR height="90">
					<TD align="center">
						<jsp:include flush="true" page="/qiantai/inc/incTop1.jsp"></jsp:include>
					</TD>
				</TR>
			</TABLE>


			<jsp:include flush="true" page="/qiantai/inc/incTop2.jsp"></jsp:include>

			<TABLE class=MainTable style="MARGIN-TOP: 0px" cellSpacing=0
				cellPadding=0 width="100%" align=center border=0>
				<TR>

					<TD class=Side vAlign=top align=right width="75%">
						<TABLE class=dragTable cellSpacing=0 cellPadding=0 width="100%"
							border=0>
							<TR>
								<TD class=head>
									<SPAN class=TAG>联系我们</SPAN>
								</TD>
							</TR>
							<TR align="left">
								<TD height="5"></TD>
							</TR>
							<TR align="left" height="527">
								<TD align="center">
									<P align=left style="margin-left: 8px;">
										客服电话：XXXX
									</P>
									<P align=left style="margin-left: 8px;">
										传 真：010-XXXXX
									</P>
									<P align=left style="margin-left: 8px;">
										联系地 址：XXXX
									</P>
									<P align=left style="margin-left: 8px;">
										邮 编：XXXX
									</P>
								</TD>
							</TR>
							<TR align="left">
								<TD height="5"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<jsp:include flush="true" page="/qiantai/inc/incFoot.jsp"></jsp:include>
		</div>
	</BODY>
</html>
