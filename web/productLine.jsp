<!-- Head -->
<jsp:include page="includes/header.jsp" flush="true"></jsp:include>
<!-- Head -->
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.SQLException"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.DriverManager"%>


<!-- Product_line  -->
<button class="btn btn-block btn-primary font-weight-bold my-3 py-3">Product Line & Term Entries To a Deadline</button>
    <div class="container-fluid">
        <div class="row px-xl-5">
            <div class="col-lg-8 table-responsive mb-5">
                <a href="DashboardManager.jsp" class="btn btn-block btn-primary col-md-6 form-group">DASHBOARD</a>
                <a href="#add_product_term" class="h6 text-primary bg-dark px-2" style="color: yellow; font-size: 30px;">UPDATE</a>
                <div class="col-md-6 form-group">
                    <p style="color:green">${requestScope.error}</p>
                </div>
                <table class="table table-light table-borderless table-hover text-center mb-0">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Term</th>
                            <th>Quantity</th>
                            <th>Remainders</th>
                            <th>Performance</th>
                            <th>Date Added</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <% 
                    try{ 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mart","root","");
                        Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_UPDATABLE);
                        st = conn.createStatement();
                        String sql = "SELECT * FROM product_line";
                        ResultSet rs = st.executeQuery(sql);
                        while(rs.next()){
                        int total = rs.getInt("quantity");
                        int left = rs.getInt("quantity_left");
                        double percentage = 100-(((double)left/total)*100);
                    %>
                    <tbody class="align-middle">
                        <tr>
                            <td class="align-middle"><%=rs.getInt("id") %></td>
                            <td class="align-middle"><%=rs.getString("product_term") %></td>
                            <td class="align-middle"><%=rs.getString("quantity") %></td>
                            <td class="align-middle"><%=rs.getString("quantity_left") %></td>
                            <td class="align-middle"><%=percentage%>%</td>
                            <td class="align-middle"><%=rs.getString("date_added") %></td>
                            <td class="align-middle"><%=rs.getString("description") %></td>
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
    </div>
<!-- Product line End --> 

<!-- Add Product line -->
<div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex" id="add_product_term">
    <div class="content text-center ml-3" id="add_product">
        <h1 class="h1 text-primary bg-dark px-2" style="color: yellow; font-size: 46px;">Update product Line</h1>
        <div class="form">
            <form class="text-center"post" action="customerdb.jsp">
                <div class="col-md-6 form-group">
                    <p style="color:red">${requestScope.error}</p>
                </div>
                <input type="hidden" id="action" name="dataEntry" value="register_productline" hidden>
                <div class="col-md-6 form-group">
                    <label>Product Term</label> 
                    <select class="form-control" name="productTerm">
                        <option value="">Select</option>
                        <option value="long term">Long Term</option>
                    </select>
                </div>
                <div class="col-md-6 form-group ">
                    <label>Quantity</label>
                    <input class="form-control text-center" type="number" placeholder="0" name="quantity" id="quantity" required>
                </div>
                <div class="col-md-6 form-group">
                    <label>Date Added</label>
                    <input class="form-control text-center" type="date" placeholder="dd/mm/yyyy" name="dateAdded" required>
                </div>
                <div class="col-md-6 form-group ">
                    <p><label for="martreview">Description:</label></p>
                    <textarea id="martreview" name="description" rows="4" cols="50">unique attires.</textarea>
                </div>
                <input type="submit" class="btn btn-block btn-primary col-md-6 form-group" name="submit" value="Register Term">
            </form>
        </div>
    </div> 
</div>
<!-- End Product line -->

<!-- Footer -->
<jsp:include page="includes/footer.jsp" flush="true"></jsp:include>
<!-- Footer -->