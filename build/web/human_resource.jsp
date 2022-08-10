<!-- Head -->
<jsp:include page="includes/header.jsp" flush="true"></jsp:include>
<!-- Head -->
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>


<!-- Human Resource  -->
<button class="btn btn-block btn-primary font-weight-bold my-3 py-3">Adding Customers and Staffs</button>
    <div class="container-fluid">
        <div class="row px-xl-5">
                <a href="DashboardManager.jsp" class="btn btn-block btn-primary col-md-6 form-group">DASHBOARD</a>
                <a href="#add_user" class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 30px;">ADD STAFF</a>
                <a href="#allocate_staff" class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 30px;">ALLOCATE STAFF</a>
                <div class="col-md-6 form-group">
                    <p style="color:green">${requestScope.error}</p>
                </div>
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Date Added</th>
                            <th>Gender</th>
                            <th>Emails</th>
                            <th>Location</th>
                            <th>user_name</th>
                            <th>Role</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <% 
                    try{ 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                        Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);
                        st = conn.createStatement();
                        String sql = "SELECT * FROM users INNER JOIN roles ON users.role = roles.id";
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()){
                    %>
                    <tbody class="align-middle">
                        <tr>
                            <td class="align-middle"><%=rs.getInt("id") %></td>
                            <td class="align-middle"><%=rs.getString("user") %></td>
                            <td class="align-middle"><%=rs.getString("date_added") %></td>
                            <td class="align-middle"><%=rs.getString("gender") %></td>
                            <td class="align-middle"><%=rs.getString("email") %></td>
                            <td class="align-middle"><%=rs.getString("location") %></td>
                            <td class="align-middle"><%=rs.getString("user_name") %></td>
                            <td class="align-middle"><%=rs.getString("roles.role") %></td>
                            <td class="align-middle">
                                <form method="post" action="customerdb.jsp">
                                    <input type="hidden" id="action" name="dataEntry" value="delete_user" hidden>
                                    <input type="hidden" id="user_id" name="user_id" value="<%=rs.getInt("id") %>" hidden>
                                    <button class="btn btn-sm btn-danger"><i class="fa fa-times"></i></button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                    <%
                    }
                    String s = "SELECT COUNT(*) FROM users";
                    ResultSet r = st.executeQuery(s);
                    while(r.next()){                   
                        int count_row = r.getInt(1);
                        out.println(count_row);
                    }
                       
       
                    }catch(ClassNotFoundException | SQLException c){
                    out.println(c.getMessage());
                    }  
                    %>
                </table>
        </div>
    </div>
<!-- HR --> 

<!-- Staff Allocation  -->
    <button  id="allocate_staff" class="btn btn-block btn-primary font-weight-bold my-3 py-3">Allocating Staffs To Different Product Line</button>
       <div class="container-fluid">
           <div class="row px-xl-5">
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Date Added</th>
                            <th>Gender</th>
                            <th>Emails</th>
                            <th>Quantity</th>
                            <th>Remainders</th>
                            <th>Performance</th>
                            <th>Product-Line</th>
                            <th>Allocate</th>
                        </tr>
                    </thead>
                    <% 
                    try{ 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                        Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);
                        st = conn.createStatement();
                        String sql = "SELECT * FROM users INNER JOIN product_line ON users.product_line = product_line.id";
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()){
                            int total = rs.getInt("quantity");
                            int left = rs.getInt("quantity_left");
                            double percentage = 100-((double)left/total)*100;
                    %>
                    <tbody class="align-middle">
                        <tr>
                            <td class="align-middle"><%=rs.getInt("id") %></td>
                            <td class="align-middle"><%=rs.getString("user") %></td>
                            <td class="align-middle"><%=rs.getString("date_added") %></td>
                            <td class="align-middle"><%=rs.getString("gender") %></td>
                            <td class="align-middle"><%=rs.getString("email") %></td>
                            <td class="align-middle"><%=rs.getString("product_line.quantity") %></td>
                            <td class="align-middle"><%=rs.getString("product_line.quantity_left") %></td>
                            <td class="align-middle"><%=percentage%>%</td>
                            <td class="align-middle"><%=rs.getString("product_line.product_term") %></td>
                            <td class="align-middle">
                                <form method="post" action="customerdb.jsp">
                                    <input type="hidden" id="action" name="dataEntry" value="allocation_update" hidden>
                                    <input type="hidden" id="user_id" name="user_id" value="<%=rs.getInt("id") %>" hidden>
                                        <select class="custom-select" name="product_term" id="product_term">
                                            <option value="">Select Term</option>
                                            <option value="83">Long Term</option>
                                            <option value="84">Mid Term</option>
                                            <option value="85">Short Term</option>
                                        </select>
                                    <input type="submit" class="btn btn-sm btn-success" value="Allocate">
                                </form>
                            </td>
                    </tbody>
                    <%
                        }
       
                    }catch(ClassNotFoundException | SQLException c){
                    out.println(c.getMessage());
                    }  
                    %>
                </table>
            </div>
        </div>
<!-- Product_category --> 

<!-- Add Product_category -->

<div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-lg-8 table-responsive mb-5">
                <div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex" id="add_category">
                    <div class="content text-center ml-3" id="add_user">
                    <h1 class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 46px;">Register User</h1>
                    </div> 
                </div>
                <div class="form">
                    <form method="post" action="customerdb.jsp" >
                        <h2>Register Users</h2>
                        <div class="col-md-6 form-group">
                            <p style="color:red">${requestScope.error}</p>
                        </div>
                        <input type="hidden" id="action" name="dataEntry" value="register_staffs" hidden>
                        <div class="col-md-6 form-group">
                            <label>Full Name</label>
                            <input class="form-control" type="text" placeholder="Eluk Sam" name="name" id="name" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Gender</label>
                            <select class="custom-select" name="gender" id="gender">
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Location</label>
                            <input class="form-control" type="text" placeholder="Kampala" name="location" id="location" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Email</label>
                            <input class="form-control" type="email" placeholder="John@mm" name="email" id="email" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>User Name</label>
                            <input class="form-control" type="text" placeholder="John" name="username" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>User Role</label>
                            <select class="custom-select" name="role" id="gender">
                                <option value="1">Customer</option>
                                <option value="2">Staff</option>
                                <option value="3">Manager</option>
                            </select>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Password</label>
                            <input class="form-control" type="password" name="password" id="password" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Confirm Password</label>
                            <input class="form-control" type="password" name="confirm" id="confirm" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Product Term</label>
                            <select class="custom-select" name="role" id="gender">
                                <option value="">This only Applies for Staffs/Employees</option>
                                <option value="83">Long Term</option>
                                <option value="84">Mid Term</option>
                                <option value="85">Short Term</option>
                            </select>
                        </div>
                        <input type="submit" class="btn btn-block btn-primary col-md-6 form-group" name="submit" value="Register">
                    </form>
                </div>
            </div>
        </div>
    </div>


<!-- Add product_category -->

<!-- Footer -->
<jsp:include page="includes/footer.jsp" flush="true"></jsp:include>
<!-- Footer -->