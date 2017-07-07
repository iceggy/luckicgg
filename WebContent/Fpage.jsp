<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.math.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.imageio.ImageIO" %>
<%@page import="java.awt.* " %>
<html>
<head>
<style type="text/css">
#header{
height:100px;
background-image:url(images/b.jpg)
}
#center{
background-image:url(images/center.jpg)
}
a{
text-decoration:none;
}
body{
background-image:url(images/a.jpg);
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>购买页</title>
<script>
function resize(obj)
{
	var ifrm=obj.contentWindow.document.body;
	ifrm.style.cssText="margin:0px,padding:0px;overflow:hidden";
	var div=document.createElement("img");
	div.src=obj.src;
	obj.height=div.height;
	obj.width=div.width;
	}
</script>
</head>
<body style="padding:0px;margin:0px">
<div id="header">
<h1>欢迎访问网上电子书城</h1>
</div>
<div id="center">
<div id="left">
<p  style="color:red">请选择您想要的图书种类：</p>

<%

		int pageNum = 2;
		int nextpage = 0, prepage = 0;
		int absRowNo = 1;
		int lastRowNo = 0;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");//获取并装载jdbc驱动程序
		} catch (ClassNotFoundException e) {
			out.print(e.toString());
		}
		//建立与数据库的连接
		//端口号1521可以通过查看oracle安装目录下D:\oracle\product\10.2.0\db_1\NETWORK\ADMIN的listener.ora文件得知
	
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "system";
			String password = "azj1314";
		//h	String userid=request.getParameter("userid");
			
			Connection con = DriverManager.getConnection(url, user, password);
			//创建statement对象 
				try {
					Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			//调用sql语句并执行，结果返回resultset对象
			int curCount = 0;
//String photo_no= request.getParameter("photo_no");
	String sql="select * from books ";//可能是类型的问题
	ResultSet rs = stmt.executeQuery(sql);
			//查看resultset对象中的记录
			String absRowNoStr = request.getParameter("absRowNo");
			if (absRowNoStr != null) {
				absRowNo = Integer.parseInt(absRowNoStr);
			}
			rs.last();
			lastRowNo = rs.getRow();
			if (absRowNo > 1)
				rs.absolute(absRowNo - 1);
			else
				rs.beforeFirst();
			while (rs.next()) {
				//out.println(rs.getString("bookname"));
				curCount++;
				%>
				<form method="post" action="cartControl.jsp">
					<table>
						<tr>
							<td width="177"><b> 书名：<input type="text" name="bookname" value=" <%=rs.getString("bookname") %>" hidden/><%=rs.getString("bookname") %>
							</b></br> 价格：￥<b><input type="text" name="price" value="<%=rs.getInt("price")%>" hidden/><%=rs.getInt("price") %></b></td>
							<td width="177"><input type="text" name="id" value="<%= curCount+absRowNo-1%>"hidden><img src="images/<%= curCount+absRowNo-1%>.jpg" height="177" width="177"></td>
							<td width="177"><input type="submit" value="加入购物车"></td>
						</tr>
					</table>
				</form>

				<% 
				
			
				if (curCount >= pageNum)
					break;
			}
			nextpage = absRowNo + pageNum;
			prepage = absRowNo - pageNum;
			rs.close();
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	%>
	<hr>
	<%
		if (prepage >= 1) {
	%>
	【
	<a href="Fpage.jsp?absRowNo=<%=prepage%> ">上一页</a>】
	<%
		}
		if (nextpage <= lastRowNo) {
	%>
	【
	<a href="Fpage.jsp?absRowNo=<%=nextpage%>">下一页</a>】
	<%
		}
		
	%>
	【
	<a href="Fpage.jsp?absRowNo=1">首页</a>】 【
	<a href="Fpage.jsp?absRowNo=<%=((lastRowNo / pageNum) * pageNum + 1)%>">末页</a>】
</div>
</div>
</div>
</body>
</html>