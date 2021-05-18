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
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />

		<link rel="stylesheet" type="text/css" href="<%=path%>/css/base.css" />

		<script type="text/javascript" src="<%=path%>/My97DatePicker/WdatePicker.js"></script>	
         <script type="text/javascript" src="<%=path %>/js/popup.js"></script>
        <script type='text/javascript' src='<%=path %>/dwr/interface/loginService.js'></script>
        <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
        <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
        
        <script language="javascript">
        var i=0;
           function goodsAll()
           {
               if(i==0)
               {
                   document.getElementById("indicator").style.display="block";
                   loginService.goodsAll(callback);
                   i=1;
               }
               
           }
           function callback(data)
           {
               document.getElementById("indicator").style.display="none";
               DWRUtil.addOptions("goods_id",data,"bianhao","mingcheng");
           }
           
            function check()
           {
               if(document.formAdd.goods_id.value==0)
               { 
                   alert("请选择商品");
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
		String sql = "select * from t_chu where id='" + id + "'";
		PreparedStatement stat = conn.prepareStatement(sql);
		ResultSet rs = stat.executeQuery();
		rs.next();
	%>

	<body onload="goodsAll()"
		background='<%=path%>/img/allbg.gif'>
		<form action="<%=path%>/chu?type=chuUpdate" name="formAdd"
			method="post">
			<table width="98%" align="center" border="0" cellpadding="4"
				cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">


				<tr bgcolor="#EEF4EA">
					<td colspan="3" background="<%=path%>/img/wbg.gif" class='title'>
						<span>出仓管理</span>
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF" >
					<td width="25%" bgcolor="#FFFFFF" align="right">
						商品：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<table border="0">
							           <tr> 
							               <td>  
							                  <select name="goods_id" id="goods_id" style="width: 150px;">
									              <option value="0">请选择商品</option>
									          </select>
							               </td>
							               <td>
							                  <img id="indicator" src="<%=path %>/img/loading.gif" style="display:none"/>
							               </td>
							           </tr>
							    </table>
						<input type="hidden" name="id" size="60" value="<%=id%>" />
					</td>
				</tr>
				
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						操作人：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="ren" size="60" value="<%=rs.getString("ren")%>" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF">
					<td width="25%" bgcolor="#FFFFFF" align="right">
						数量：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="count" size="60" value="<%=rs.getString("count")%>" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF" >
					<td width="25%" bgcolor="#FFFFFF" align="right">
						日期：
					</td>
					<td width="75%" bgcolor="#FFFFFF" align="left">
						<input type="text" name="date" size="60" class="Wdate" value="<%=rs.getString("date")%>" 
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss',readOnly:true})" />
					</td>
				</tr>
				<tr align='center' bgcolor="#FFFFFF" >
					<td colspan="2" align="center"  bgcolor="#FFFFFF" align="left">
						<input type="submit" value="提交" onclick="return check()"/>
						&nbsp;
						<input type="reset" value="重置" />
						&nbsp;
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
