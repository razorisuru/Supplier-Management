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
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="View Product" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">


            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="View Product" />
                </jsp:include>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <% String Reg_msg = (String) request.getAttribute("msg");
                                    String Reg_clz = (String) request.getAttribute("clz");
                                    if (Reg_msg != null && Reg_clz != null) {
                                %>

                                <div class="alert <%= Reg_clz%> alert-dismissible fade show mt-4" role="alert">
                                    <strong><%= Reg_msg%></strong> 
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                </div>

                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <%
                            try (Connection conn = DatabaseConnection.getConnection()) {

                                String pro_id = request.getParameter("id");
//                                                encrypt the id

                                String checkSql = "SELECT p.productid, s.name AS SupName, p.ProductName, p.description, p.price, p.quantity FROM products p JOIN suppliers s ON s.supplierid = p.supplierid WHERE productid = ?";
                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                checkStmt.setString(1, pro_id);

                                ResultSet checkResult = checkStmt.executeQuery();

                                if (checkResult.next()) {

                        %>
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Product Details #<%= checkResult.getString("productid")%></h3>
                                    </div> 
                                    <div class="card-body">

                                        <dl class="row">
                                            <dt class="col-sm-4">Product Name</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("ProductName")%></dd>
                                            <dt class="col-sm-4">Supplier Name</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("SupName")%></dd>
                                            <dt class="col-sm-4">Description</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("description")%></dd>
                                            <dt class="col-sm-4">Price</dt>
                                            <dd class="col-sm-8">$<%= checkResult.getString("price")%></dd>
                                            <dt class="col-sm-4">Quantity</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("quantity")%></dd>
                                        </dl>
                                    </div>
                                    <div class="card-footer">
                                        <button type="submit" class="btn btn-primary">Print</button>
                                    </div>


                                </div>
                                <!-- /.card -->
                            </div>
                            <!-- /.row -->
                            <!-- Main row -->

                        </div>
                        <%                                } else {
                        %>
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Product Details</h3>
                                    </div> 
                                    <div class="card-body">

                                        <dl class="row">
                                            <dt class="col-sm-4">Product deleted or not found</dt>
                                            <dd class="col-sm-8"></dd>

                                        </dl>
                                    </div>


                                </div>
                                <!-- /.card -->
                            </div>
                            <!-- /.row -->
                            <!-- Main row -->

                        </div>
                        <%
                                }
                            } catch (SQLException ex) {
                                out.println(ex);
                            }
                        %>
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
