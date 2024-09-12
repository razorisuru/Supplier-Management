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
        <jsp:param name="title" value="View Supplier" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">


            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="View Supplier" />
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

                                String sup_id = request.getParameter("id");
//                                                encrypt the id

                                String checkSql = "SELECT * FROM Suppliers WHERE supplierid = ?";
                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                checkStmt.setString(1, sup_id);

                                ResultSet checkResult = checkStmt.executeQuery();

                                if (checkResult.next()) {

                        %>
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Supplier Details #<%= checkResult.getString("supplierid")%></h3>
                                    </div> 
                                    <div class="card-body">

                                        <dl class="row">
                                            <dt class="col-sm-4">Company Name</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("Name")%></dd>
                                            <dt class="col-sm-4">Contact Person</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("contactperson")%></dd>
                                            <dt class="col-sm-4">Email</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("email")%></dd>
                                            <dt class="col-sm-4">Phone</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("phone")%></dd>
                                            <dt class="col-sm-4">Address</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("address")%></dd>
                                            <dt class="col-sm-4">City</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("city")%></dd>
                                            <dt class="col-sm-4">State</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("state")%></dd>
                                            <dt class="col-sm-4">Postal Code</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("postalcode")%></dd>
                                            <dt class="col-sm-4">Country</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("country")%></dd>
                                            <dt class="col-sm-4">Created Time</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("createdAt")%></dd>
                                            <dt class="col-sm-4">Updated Time</dt>
                                            <dd class="col-sm-8"><%= checkResult.getString("updatedAt")%></dd>
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
