<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看购物车</title>
<style type="text/css">
a{
text-decoration:none
}
</style>
</head>
<body>
<% 
try {
	//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	Class.forName("oracle.jdbc.driver.OracleDriver");//获取并装载jdbc驱动程序
} catch (ClassNotFoundException ce) {
	out.print(ce.getMessage());
}
//建立与数据库的连接

//端口号1521可以通过查看oracle安装目录下D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN的listener.ora文件得知
try {
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "system";
	String password = "azj1314";
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String userid= (String)request.getSession().getAttribute("userid");
	Connection con = DriverManager.getConnection(url, user, password);
	//创建statement对象 
	Statement stmt = con.createStatement();
	//调用sql语句并执行，结果返回resultset对象
	
	String s="select * from cart where userid="+userid;//可能是类型的问题
	ResultSet rs = stmt.executeQuery(s);
	//查看resultset对象中的记录
	while (rs.next()) {
		
		%>
	<form  method="post" id="1" action="">
		<table cellpadding="1" cellspacing="1" border="">
		<tr>
		<td width="177">图书编号</td>
		<td width="177">书名</td>
		<td width="177">单价</td>
		<td width="177">数量</td>
		<td width="177">总价</td>
		<td width="177">是否购买</td>
		</tr>
		<tr>
			
		<td width="177"><input type="text" name="productid" value="<%=rs.getString("productid")%>"hidden/><%=rs.getString("productid") %></td>
		<td width="177"><input type="text" name="bookname" value="<%=rs.getString("bookname")%>"hidden/><%=rs.getString("bookname") %></td>
		<td width="177"><input type="text" name="price" value="<%=rs.getString("price")%>"hidden/><%=rs.getInt("price") %></td>
		<td width="177"><input type="text" name="num" value="<%=rs.getString("num")%>"hidden/><%=rs.getInt("num") %></td>
		<td width="177"><input type="text" name="pricesum" value="<%=rs.getString("pricesum")%>"hidden/><%=rs.getInt("pricesum") %></td>
		<td width="177"><input type="submit" value=“取消购买”  onclick="javascript:this.form.action='delete.jsp';"/><input type="submit" value="确认购买" onclick="javascript:this.form.action='account.jsp';"/></td>
		
		</tr>
		</table>
		</form>
		<% 
	}
		stmt.close();
		con.close();
		} catch (Exception e) {
		out.println(e.getMessage());
		}
%>

</body>
</html>