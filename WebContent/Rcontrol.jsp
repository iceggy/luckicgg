<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<html>
<head>
<title>注册处理页面</title>
</head>
<body>
	<!--  -->
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
			String userName = request.getParameter("userName");
			String pwd = request.getParameter("pwd");
			String pwd1 = request.getParameter("pwd1");
			String Email = request.getParameter("Email");
			Connection con = DriverManager.getConnection(url, user, password);
			//创建statement对象 
			Statement stmt = con.createStatement();
			//调用sql语句并执行，结果返回resultset对象
			ResultSet rs = stmt.executeQuery("select * from bookuser");
			//查看resultset对象中的记录
			int maxid = 0;
			while (rs.next()) {
				if (rs.getString("uname").equals(userName)) {
					out.print("<script>alert('该用户名已存在，请重新注册！');location='regist.jsp'</script>");
				} else if (pwd.length() < 8) {
					out.print("<script>alert('密码长度不得小于8位，请重新输入！');location='regist.jsp'</script>");
				} else if (pwd.equals(pwd1) == false) {

					out.print("<script>alert('两次密码输入不一致，请重新输入！');location='regist.jsp'</script>");
				} else {
					String str = "select max(userid) userid from bookuser";
		
					ResultSet js = stmt.executeQuery(str);
					if (js.next()) {
						maxid = js.getInt("userid") + 1;
						
					}
					
					String sql = "insert into bookuser values ("+maxid+",'"+userName+"','"+pwd+"','"+Email+"')";
					int result = stmt.executeUpdate(sql);
					if (result > 0) {
						out.print("<script>alert('注册成功！！！');location='Fpage.jsp';</script>");			
						String s = String.valueOf(maxid);
						request.getSession().setAttribute("userid",s);
						
					} else {
						out.print("<script>alert('注册失败,请重新注册！！！');location='regist.jsp'</script>");
					}
				}
			}
			//数据库操作完毕后，需要一次关闭ResultSet、Statement、Connection对象
			//rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	%>
	
</body>
</html>