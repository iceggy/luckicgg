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
.h2{
position:absolute;
right:150px;
top:17px;
font-size:25px;
}
a{
text-decoration:none;
}
#header{
height:100px;
background-image:url(images/b.jpg)
}
#center{
background-image:url(images/center.jpg)
}
h1{
background-image:url(images/b.jpg)
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首页</title>
<style type="text/css">
body{
background-image:url(images/a.jpg)
}
</style>
<script>
function resize(obj)
{
	var ifrm=obj.contentWindow.document.body;
	ifrm.style.cssText="margin:0px,padding:0px;overflow:hidden";
	var div=document.createElement("img");
	div.src=obj.src;
	div.height=obj.height;
	div.width=obj.width;
	}
</script>
</head>
<body style="padding:0px;margin:0px">
<div id="header">
<h1>欢迎访问网上电子书城</h1>
<span class="h2">
<a href="regist.jsp">注册</a>
<a href="login.jsp">登录</a>
</span>

</div>
<div id="center">
<div id="left">
<p  style="color:red">请选择您想要的图书种类：</p>
<span>欲购买，请先登录或注册</span><br/><br/>
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
					<table>
							<td width="177"><b> 书名：<%=rs.getString("bookname") %>
							</b></br> 价格：￥<b><%=rs.getInt("price") %></b></td>
							<td width="177"><img src="images/<%= curCount+absRowNo-1%>.jpg" height="177" width="177"></td>
					</table>
				</form>

				<% 
				if(curCount+absRowNo-1>2)
				{
					out.println("<script>document.write('<br/>')</script>");
				}
			
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
	<a href="page.jsp?absRowNo=<%=prepage%> ">上一页</a>】
	<%
		}
		if (nextpage <= lastRowNo) {
	%>
	【
	<a href="page.jsp?absRowNo=<%=nextpage%>">下一页</a>】
	<%
		}
		
	%>
	【
	<a href="page.jsp?absRowNo=1">首页</a>】 【
	<a href="page.jsp?absRowNo=<%=((lastRowNo / pageNum) * pageNum + 1)%>">末页</a>】
</div>
</div>
</body>
</html>