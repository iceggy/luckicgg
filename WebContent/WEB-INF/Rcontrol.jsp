<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
		  <title>ע�ᴦ��ҳ��</title>
	  </head>
	  <body>
<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");//��ȡ��װ��jdbc��������
}catch(ClassNotFoundException ce){out.print(ce.getMessage());}
//���������ݿ�����ӡ�
//�˿ں�1521����ͨ���鿴oracle��װĿ¼��D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN��listener.ora�ļ���֪
try{
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
    String user="system";
    String password="azj1314";
    String userName=request.getParameter("uname");
    String pwd=request.getParameter("upwd");
    String pwd1=request.getParameter("pwd1");
    String Email=request.getParameter("Email");
    Connection conn=DriverManager.getConnection(url,user,password);
  //����statement���� 
    Statement   stmt = conn.createStatement();
    String str = "select * from bookuser ";
    ResultSet  rs = stmt.executeQuery(str);
//�鿴resultset�����еļ�¼
while(rs.next()){
	if(rs.getString("uname").equals(userName))
	{
		out.print("<script>alert('���û����ѱ�ע��')</script>");
	}
	else
		if(pwd.length()<8){
			out.print("<script>alert('���볤�Ȳ���С��8λ')");
		}
	else
	 if(rs.getString(pwd1).equals(pwd)==false)
	 {
	 	
		 out.print("<script>alert('��������������벻һ��')</script>");

	 }
else if(rs.getString(Email).matches("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*")==false){
	out.print("<script>alert('�����ʽ����ȷ')</script>");
}
else{
	response.sendRedirect("add_user.jsp");
}
	}
//���ݿ������Ϻ���Ҫһ�ιر�ResultSet��Statement��Connection����
//rs.close();
stmt.close();
conn.close();
}catch(Exception e){out.println(e.getMessage());}
%>
</body>
</html>