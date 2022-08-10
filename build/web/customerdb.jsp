<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registering...</title>
    </head>
    <body>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.*"%>
        <%@page import="java.io.*"%>
        
        
        <%
            String dataEntry = request.getParameter("dataEntry");
            
            switch(dataEntry) {
                case "register_customer": {
                    String name = request.getParameter("name");
                    String gender = request.getParameter("gender");
                    String location = request.getParameter("location");
                    String email = request.getParameter("email");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String confirm = request.getParameter("confirm");
          
                    //step 1 load the jdbc driver
            
                    if(password.equals(confirm)){
                 
                        Statement st = null;
                        PreparedStatement ps = null;
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                
                
                            String mysql = "SELECT * FROM users WHERE email = ? and user_name = ?";
                            ps = con.prepareStatement(mysql);
                
                            ps.setString(1, email);
                            ps.setString(2, username);
                            ResultSet rs = ps.executeQuery();
                
                            if(rs.next()){
                                request.setAttribute("error", "User already exist! Try other emails..");
                                request.getRequestDispatcher("custregister.jsp").forward(request, response);
                                return;
                            }else {
                
                                st = con.createStatement();
                                st.executeUpdate("insert into users set user='"+name+"',email='"+email+"',user_name='"+username+"',location='"+location+"',gender='"+gender+"',password='"+password+"'");
                                request.setAttribute("error", "Welcome to Mart!");
                                request.getRequestDispatcher("/login.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/login.jsp");
                                return;
                            }
                
                
                            }catch(ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            }
                 
                        }else {
            
                            request.setAttribute("error", "passwords do not match!");
                            request.getRequestDispatcher("custregister.jsp").forward(request, response);
                            return;
                        }
                    
                }
                
                
                case "register_productline" : {
                    String productTerm = request.getParameter("productTerm");
                    int quantity = (int) Integer.parseInt(request.getParameter("quantity"));
                    String dateAdded = request.getParameter("dateAdded");
                    String description = request.getParameter("description");
                    
                    if(productTerm == ""){
                        request.setAttribute("error", "Define product term please!");
                        request.getRequestDispatcher("productLine.jsp").forward(request, response);
                        return;
                    
                    }else{
                        Statement st = null;
                        try{ 
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                            st = con.createStatement();
                    
                                int midterm = 2*quantity;
                                int shortterm = 5*midterm;
                    
                            // for long term
                            st.executeUpdate("update product_line set product_term='"+productTerm+"',quantity='"+quantity+"', "
                            +" date_added='"+dateAdded+"', description='"+description+"' WHERE id='83'");
                    
                            //for midterm
                            st.executeUpdate("update product_line set product_term='mid term',quantity='"+midterm+"', "
                            +" date_added='"+dateAdded+"', description='"+description+"' WHERE id='84'");
                            
                            //for shortterm
                            st.executeUpdate("update product_line set product_term='short term',quantity='"+shortterm+"', "
                            +" date_added='"+dateAdded+"', description='"+description+"' WHERE id='85'");
                    
                            request.setAttribute("success", "Product term Successfully added!");
                            request.getRequestDispatcher("/productLine.jsp").forward(request, response);
                            response.sendRedirect(request.getContextPath() + "/productLine.jsp");
                            return;
                            
                        }catch(ClassNotFoundException | SQLException c) {
                            out.println(c.getMessage());
                        }
                    }
                }
                
                case "register_category" : {
                    String category = request.getParameter("category");
                    String description = request.getParameter("description"); 
                    
                    Statement st = null;
                        try{ 
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                            st = con.createStatement();
                            st.executeUpdate("insert into categories set category='"+category+"', description='"+description+"'");
                            
                            request.setAttribute("success", "Category Successfully Added!");
                            request.getRequestDispatcher("/add_category.jsp").forward(request, response);
                            response.sendRedirect(request.getContextPath() + "/add_cateory.jsp");
                            return;
                    
                        }catch(ClassNotFoundException | SQLException c) {
                            out.println(c.getMessage());
                        }
                }
                
                case "register_product" : {
                    String product = request.getParameter("product");
                    String product_image = request.getParameter("product_image"); 
                    String quantity = request.getParameter("quantity");
                    String price = request.getParameter("price"); 
                    String description = request.getParameter("description"); 
                    String product_term = request.getParameter("product_term");
                    int category = (int) Integer.parseInt(request.getParameter("category"));
                    
                    Connection con=null;
                    ResultSet rs=null;
                    Statement st=null;
                    
                    
                        try{ 
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                    
                            st = con.createStatement();
                            st.executeUpdate("insert into products set products='"+product+"',category='"+category+"',quantity='"+quantity+"',quantity_left='"+quantity+"',price='"+price+"',"
                            + " image='"+product_image+"', description='"+description+"', product_term='"+product_term+"'");
                            
                                request.setAttribute("error", "Product Successfully Added!");
                                request.getRequestDispatcher("/add_product.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/add_product.jsp");
                                return;
                    
                        }catch(ClassNotFoundException | SQLException c) {
                            out.println(c.getMessage());
                        }
                }
                
                case "register_staffs": {
                    String name = request.getParameter("name");
                    String gender = request.getParameter("gender");
                    String location = request.getParameter("location");
                    String email = request.getParameter("email");
                    String username = request.getParameter("username");
                    String role = request.getParameter("role");
                    String password = request.getParameter("password");
                    String confirm = request.getParameter("confirm");
          
                    //step 1 load the jdbc driver
            
                    if(password.equals(confirm)){
                 
                        Statement st = null;
                        PreparedStatement ps = null;
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                
                
                            String mysql = "SELECT * FROM users WHERE email = ? and user_name = ?";
                            ps = con.prepareStatement(mysql);
                
                            ps.setString(1, email);
                            ps.setString(2, username);
                            ResultSet rs = ps.executeQuery();
                
                            if(rs.next()){
                                request.setAttribute("error", "User already exist! Try other emails..");
                                request.getRequestDispatcher("human_resource.jsp").forward(request, response);
                                return;
                            }else {
                
                                st = con.createStatement();
                                st.executeUpdate("insert into users set user='"+name+"',email='"+email+"',user_name='"+username+"',location='"+location+"',role='"+role+"',gender='"+gender+"',password='"+password+"'");
                                request.setAttribute("error", "User successfully registered!");
                                request.getRequestDispatcher("human_resource.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/human_resource.jsp");
                                return;
                            }
                
                
                            }catch(ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            }
                 
                        }else {
            
                            request.setAttribute("error", "passwords do not match!");
                            request.getRequestDispatcher("human_resource.jsp").forward(request, response);
                            return;
                        }
                    
                }
                
                case "allocation_update" : {
                    String product_term = request.getParameter("product_term");
                    String user_id = request.getParameter("user_id");
                    
                    if(product_term.equals("")) {
                        request.setAttribute("error", "Product Term Not Set!");
                        request.getRequestDispatcher("human_resource.jsp").forward(request, response);
                        return;
                    
                    }else {
                    
                        Statement st = null;
                            try{ 
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                                st = con.createStatement();
                                st.executeUpdate("UPDATE users SET product_line='"+product_term+"' WHERE id='"+user_id+"'");
                            
                                request.setAttribute("error", "Update Successfully Added!");
                                request.getRequestDispatcher("/human_resource.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/human_resource.jsp");
                                return;
                    
                            }catch(ClassNotFoundException | SQLException c) {
                                out.println(c.getMessage());
                        }
                    }
                }
                
                case "delete_user" : {
                    String user_id = request.getParameter("user_id");
                    
                        Statement st = null;
                            try{ 
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                                st = con.createStatement();
                                st.executeUpdate("DELETE FROM users WHERE id='"+user_id+"'");
                            
                                request.setAttribute("error", "User Deleted Successfully!");
                                request.getRequestDispatcher("/human_resource.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/human_resource.jsp");
                                return;
                    
                            }catch(ClassNotFoundException | SQLException c) {
                                out.println(c.getMessage());
                            }
                        
                    
                }
                
                case "delete_product" : {
                    String user_id = request.getParameter("user_id");
                    
                        Statement st = null;
                            try{ 
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                    
                                st = con.createStatement();
                                st.executeUpdate("DELETE FROM products WHERE id='"+user_id+"'");
                            
                                request.setAttribute("error", "Product Deleted Successfully!");
                                request.getRequestDispatcher("/add_product.jsp").forward(request, response);
                                response.sendRedirect(request.getContextPath() + "/add_product.jsp");
                                return;
                    
                            }catch(ClassNotFoundException | SQLException c) {
                                out.println(c.getMessage());
                            }
                        
                    
                }
                        
            }
                 
               
        %>
               
    </body>
</html>
