<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<html>
<head>
<title>ע�ᴦ��ҳ��</title>
</head>
<body>
	<!--  -->
	<%
		try {
			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Class.forName("oracle.jdbc.driver.OracleDriver");//��ȡ��װ��jdbc��������
		} catch (ClassNotFoundException ce) {
			out.print(ce.getMessage());
		}
		//���������ݿ������

		//�˿ں�1521����ͨ���鿴oracle��װĿ¼��D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN��listener.ora�ļ���֪
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "system";
			String password = "azj1314";
			String userName = request.getParameter("userName");
			String pwd = request.getParameter("pwd");
			String pwd1 = request.getParameter("pwd1");
			String Email = request.getParameter("Email");
			Connection con = DriverManager.getConnection(url, user, password);
			//����statement���� 
			Statement stmt = con.createStatement();
			//����sql��䲢ִ�У��������resultset����
			ResultSet rs = stmt.executeQuery("select * from bookuser");
			//�鿴resultset�����еļ�¼
			int maxid = 0;
			while (rs.next()) {
				if (rs.getString("uname").equals(userName)) {
					out.print("<script>alert('���û����Ѵ��ڣ�������ע�ᣡ');location='regist.jsp'</script>");
				} else if (pwd.length() < 8) {
					out.print("<script>alert('���볤�Ȳ���С��8λ�����������룡');location='regist.jsp'</script>");
				} else if (pwd.equals(pwd1) == false) {

					out.print("<script>alert('�����������벻һ�£����������룡');location='regist.jsp'</script>");
				} else {
					String str = "select max(userid) userid from bookuser";
		
					ResultSet js = stmt.executeQuery(str);
					if (js.next()) {
						maxid = js.getInt("userid") + 1;
						
					}
					
					String sql = "insert into bookuser values ("+maxid+",'"+userName+"','"+pwd+"','"+Email+"')";
					int result = stmt.executeUpdate(sql);
					if (result > 0) {
						out.print("<script>alert('ע��ɹ�������');location='Fpage.jsp';</script>");			
						String s = String.valueOf(maxid);
						request.getSession().setAttribute("userid",s);
						
					} else {
						out.print("<script>alert('ע��ʧ��,������ע�ᣡ����');location='regist.jsp'</script>");
					}
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