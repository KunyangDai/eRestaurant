<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">     
   
    <LINK href="<%=path %>/css/css.css" type=text/css rel=stylesheet>
    
    <script type='text/javascript' src='<%=path %>/dwr/interface/cartService.js'></script>
	<script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
    
    <script type="text/javascript">
            function delGoodsFromCart(goodsId)
	        {
	            document.getElementById("indicator1").style.display="block";
	            cartService.delGoodsFromCart(goodsId,callback111);
	        }
           
            function clearCart()
	        {
	            document.getElementById("indicator1").style.display="block";
	            cartService.clearCart(callback111);
	        }
           
            function modiNum(goodsId,quantity)
	        {
	            var r1= /^[0-9]*[1-9][0-9]*$/　　//正整数 
	            var val=r1.test(quantity); //str为你要判断的字符 执行返回结果 true 或 false
	            if(val==false)
	            {
	                alert("数量必须是数字,请重新输入");
	            }
	            else
	            {
	                document.getElementById("indicator1").style.display="block";
	                cartService.modiNum(goodsId,quantity,callback111);
	            }
	        }
	        
	        function callback111(data)
	        {
	            document.getElementById("indicator1").style.display="none";
	            if(data=="no")
			    {
			        alert("库存不足");
			    }
			    if(data=="yes")
			    {
			        document.location.reload(true);
			    }
	        }
    </script>
  </head>
  
  <BODY text=#000000  leftMargin=0 topMargin=0>
	<div class="wrap"> 
		<TABLE  cellSpacing=0 cellPadding=0 width="100%" align=center border=0  background="<%=path %>/img/reservation01.jpg">
				<TR height="90">
					<TD align="center">
					    <jsp:include flush="true" page="/qiantai/inc/incTop1.jsp"></jsp:include> 
					</TD>
				</TR>
		</TABLE>
		
		
	<jsp:include flush="true" page="/qiantai/inc/incTop2.jsp"></jsp:include>

        <TABLE class=MainTable style="MARGIN-TOP: 0px" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
				<TR>
				    <TD class=Side vAlign=top align=right width="25%">
						<jsp:include flush="true" page="/qiantai/inc/incLeft.jsp"></jsp:include>
					</TD>
					<td width="1">&nbsp;</td>
					<TD class=Side vAlign=top align=right width="75%">
					    <TABLE class=dragTable cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TR>
									<TD class=head>
										<span style="float:left">购物车</span>
									</TD>
								</TR>
								<TR align="left">
									<TD height="5"></TD>
								</TR>
								<TR align="left" height="500">
									<TD>
									    <table width="98%" border="0" cellpadding="2" cellspacing="1" align="center" style="margin-top:8px">
											<tr align="center" bgcolor="#FAFAF1" height="22">
												  <td width="20">商品名称</td>
								                  <td width="10">购买价格</td>
								                  <td width="20">购买数量<img id="indicator1" src="<%=path %>/img/loading.gif" style="display:none"/></td>
								                  <td width="20">总金额</td>
								                  <td width="20">操作</td>
									        </tr>	
											<c:forEach items="${sessionScope.cart.items}" var="item">
											<tr align='center' bgcolor="#FFFFFF" height="22">
												<td bgcolor="#FFFFFF" align="center">${item.value.goods.mingcheng}</td>
												<td bgcolor="#FFFFFF" align="center">￥:${item.value.goods.jiage}</td>
												<td bgcolor="#FFFFFF" align="center"><input type="text" onChange="modiNum(${item.value.goods.id},this.value)" value="${item.value.goods_quantity}" size="4"/></td>
												<td bgcolor="#FFFFFF" align="center">${item.value.goods.jiage * item.value.goods_quantity}</td>
												<td bgcolor="#FFFFFF" align="center"><img src="<%=path %>/img/delete_01.gif" border="0" onClick="delGoodsFromCart(${item.value.goods.id})"/></td>
											</tr>
											</c:forEach>
											<tr>
								                 <td colspan="5" class="Order_Total" align="right">
								                    <br>
												     	<font color="red" ><b>共计：${sessionScope.cart.totalPrice}</b></font>
												    &nbsp;&nbsp;
												    
												 </td>
								              </tr>	
										</table>
										<table align="center">
						                   <tr>
						                       
						                       <td><a href="#" onclick="clearCart()"><img border="0" width="100px" height="30px" src="<%=path %>/img/qingkong.jpg"/></a></td>
						                       <td><a href="<%=path %>/qiantai/default.jsp"><img border="0"  width="100px" height="30px" src="<%=path %>/img/jixu.jpg"/></a></td>
						                       <td><a href="<%=path %>/qiantai/order/orderQueren.jsp"><img border="0" width="100px" height="30px" src="<%=path %>/img/next.jpg"/></a></td>
						                   </tr>
						               </table>
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
