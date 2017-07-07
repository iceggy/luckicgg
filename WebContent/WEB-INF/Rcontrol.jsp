<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
		  <title>注册处理页面</title>
	  </head>
	  <body>
<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");//获取并装载jdbc驱动程序
}catch(ClassNotFoundException ce){out.print(ce.getMessage());}
//建立与数据库的连接·
//端口号1521可以通过查看oracle安装目录下D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN的listener.ora文件得知
try{
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
    String user="system";
    String password="azj1314";
    String userName=request.getParameter("uname");
    String pwd=request.getParameter("upwd");
    String pwd1=request.getParameter("pwd1");
    String Email=request.getParameter("Email");
    Connection conn=DriverManager.getConnection(url,user,password);
  //创建statement对象 
    Statement   stmt = conn.createStatement();
    String str = "select * from bookuser ";
    ResultSet  rs = stmt.executeQuery(str);
//查看resultset对象中的记录
while(rs.next()){
	if(rs.getString("uname").equals(userName))
	{
		out.print("<script>alert('该用户名已被注册')</script>");
	}
	else
		if(pwd.length()<8){
			out.print("<script>alert('密码长度不得小于8位')");
		}
	else
	 if(rs.getString(pwd1).equals(pwd)==false)
	 {
	 	
		 out.print("<script>alert('您两次输入的密码不一致')</script>");

	 }
else if(rs.getString(Email).matches("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*")==false){
	out.print("<script>alert('邮箱格式不正确')</script>");
}
else{
	response.sendRedirect("add_user.jsp");
}
	}
//数据库操作完毕后，需要一次关闭ResultSet、Statement、Connection对象
//rs.close();
stmt.close();
conn.close();
}catch(Exception e){out.println(e.getMessage());}
%>
</body>
</html>