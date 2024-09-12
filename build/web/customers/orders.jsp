<%-- 
    Document   : index
    Created on : Mar 11, 2024, 9:55:40 PM
    Author     : iduni
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false); // Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("ID") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="Orders" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Orders" />
                    <jsp:param name="name" value="Manage Orders" />
                </jsp:include>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <% String msg = (String) request.getAttribute("msg");
                                    String clz = (String) request.getAttribute("clz");
                                    if (msg != null && clz != null) {
                                %>

                                <div class="alert <%= clz%> alert-dismissible fade show mt-4" role="alert">
                                    <strong><%= msg%></strong> 

                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="col-md-12">
                                <div class="card">

                                    <table class="table table-hover table-head-fixed text-nowrap" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Supplier Name</th>
                                                <th>Product Name</th>
                                                <th>Customer Name</th>
                                                <th>Date</th>
                                                <th>Amount</th> 
                                                <th>Status</th> 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String checkSql = "SELECT o.OrderID, s.Name AS SupplierName, p.ProductName, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount, o.status FROM orders o JOIN suppliers s ON o.SupplierID = s.SupplierID JOIN products p ON o.ProductID = p.ProductID JOIN customers c ON o.CustomerID = c.CustomerID";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {
                                                        String order_id = checkResult.getString("orderid");
                                                        String status = checkResult.getString("status");
                                            %>
                                            <tr>
                                                <td><%= checkResult.getString("orderid")%></td>
                                                <td><%= checkResult.getString("SupplierName")%></td>
                                                <td><%= checkResult.getString("ProductName")%></td>
                                                <td><%= checkResult.getString("FirstName")%> <%= checkResult.getString("LastName")%></td>
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
                            </div>
                        </div>
                        <div class="row">
                            <!-- ./col -->

                            <!-- /.row -->
                            <!-- Main row -->
                            <div class="row">

                                <!-- /.row (main row) -->
                            </div><!-- /.container-fluid -->
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
        </div>
        <!-- ./wrapper -->

        <jsp:include page="/includes/IncludeFooter.jsp" />
    </body>

</html>
