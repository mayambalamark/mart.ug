<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authenticating...</title>
    </head>
    <body>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>
        
        
        <%
            String auth = request.getParameter("auth");
            switch (auth) {
                case "mart_login" :{
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    
                    if(username != "" && password !=""){
                
            
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                            
                            String sql = "SELECT * FROM users WHERE user_name = ? and password = ?";
                            PreparedStatement prps = con.prepareStatement(sql);
           
                            prps.setString(1, username);
                            prps.setString(2, password);
           
                            ResultSet rslt = prps.executeQuery();
                    
                                if(rslt.next()){
                                    int user_role = rslt.getInt("role");
                                    String current_user = rslt.getString("user");
                                    if (user_role == 1) {
                                        request.setAttribute("success", "Login Successful!");
                                        session.setAttribute("user", current_user);
                                        request.getRequestDispatcher("DashboardCustomer.jsp").forward(request, response);
                                        response.sendRedirect(request.getContextPath() + "/DashboardCustomer.jsp");
                                        return;
                                    }else if(user_role == 2){
                                        request.setAttribute("success", "Login Successful!");
                                        session.setAttribute("user", current_user);
                                        request.getRequestDispatcher("DashboardStaff.jsp").forward(request, response);
                                        response.sendRedirect(request.getContextPath() + "/DashboardStaff.jsp");
                                        return;
                                    }else if(user_role == 3){
                                        request.setAttribute("success", "Login Successful!");
                                        session.setAttribute("user", current_user);
                                        request.getRequestDispatcher("DashboardManager.jsp").forward(request, response);
                                        response.sendRedirect(request.getContextPath() + "/DashboardManager.jsp");
                                        return;
                                    }else{
                                        request.setAttribute("error", "Sorry! You play no part on the platform");
                                        request.getRequestDispatcher("login.jsp").forward(request, response);
                                        return;
                                    }  
                                }else{
                                    request.setAttribute("error", "Sorry! Your login details do not much");
                                    request.getRequestDispatcher("login.jsp").forward(request, response);
                                    return;
                                }
                                }catch(ClassNotFoundException | SQLException e) {
                                e.printStackTrace();
                                }
                    }else{
            
                        request.setAttribute("error", "Login details missing!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        break;
                    }  
                }
                    
                    //logout session
                
                case "mart_logout": {
                    session.invalidate();
                    request.setAttribute("error", "You Logout!");
                    request.getRequestDispatcher("welcome.jsp").forward(request, response);
                    response.sendRedirect(request.getContextPath() + "/welcome.jsp");
                    break;     
                }
            }

        %>
    </body>
</html>
