<%@ page language="java" import="java.util.*,java.sql.*,com.cn.dao.*"
	pageEncoding="UTF-8"%>
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
									<SPAN class=TAG>留言</SPAN>
								</TD>
							</TR>
							<TR align="left">
								<TD height="5"></TD>
							</TR>
							<TR align="left" height="527">
								<TD align="center">
									<div class="m_title2">

									</div>
									<div class="m_content">
										<hr />
										<%
											DB dbm = new DB();
											Connection conn = dbm.getCon();
											String queryName = request.getParameter("queryName");
											String sql = "select * from t_message order by id desc";

											PreparedStatement pstmt = conn.prepareStatement(sql);
											ResultSet rs = pstmt.executeQuery();

											while (rs.next()) {
												String id = rs.getString("id");
										%>

										<p align="left" style="margin-left: 8px;">
											<span>留言人：<%=rs.getString("appuser")%></span>
											<br />
											<span>时间：<%=rs.getString("date")%></span>
											<%=rs.getString("msg")%>
											<br />
											<%
												String reply = rs.getString("reply");
													if (reply != null && reply.trim().length() > 0) {
														out.println("<br/><b>管理员回复： " + reply+"</b>");
													}
											%>
										</p>

										<hr />


										<%
											}
											if (rs != null)
												rs.close();
											if (pstmt != null)
												pstmt.close();
											if (conn != null)
												conn.close();
										%>

										<div class="message_con">
											<c:if test="${sessionScope.user!=null}">
												<form id="form2" name="form2" method="post"
													action="<%=path%>/msg?type=msgAdd">
													<h3>
														我要留言：
													</h3>
													<p>
														<textarea name="msg" id="msg" cols="45" rows="5"
															class="text_mes"></textarea>
													</p>
													<p class="btn_box">
														<input type="submit" name="button2" id="button2"
															value="提交" class="btn" />
													</p>
												</form>
											</c:if>
										</div>
									</div>

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
