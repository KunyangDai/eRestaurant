<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script language="JavaScript" src="<%=path%>/js/public.js"
			type="text/javascript">
</script>
		<script type='text/javascript'
			src='<%=path%>/dwr/interface/loginService.js'>
</script>
		<script type='text/javascript' src='<%=path%>/dwr/engine.js'>
</script>
		<script type='text/javascript' src='<%=path%>/dwr/util.js'>
</script>
		<script type="text/javascript">
function admin() {
	var url = "<%=path%>/login.jsp";
	window.open(url, "_blank");
}

function liuyanAll() {
<c:if test="${sessionScope.user==null}">
                  alert("请先登录");
            </c:if>
            
            <c:if test="${sessionScope.user!=null}">
                var url="<%=path%>/liuyan?type=liuyanAll";
				var targetWinName="newWin";
				var features="width="+screen.width-200+" ,height="+screen.height-150+" ,toolbar=no, top=0, left=0, menubar=no, scrollbars=yes, resizable=no,location=no, status=no"
				var new_win=window.open(url,targetWinName,features);
            </c:if>
         } 
         
           function reg()
	        {
	                var url="<%=path%>/qiantai/userinfo/userReg.jsp";
	                var n="";
	                var w="480px";
	                var h="400px";
	                var s="resizable:no;help:no;status:no;scroll:yes";
				    openWin(url,n,w,h,s);
	        }
         
         function myXinxi()
         {
            <c:if test="${sessionScope.user==null}">
                  alert("请先登录");
            </c:if>
            
            <c:if test="${sessionScope.user!=null}">
                var url="<%=path%>/qiantai/userinfo/userXinxi.jsp";
                var n="";
                var w="480px";
                var h="400px";
                var s="resizable:no;help:no;status:no;scroll:yes";
			    openWin(url,n,w,h,s);
            </c:if>
         } 
         
         function getPwd()
         {
             
                var url="<%=path%>/qiantai/userinfo/getPwd.jsp";
                var n="";
                var w="480px";
                var h="200px";
                var s="resizable:no;help:no;status:no;scroll:yes";
			    openWin(url,n,w,h,s);
            
         } 
         
         function mycart()
         {
            <c:if test="${sessionScope.user==null}">
                  alert("请先登录");
            </c:if>
            
            <c:if test="${sessionScope.user!=null}">
                var url="<%=path%>/qiantai/cart/mycart.jsp";
                window.open(url,"_self");
            </c:if>
         } 
         
         function check()
			{                                                                                         
			     if(document.ThisForm.loginname.value=="")
				 {
				 	alert("请输入用户名");
					return false;
				 }
				 if(document.ThisForm.loginpw.value=="")
				 {
				 	alert("请输入密码");
					return false;
				 }
				 
				 loginService.login(document.ThisForm.loginname.value,document.ThisForm.loginpw.value,1,callback);
			}
		
			function callback(data)
			{
			    
			    if(data=="no")
			    {
			        alert("用户名或密码错误");
			    }
			    if(data=="yes")
			    {   alert("登陆成功");
			        window.location.reload();
			    }
			    
			}
         
         function myorder()
         {
            <c:if test="${sessionScope.user==null}">
                  alert("请先登录");
            </c:if>
            
            <c:if test="${sessionScope.user!=null}">
                var url="<%=path%>/buy?type=myorder";
                window.open(url,"_self");
            </c:if>
         } 
         
         function reg()
	        {
	                var url="<%=path%>/qiantai/userinfo/userReg.jsp";
	                var n="";
	                var w="480px";
	                var h="500px";
	                var s="resizable:no;help:no;status:no;scroll:yes";
				    openWin(url,n,w,h,s);
	        }
      </script>
		<LINK href="<%=path%>/css/css.css" type=text/css rel=stylesheet>
	</head>

	<body>

		<div id="nav">
			<ul>
				<li></li>
				<li></li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					<A href="<%=path%>/qiantai/default.jsp">首页</A>
				</li>
				<li>
					<A href="<%=path%>/gonggao?type=gonggaoManaQian">新闻公告</A>
				</li>
				<li>
					<A href="<%=path%>/goods?type=goodsManaQian">订餐</A>
				</li>

				<li>
					<a href="<%=path%>/qiantai/liuyan.jsp">留言板</A>
				</li>



				<li>
					<a href="<%=path%>/qiantai/lianxi.jsp">联系我们</A>
				</li>

				<li>
					<a href="#" onclick="admin()">后台管理</a>
				</li>

			</ul>
		</div>
		<div class="login_con">
			<c:if test="${sessionScope.user==null}">
				<form id="ThisForm" name="ThisForm" method="post"
					action="<%=path%>/userinfo!logon.action">
					<span>用户名： <input type="text" name="loginname"
							class="text_input" /> </span>
					<span>密码： <input type="password" name="loginpw"
							class="text_input" /> </span>
					<span> <input type="button" name="button" id="button"
							value="登录" class="denlu" onclick="check()" /> </span>
					<span><a href="#" class="zc" onclick="reg()">注册</a> </span>
					<span><a href="#" onclick="getPwd()" class="zc">找回密码</a> </span>

				</form>
			</c:if>
			<c:if test="${sessionScope.user!=null}">
				<span>欢迎你：${sessionScope.user.loginname } </span>

				<span><a href="#" onclick="mycart()" class="zc">购物车</a> </span>
				<span><a href="#" onclick="myorder()" class="zc">我的订单</a> </span>
				<span><a href="#" onclick="myXinxi()" class="zc">我的信息</a> </span>


				<span><a href="<%=path%>/user?type=userLogout" class="zc">注销</a>
				</span>
			</c:if>
		</div>
		<br />
	</body>
</html>
