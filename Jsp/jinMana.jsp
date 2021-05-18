<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %> 
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
		
		<script language="JavaScript" src="<%=path %>/js/public.js" type="text/javascript"></script>
		
        <script language="javascript">
           function jinAdd()
           {
              var url="<%=path %>/admin/jin/jinAdd.jsp";
              window.location.href=url;
           }
           
           function jinDetail(id)
           {
                 var url="<%=path %>/jin?type=jinDetail&id="+id;
                 var n="";
                 var w="480px";
                 var h="500px";
                 var s="resizable:no;help:no;status:no;scroll:yes";
				 openWin(url,n,w,h,s);
           }
       </script>
	</head>

	<body   background='<%=path %>/img/allbg.gif'>
			<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
				<tr bgcolor="#E7E7E7">
					<td height="14" colspan="44" background="<%=path %>/img/wbg.gif">&nbsp;进仓管理&nbsp;</td>
				</tr>
				<tr align="center" bgcolor="#FAFAF1">
					<td width="10%">商品</td>
					
					<td width="10%">操作人</td>
					<td width="10%">数量</td>
					<td width="10%">出库日期</td>
					<td width="10%">操作</td>
		        </tr>	
				<c:forEach items="${requestScope.jinList}" var="jin">
				<tr align='center' bgcolor="#FFFFFF" >
					<td bgcolor="#FFFFFF" align="center">
						 ${jin.mingcheng}
					</td>
					
					<td bgcolor="#FFFFFF" align="center">
					    ${jin.ren}
					</td>
					<td bgcolor="#FFFFFF" align="center">
					    ${jin.count}
					</td>
					<td bgcolor="#FFFFFF" align="center">
					    ${jin.date}
					</td>
					<td bgcolor="#FFFFFF" align="center">
						<a class="pn-loperator" href="<%=path %>/jin?type=jinDel&id=${jin.id}">删除</a>|
						<a class="pn-loperator" href="<%=path %>/admin/jin/jinEdit.jsp?id=${jin.id}">修改</a>
					</td>
				</tr>
				</c:forEach>
			</table>
			
			<table width='98%'  border='0'style="margin-top:8px;margin-left: 8px;">
			  <tr>
			    <td>
			      <input type="button" value="添加进仓信息" style="width: 100px;" onclick="jinAdd()" />
			    </td>
			  </tr>
		    </table>
	</body>
</html>
