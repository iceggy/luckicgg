<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
	<head>
	<style type="text/css">
	a{
	text-decoration:none;
	float:right;
	}
	</style>
		<title>用户注册</title>
	</head>
	<body>
	<a href="page.jsp">返回首页</a>
	<form name="form1" method="post" action="Rcontrol.jsp">
		<table>
			<tr>	
				<td>用户名：</td>
				<td> <input type="text" name="userName"> </td>
			</tr>
	        <tr>	
		 		<td>输入密码：</td>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>	
				<td>再次输入密码：</td>
				<td><input type="password" name="pwd1"></td>
			</tr>
			<tr>
			<td>Email：</td>
			<td><input type="text" name="Email"></td>
			</tr>
			<tr>	
				<td></td>
				<td><input type="submit" value="注册" style="background:lime"></td>
			</tr>
		</table>
	</form>
	</body>
</html>