<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<html>
<head>
<title>��¼����ҳ��</title>
</head>
<body>
	<%
		try {
			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Class.forName("oracle.jdbc.driver.OracleDriver");//��ȡ��װ��jdbc��������
		} catch (ClassNotFoundException e) {
			out.print(e.toString());
		}
		//���������ݿ������
		//�˿ں�1521����ͨ���鿴oracle��װĿ¼��D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN��listener.ora�ļ���֪
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "system";
			String password = "azj1314";
			String userName = request.getParameter("uName");
			String pwd = request.getParameter("pwd");
			String pwd1 = request.getParameter("pwd1");
			Connection con = DriverManager.getConnection(url, user, password);
			//����statement���� 
			Statement stmt = con.createStatement();
			//����sql��䲢ִ�У��������resultset����
			ResultSet rs = stmt.executeQuery("select * from bookuser");
			//�鿴resultset�����еļ�¼
			while (rs.next()) {
				
				if (rs.getString("uname").equals(userName) == false) {
					out.print("<script>alert('��������û������ڣ�����ע��');location='regist.jsp';</script>");
				} else if (pwd.length() < 8) {
					out.print("<script>alert('���볤�Ȳ���С��8λ�������µ�¼��');location='login.jsp';</script>");

				} else if (pwd.equals(pwd1) == false) {

					out.print("<script>alert('�����������벻һ�£������µ�¼��');location='login.jsp';</script>");

				} else if (rs.getString("uname").equals(userName) && rs.getString("upwd").equals(pwd)) {
					request.getSession().setAttribute("userid", rs.getString("userid"));
				
					
					response.sendRedirect("Fpage.jsp");
				}
				else{
					out.print("<script>alert('δ֪���������µ�¼��');location='login.jsp';</script>");
				}
			}
			//���ݿ������Ϻ���Ҫһ�ιر�ResultSet��Statement��Connection����
			//rs.close();
			stmt.close();
			con.close();
			
		} catch (Exception e) {
			out.println(e.getMessage());
		}
		
	%>
	
</body>
</html>