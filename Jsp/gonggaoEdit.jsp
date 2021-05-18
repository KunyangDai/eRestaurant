<%@ page language="java" import="java.util.*,java.sql.*,com.cn.dao.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %> 
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
        
        <link rel="stylesheet" type="text/css" href="<%=path %>/css/base.css" />
        
        <script language="javascript">
        </script>
	</head>
	
	<%
				DB dbm = new DB();
				Connection conn = dbm.getCon();
				String id = request.getParameter("id");
				String sql = "select * from t_gonggao where id='" + id + "'";
				PreparedStatement stat = conn.prepareStatement(sql);
				ResultSet rs = stat.executeQuery();
				rs.next();
			%>

	<body background='<%=path %>/img/allbg.gif'>
			<form action="<%=path %>/gonggao?type=gonggaoUpdate" name="formAdd" method="post">
				     <table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
						<tr bgcolor="#EEF4EA">
					        <td colspan="3" background="<%=path %>/img/wbg.gif" class='title'><span>新闻公告</span></td>
					    </tr>
						<tr align='center' bgcolor="#FFFFFF" >
						    <td width="25%" bgcolor="#FFFFFF" align="right">
						          标题：
						    </td>
						    <td width="75%" bgcolor="#FFFFFF" align="left">
						        <input type="text" name="title" size="60" value="<%=rs.getString("title") %>"/>
						        <input type="hidden" name="id" size="60" value="<%=id %>"/>
						    </td>
						</tr>
						<tr align='center' bgcolor="#FFFFFF" >
						    <td width="25%" bgcolor="#FFFFFF" align="right">
						        内容：
						    </td>
						    <td width="75%" bgcolor="#FFFFFF" align="left">
						    <textarea rows="10" cols="30" name="content">
						     <%=rs.getString("content") %>
						    </textarea>
						      
						    </td>
						</tr>
						<tr align='center' bgcolor="#FFFFFF" >
						    <td colspan="2" align="center" bgcolor="#FFFFFF" align="left">
						       <input type="submit" value="提交"/>&nbsp; 
						       <input type="reset" value="重置"/>&nbsp;
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
