<!-- Head -->
<jsp:include page="includes/header.jsp" flush="true"></jsp:include>
<!-- Head -->
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>


<!-- Product_category  -->
<button class="btn btn-block btn-primary font-weight-bold my-3 py-3">Adding Product Categories</button>
    <div class="container-fluid">
            <div class="col-lg-8 table-responsive mb-5">
                <a href="DashboardManager.jsp" class="btn btn-block btn-primary col-md-6 form-group">DASHBOARD</a>
                <a href="#add_category" class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 30px;">ADD</a>
                <div class="col-md-6 form-group">
                    <p style="color:green">${requestScope.success}</p>
                </div>
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Category</th>
                            <th>Image</th>
                            <th>Products No</th>
                            <th>Date Added</th>
                            <th>Description</th>
                            <th>status</th>
                        </tr>
                    </thead>
                    <% 
                    try{ 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                        Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);
                        st = conn.createStatement();
                        String sql = "SELECT *, COUNT(categories.id)"
                                     + " FROM products INNER JOIN categories ON products.category = categories.id"
                                     + " GROUP BY products.category";
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()){
                    %>
                    <tbody class="align-middle">
                        <tr>
                            <td class="align-middle"><%=rs.getInt("categories.id") %></td>
                            <td class="align-middle"><%=rs.getString("categories.category") %></td>
                            <td class="align-middle"><img class="img-fluid w-5" src="img/<%=rs.getString("cat_image") %>" alt=""></td>
                            <td class="align-middle"><%=rs.getInt("COUNT(categories.id)") %></td>
                            <td class="align-middle"><%=rs.getString("categories.date_created") %></td>
                            <td class="align-middle"><%=rs.getString("categories.description") %></td>
                            <td class="align-middle"><button class="btn btn-sm btn-success">Activate!</button></td>
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
<div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex" id="add_category">
    <div class="content text-center ml-3" id="add_product">
        <h1 class="h1 text-primary bg-dark px-2" style="color: yellow; font-size: 46px;">Add Product Category</h1>
        <div class="form">
            <form class="text-center"post" action="customerdb.jsp">
                <div class="col-md-6 form-group">
                    <p style="color:red">${requestScope.error}</p>
                </div>
                <input type="hidden" id="action" name="dataEntry" value="register_category" hidden>
                <div class="col-md-6 form-group">
                    <label>Product Category</label>
                    <input class="form-control text-center" type="text" placeholder="Men's Shirts" name="category" id="category" required>
                </div>
                <div class="col-md-6 form-group ">
                    <label>Attach Category Image</label> 
                    <input type="file" name="category_image" id="category_image" class="form-control text-center" required/>
                </div>
                <div class="col-md-6 form-group ">
                    <p><label for="martreview">Description:</label></p>
                    <textarea id="martreview" name="description" rows="4" cols="50">unique attires.</textarea>
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