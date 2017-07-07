<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>购物车取消</title>
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
	String productid=request.getParameter("productid");
	String bookname=request.getParameter("bookname");
	String price=request.getParameter("price");
	String num=request.getParameter("num");
	String pricesum=request.getParameter("pricesum");
	Connection con = DriverManager.getConnection(url, user, password);
	//创建statement对象 
	Statement stmt = con.createStatement();
	//调用sql语句并执行，结果返回resultset对象
	String s="select * from cart where userid="+userid;//可能是类型的问题

	ResultSet rs = stmt.executeQuery(s);
	//查看resultset对象中的记录
	while (rs.next()) {
		
			String sql = "delete from cart where productid="+productid;
			int result = stmt.executeUpdate(sql);
			if (result > 0) {
				out.println("<script>alert('删除成功');location='cart1.jsp'</script>");
			}
		}
	
	stmt.close();
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}

%>
</body>
</html>