<%-- 
    Document   : index
    Created on : Mar 11, 2024, 9:55:40 PM
    Author     : iduni
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false); // Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("ID") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">

    <jsp:include page="includes/IncludeHead.jsp">
        <jsp:param name="title" value="Home" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="includes/IncludeNav.jsp" />

            <jsp:include page="includes/IncludeSideBar.jsp" />
            <div class="content-wrapper">
                <!-- Content Wrapper. Contains page content -->
                <jsp:include page="includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Dashboard" />
                </jsp:include>
                <!-- /.content-header -->
                <%
                    int TotSuppliers = 0;
                    int TotCustomers = 0;
                    int TotProducts = 0;
                    int TotOrders = 0;

                    try (Connection conn = DatabaseConnection.getConnection()) {
                        String[] queries = {
                            "SELECT COUNT(*) AS TotSuppliers FROM suppliers",
                            "SELECT COUNT(*) AS TotCustomers FROM customers",
                            "SELECT COUNT(*) AS TotProducts FROM products",
                            "SELECT COUNT(*) AS TotOrders FROM orders"
                        };

                        for (int i = 0; i < queries.length; i++) {
                            PreparedStatement checkStmt = conn.prepareStatement(queries[i]);
                            ResultSet checkResult = checkStmt.executeQuery();
                            if (checkResult.next()) {
                                switch (i) {
                                    case 0:
                                        TotSuppliers = checkResult.getInt("TotSuppliers");
                                        break;
                                    case 1:
                                        TotCustomers = checkResult.getInt("TotCustomers");
                                        break;
                                    case 2:
                                        TotProducts = checkResult.getInt("TotProducts");
                                        break;
                                    case 3:
                                        TotOrders = checkResult.getInt("TotOrders");
                                        break;
                                }
                            }
                            checkStmt.close();
                        }
                    } catch (SQLException ex) {
                        out.println(ex);
                    }

                %>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-info">
                                    <div class="inner">
                                        <h3><%= TotSuppliers%></h3>

                                        <p>Total Suppliers</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-bag"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/suppliers/suppliers.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <!-- ./col -->
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-success">
                                    <div class="inner">
                                        <h3><%= TotProducts%></h3>

                                        <p>Products</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-stats-bars"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/products/products.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <!-- ./col -->
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-warning">
                                    <div class="inner">
                                        <h3><%= TotCustomers%></h3>

                                        <p>User Registrations</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-person-add"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/customers/customers.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <!-- ./col -->
                            <div class="col-lg-3 col-6">
                                <!-- small box -->
                                <div class="small-box bg-danger">
                                    <div class="inner">
                                        <h3><%= TotOrders%></h3>

                                        <p>Orders</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-pie-graph"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/customers/orders.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                            <!-- ./col -->
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-12">
                                <div class="card">
                                    <div class="card-header border-transparent">
                                        <h3 class="card-title">Latest Orders</h3>

                                        <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                <i class="fas fa-minus"></i>
                                            </button>
<!--                                            <button type="button" class="btn btn-tool" data-card-widget="remove">
                                                <i class="fas fa-times"></i>
                                            </button>-->
                                        </div>
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-head-fixed text-nowrap" id="dataTable2">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Product Name</th>
                                                        <th>Date</th>
                                                        <th>Amount</th> 
                                                        <th>Status</th> 
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        try (Connection conn = DatabaseConnection.getConnection()) {

                                                            String checkSql = "SELECT o.OrderID, s.Name AS SupplierName, p.ProductName, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount, o.status FROM orders o JOIN suppliers s ON o.SupplierID = s.SupplierID JOIN products p ON o.ProductID = p.ProductID JOIN customers c ON o.CustomerID = c.CustomerID LIMIT 5";
                                                            PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                            ResultSet checkResult = checkStmt.executeQuery();

                                                            while (checkResult.next()) {
                                                                String order_id = checkResult.getString("orderid");
                                                                String status = checkResult.getString("status");
                                                    %>
                                                    <tr>
                                                        <td><%= checkResult.getString("orderid")%></td>
                                                        <td><%= checkResult.getString("ProductName")%></td>
                                                        <td><%= checkResult.getString("orderdate")%></td>
                                                        <td><%= checkResult.getString("totalamount")%></td>
                                                        <% if (status.equals("Shipped")) { %>
                                                        <td><span class="badge badge-success">Shipped</span></td>
                                                        <% } else if (status.equals("Pending")) { %>
                                                        <td><span class="badge badge-warning">Pending</span></td>
                                                        <% } else if (status.equals("Delivered")) { %>
                                                        <td><span class="badge badge-danger">Delivered</span></td>
                                                        <% } else if (status.equals("Processing")) { %>
                                                        <td><span class="badge badge-info">Processing</span></td>
                                                        <% } %>
                                                    </tr>

                                                    <%

                                                            }
                                                        } catch (SQLException ex) {
                                                            out.println(ex);
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- /.table-responsive -->
                                    </div>
                                    <!-- /.card-body -->
                                    <div class="card-footer clearfix">
                                        <a href="#" class="btn btn-sm btn-info float-left">Place New Order</a>
                                        <a href="${pageContext.request.contextPath}/customers/orders.jsp" class="btn btn-sm btn-secondary float-right">View All Orders</a>
                                    </div>
                                    <!-- /.card-footer -->
                                </div>
                            </div>
                            <!-- ./col -->
                            <div class="col-lg-6 col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Recently Added Products</h3>

                                        <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                <i class="fas fa-minus"></i>
                                            </button>
<!--                                            <button type="button" class="btn btn-tool" data-card-widget="remove">
                                                <i class="fas fa-times"></i>
                                            </button>-->
                                        </div>
                                    </div>
                                    <!-- /.card-header -->
                                    <div class="card-body p-0">
                                        <ul class="products-list product-list-in-card pl-2 pr-2">
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String user_id = request.getParameter("id");
                                                    String checkSql = "SELECT * FROM products LIMIT 5";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {

                                            %>
                                            <li class="item">
                                                <div class="product-img">
                                                    <img src="dist/img/default-150x150.png" alt="Product Image" class="img-size-50">
                                                </div>
                                                <div class="product-info">
                                                    <a href="${pageContext.request.contextPath}/products/ViewProduct.jsp?id=<%= checkResult.getString("productID")%>" class="product-title"><%= checkResult.getString("ProductName")%>
                                                        <span class="badge badge-warning float-right">$<%= checkResult.getString("price")%></span></a>
                                                    <span class="product-description">
                                                        <%= checkResult.getString("description")%>
                                                    </span>
                                                </div>
                                            </li>
                                            <%                                }
                                                } catch (SQLException ex) {
                                                    out.println(ex);
                                                }
                                            %>
                                        </ul>
                                    </div>
                                    <!-- /.card-body -->
                                    <div class="card-footer text-center">
                                        <a href="${pageContext.request.contextPath}/products/products.jsp" class="uppercase">View All Products</a>
                                    </div>
                                    <!-- /.card-footer -->
                                </div>
                            </div>
                            <!-- ./col -->

                        </div>
                    </div>
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <strong>Copyright &copy; 2021-2024 <a href="https://razorisuru.com">RaZoR ISURU</a>.</strong>
                All rights reserved.
                <div class="float-right d-none d-sm-inline-block">

                </div>
            </footer>

            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
                <!-- Control sidebar content goes here -->
            </aside>
            <!-- /.control-sidebar -->

            <!-- ./wrapper -->
        </div>
        <jsp:include page="includes/IncludeFooter.jsp" />
    </body>

</html>
