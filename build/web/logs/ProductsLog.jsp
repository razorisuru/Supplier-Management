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
    String role = (String) session.getAttribute("ROLE");

    if (session == null || session.getAttribute("ID") == null) {
        response.sendRedirect("../login.jsp");
    } else if (role == null || !role.equals("admin")) {
        response.sendRedirect("../index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="Products Audit" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Products Audit" />
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
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
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
                                                <th>Product ID</th>
                                                <th>Username</th>
                                                <th>Action</th>
                                                <th>Time</th> 
                                                <th>Old Product Name</th> 
                                                <th>Old Description</th>  
                                                <th>Old Price</th>  
                                                <th>Old Quantity</th> 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String checkSql = "SELECT * FROM products_audit";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {
                                                        String Prodcuts_Audit_ID = checkResult.getString("Prodcuts_Audit_ID");
                                                        String action = checkResult.getString("action");
                                            %>
                                            <tr>
                                                <td><%= Prodcuts_Audit_ID%></td>
                                                <td><a class=""  href="${pageContext.request.contextPath}/products/ViewProduct.jsp?id=<%= checkResult.getString("Productid")%>"><%= checkResult.getString("Productid")%></a></td>
                                                <td><%= checkResult.getString("username")%></td>
                                                <% if (action.equals("INSERT")) { %>
                                                <td><span class="badge badge-success">Insert</span></td>
                                                <% } else if (action.equals("UPDATE")) { %>
                                                <td><span class="badge badge-warning">Update</span></td>
                                                <% } else if (action.equals("DELETE")) { %>
                                                <td><span class="badge badge-danger">Delete</span></td>
                                                <% }%>
                                                <td><%= checkResult.getString("timestamp")%></td>
                                                <td><%= checkResult.getString("old_productname")%></td>
                                                <td><%= checkResult.getString("old_description")%></td>
                                                <td><%= checkResult.getString("old_price")%></td>
                                                <td><%= checkResult.getString("old_quantity")%></td>
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
