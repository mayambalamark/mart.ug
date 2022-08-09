<%-- 
    Document   : logintrial
    Created on : Aug 6, 2022, 9:35:48 AM
    Author     : samuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>
        
        <%  
         String username = request.getParameter("username");
                    String password = request.getParameter("password");
        
         try{ 
           Class.forName("com.mysql.jdbc.Driver");
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
           
           String sql = "SELECT * FROM users WHERE user_name = ? and password = ?";
           PreparedStatement prps = conn.prepareStatement(sql);
           
           prps.setString(1, username);
           prps.setString(2, password);
           
           ResultSet rslt = prps.executeQuery();
           
           if(rslt.next()){
           response.sendRedirect(request.getContextPath() + "/DashboardCustomer.jsp");
            }else{
                request.setAttribute("error", "Sorry! Your login details do not much");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
       
       }catch(ClassNotFoundException | SQLException e){
                out.println(e);
       
        }
        
        
        
        %>
        
    </body>
</html>
