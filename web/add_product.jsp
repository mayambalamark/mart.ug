
 <!-- Head -->
<jsp:include page="includes/header.jsp" flush="true"></jsp:include>
<!-- Head -->
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>

<!-- Product_category  -->
<button class="btn btn-block btn-primary font-weight-bold my-3 py-3">Adding Products/Items For Sale </button>
    <div class="container-fluid">
        <div class="row px-xl-5">
                <a href="DashboardManager.jsp" class="btn btn-block btn-primary col-md-6 form-group">DASHBOARD</a>
                <a href="#add_product" class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 30px;">ADD</a>
                <div class="col-md-6 form-group">
                    <p style="color:green">${requestScope.error}</p>
                </div>
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Quantity Left</th>
                            <th>Date Added</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Category</th>
                            <th>Product Term</th>
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
                        String sql = "SELECT * FROM products INNER JOIN categories ON products.category = categories.id INNER JOIN product_line ON products.product_term = product_line.id";
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()){
                    %>
                    <tbody class="align-middle">
                        <tr>
                            <td class="align-middle"><%=rs.getInt("id") %></td>
                            <td class="align-middle"><%=rs.getString("image") %></td>
                            <td class="align-middle"><%=rs.getString("products") %></td>
                            <td class="align-middle"><%=rs.getString("quantity") %></td>
                            <td class="align-middle"><%=rs.getString("quantity_left") %></td>
                            <td class="align-middle"><%=rs.getString("date_created") %></td>
                            <td class="align-middle"><%=rs.getString("description") %></td>
                            <td class="align-middle"><%=rs.getString("price") %></td>
                            <td class="align-middle"><%=rs.getString("categories.category") %></td>
                            <td class="align-middle"><%=rs.getString("product_line.product_term") %></td>
                            <td class="align-middle">
                                <form method="post" action="customerdb.jsp">
                                    <input type="hidden" id="action" name="dataEntry" value="delete_product" hidden>
                                    <input type="hidden" id="user_id" name="user_id" value="<%=rs.getInt("id") %>" hidden>
                                    <button class="btn btn-sm btn-danger"><i class="fa fa-times"></i></button>
                                </form>
                            </td>
                        </tr>
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
<div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex" id="add_product">
    <div class="content text-center ml-3" id="add_product">
        <h1 class="h1 text-primary bg-dark px-2" style="color: yellow; font-size: 46px;">Add Product</h1>
        <div class="form">
            <form class="text-center"post" action="customerdb.jsp" enctype='multipart/form-data' >
                <div class="col-md-6 form-group">
                    <p style="color:red">${requestScope.error}</p>
                </div>
                <input type="hidden" id="action" name="dataEntry" value="register_product" hidden>
                <div class="col-md-6 form-group">
                    <label>Product</label>
                    <input class="form-control text-center" type="text" placeholder="German dog" name="product" id="product" required>
                </div>
                <div class="col-md-6 form-group ">
                    <label>Attach Product Image</label> 
                    <input type="file" name="product_image" id="product_image" class="form-control text-center" required/>
                </div>
                <div class="col-md-6 form-group ">
                    <label>Quantity</label>
                    <input class="form-control text-center" type="number" placeholder="0" name="quantity" id="quantity" required>
                </div>
                <div class="col-md-6 form-group ">
                    <label>Price</label>
                    <input class="form-control text-center" type="number" placeholder="$1.000" name="price" id="price" required>
                </div>
                <div class="col-md-6 form-group ">
                    <p><label for="martreview">Description:</label></p>
                    <textarea id="martreview" name="description" rows="4" cols="50" required>unique attires.</textarea>
                </div>
                <div class="col-md-6 form-group ">
                    <p><label for="martreview">Product Line:</label></p>
                    <select class="custom-select" name="product_term" id="product_term">
                        <option value="">Select Term</option>
                        <option value="83">Long Term</option>
                        <option value="84">Mid Term</option>
                        <option value="85">Short Term</option>
                    </select>
                </div>
                <div class="col-md-6 form-group ">
                    <p><label for="martreview">Product Category:</label></p>
                    <select class="custom-select" name="category" id="category">
                        <option value="">Select Product Category</option>
                    <%
                       try{ 
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                            ResultSet.CONCUR_UPDATABLE);
                            st = conn.createStatement();
                            String sql = "SELECT * FROM categories";
                            ResultSet rs = st.executeQuery(sql);
                                while(rs.next()){ 
                                int cat_id = rs.getInt("id");
                                String cat_name = rs.getString("category");
                    %>
                            
                    <option value="<%=cat_id%>"><%=cat_name%></option>
                    <%
                                
                                }
                                
                            }catch(ClassNotFoundException | SQLException c){
                                out.println(c.getMessage());
                        
                            } 
                    %>   
                        
                            </select>
                </div>
                <input type="submit" class="btn btn-block btn-primary col-md-6 form-group" name="submit" value="Register Category">
            </form>
        </div>
    </div> 
</div>
<!-- Add product_category -->

<!-- Footer -->
<jsp:include page="includes/footer.jsp" flush="true"></jsp:include>
<!-- Footer -->