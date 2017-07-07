<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
a{
text-decoration:none;
float:right;
}
</style>
<title>登录界面</title>
</head>
<body>
<a href="page.jsp">返回首页</a>
<form name="form1" method="post" action="control.jsp">
		<table>
		<tr>
		<td>请输入您的登录信息</td>
		</tr>
			<tr>	
				<td>用户名：</td>
				<td> <input type="text" name="uName"> </td>
			</tr>
	        <tr>	
		 		<td>输入登录密码：</td>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>	
				<td>再次输入密码：</td>
				<td><input type="password" name="pwd1"></td>
			</tr>
			<tr>	
				<td></td>																																												
				<td><input type="submit" value="提交" style="background:red"></td>
			</tr>
		</table>
	</form>
</body>
</html>