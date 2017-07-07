<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>购物车控制</title>
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
	String productid=request.getParameter("id");
	String bookname=request.getParameter("bookname");
	String price=request.getParameter("price");
	String userid= (String)request.getSession().getAttribute("userid");
	Connection con = DriverManager.getConnection(url, user, password);
	//创建statement对象 
	Statement stmt = con.createStatement();
	
	//调用sql语句并执行，结果返回resultset对象
	String s="select * from cart ";//可能是类型的问题
	ResultSet rs = stmt.executeQuery(s);
	int cartid=0;
	//查看resultset对象中的记录
	if (rs.next()) {
		if(rs.getString("userid").equals(userid))
		{
			
			 if(rs.getString("productid").equals(productid))//说明该书已经存在于购物车，只需要更新购物数目与总价即可
             {
		
		            String str="select * from cart where productid="+productid;
		          
              	 ResultSet a = stmt.executeQuery(str);
                                  while(a.next()) {
                                  	
                                   int count=a.getInt("num")+1;
                                   int sum;
                                   int x;
                                   x=Integer.parseInt(price);
                                   sum=count*x;
                                   String sql = "update cart set num="+count+",pricesum="+sum;
                                    int result = stmt.executeUpdate(sql);
                                     if (result > 0) {
                                  	
		                                     out.println("添加购物车成功");	
	                                          %>
                                             <a href="Fpage.jsp">返回继续购物</a>
                                             <a href="cart1.jsp">查看购物车</a>
                                           <%
                                                           	 } 
	                                    else{ out.println("添加购物车失败"); }
		  
                                                   }

                                              } 
                else{                                     //购物商品不存在，则插入除用户id外的所有信息
	                                         String l = "select max(cartid) cartid from cart";
	                                         ResultSet j = stmt.executeQuery(l);
	                                         if(j.next()) {cartid= j.getInt("cartid") + 1;}
	                                      
	                                         String f= "insert into cart(cartid,productid, userid,num,price,pricesum,bookname) values("+cartid+",'"+productid+"','"+userid+"',"+1+","+price+","+price+",'"+bookname+"')";
	                                         
	                                         int r= stmt.executeUpdate(f);
	                                        
	                                         if (r> 0) {
	                                      
		                                               out.println("添加购物车成功");	
		                                            
	                                                   
	                                                          }
	                                     else{ out.println("添加购物车失败");}
		                            }
		
		          }

		else{            
			                 String b= "insert into cart values("+1+",'"+productid+"','"+userid+"',"+1+","+price+","+price+",'"+bookname+"')";
			                 //违反唯一性约束；
			         
			                int v= stmt.executeUpdate(b);
			                
			                 if (v>0) {
			                	 
				            out.println("添加购物车成功");	
			              
		                                               }
		                    else{out.println("添加购物车失败"); }
	}
	}
	else{
		String d="insert into cart values("+cartid+",'"+productid+"','"+userid+"',"+1+","+price+","+price+",'"+bookname+"')";
		 int g= stmt.executeUpdate(d);
		 if (g>0) {
        	 
	            out.println("添加购物车成功");	
           
                                        }
             else{out.println("添加购物车失败"); }
	}
	stmt.close();con.close();
		}catch(Exception e){out.println(e.getMessage());}
	%> 
	 <br/>
     <a href="Fpage.jsp">返回继续购物</a><br/>
	 <a href="cart1.jsp">查看购物车</a>
	                                                                       
</body>
</html>