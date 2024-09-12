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
        <jsp:param name="title" value="Suppliers Audit" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Suppliers Audit" />
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
                                                <th>Supplier ID</th>
                                                <th>Username</th>
                                                <th>Action</th>
                                                <th>Time</th> 
                                                <th>Old Name</th> 
                                                <th>Old Contact Person</th>  
                                                <th>Old Email</th>  
                                                <th>Old Phone</th> 
                                                <th>Old Address</th> 
                                                <th>Old City</th> 
                                                
                                                <th>Old Postal Code</th> 
                                                <th>Old Country</th> 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String checkSql = "SELECT * FROM suppliers_audit";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {
                                                        String Suppliers_Audit_ID = checkResult.getString("Suppliers_Audit_ID");
                                                        String action = checkResult.getString("action");
                                            %>
                                            <tr>
                                                <td><%= Suppliers_Audit_ID %></td>
                                                <td><%= checkResult.getString("supplierid")%></td>
                                                <td><%= checkResult.getString("username")%></td>
                                                <% if (action.equals("INSERT")) { %>
                                                <td><span class="badge badge-success">Insert</span></td>
                                                <% } else if (action.equals("UPDATE")) { %>
                                                <td><span class="badge badge-warning">Update</span></td>
                                                <% } else if (action.equals("DELETE")) { %>
                                                <td><span class="badge badge-danger">Delete</span></td>
                                                <% }%>
                                                <td><%= checkResult.getString("timestamp")%></td>
                                                <td><%= checkResult.getString("old_name")%></td>
                                                <td><%= checkResult.getString("old_contactperson")%></td>
                                                <td><%= checkResult.getString("old_email")%></td>
                                                <td><%= checkResult.getString("old_phone")%></td>
                                                <td><%= checkResult.getString("old_address")%></td>
                                                <td><%= checkResult.getString("old_city")%></td>
                     
                                                <td><%= checkResult.getString("old_postalcode")%></td>
                                                <td><%= checkResult.getString("old_country")%></td>
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
