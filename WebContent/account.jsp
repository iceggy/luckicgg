<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>结算页面</title>
</head>
<body>
<% 
try {
	Class.forName("oracle.jdbc.driver.OracleDriver");//获取并装载jdbc驱动程序
} catch (ClassNotFoundException e) {
	out.print(e.toString());
}
	try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "system";
			String password = "azj1314";
			Connection con = DriverManager.getConnection(url, user, password);
			//创建statement对象 
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			//调用sql语句并执行，结果返回resultset对象
			String userid= (String)request.getSession().getAttribute("userid");
			String productid=request.getParameter("productid");
			String num=request.getParameter("num");
			
			String s="select isonsale,isputaway from books where id="+"'"+productid+"'";//可能是类型的问题
			
			ResultSet r = stmt.executeQuery(s);
			         if(r.next())
			     {
			
				int a=r.getInt("isonsale");
				int b=r.getInt("isputaway");
				int num1=Integer.parseInt(num);
			
				a=a-num1;
				b=b+num1;
				String sql = "update books set  isonsale="+a+","+"isputaway="+b;
				int result = stmt.executeUpdate(sql);
				 if (result > 0) {
                   	
                     out.println("购买成功");	
				 }
				 else{
					 out.println("<script>alert('处理失败，请重新提交订单！');location='cart1.jsp'</script>");
				 }
			}
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>
</body>
</html>