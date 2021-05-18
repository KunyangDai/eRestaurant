<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>网站后台</title>
	    
		<script type='text/javascript' src='<%=path %>/dwr/interface/loginService.js'></script>
        <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
        <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
        
        <script type='text/javascript' src='<%=path %>/log/js/jquery.js'></script>
        
        	<link href="<%=path%>/css/login.css" rel="stylesheet"
			type="text/css" media="all" />

		
		<script type="text/javascript">
$(document).ready(function(c) {
	$('.alert-close').on('click', function(c) {
		$('.message').fadeOut('slow', function(c) {
			$('.message').remove();
		});
	});
});
</script>
        
		<script language="javascript">
		function check()
		{                                                                                         
		     if(document.ThisForm.userName.value=="")
			 {
			 	alert("请输入账号");
				document.ThisForm.userName.focus();
				return false;
			 }
			 if(document.ThisForm.userPw.value=="")
			 {
			 	alert("请输入密码");
				document.ThisForm.userPw.focus();
				return false;
			 }
			
			 loginService.login(document.ThisForm.userName.value,document.ThisForm.userPw.value,0,callback);
			 
		}
		
		function callback(data)
		{
		    
		    if(data=="no")
		    {
		        alert("账号或密码错误");
		    }
		    if(data=="yes")
		    {
		        alert("通过验证,系统登录成功");
		        window.location.href="<%=path %>/loginSuccess.jsp";
		    }
		    
		}
	    </script>
</head>
<body>
<div class="message warning">
			<div align="right">
				<div class="login-head">
					<h1>
						网上商城后台管理系统
					</h1>
					<div class="alert-close"></div>
				</div>

				<form name="ThisForm" action="loginuser!logon.action" method="post">
					 
					<ul>
						<li>
							<input type="text" class="text" id="userName" name="userName"
								 />
							<a href="#" class=" icon user"></a>
						</li>
						<li>
							<input type="password" value="" id="userPw" name="userPw" />
							<a href="#" class="icon lock"></a>
						</li>
					</ul>

					<div class="submit">
						<input type="button" onclick="check()" value="登录" />

						<div class="clear">
						</div>
					</div>
				</form>
			</div>
		</div>
		<br/>

		<!--- footer --->
		<div class="footer"><br/><br/>
			<p>
				
			</p>
		</div>
</body>
</html>