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
        <jsp:param name="title" value="Customers" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Customers" />
                    <jsp:param name="name" value="Manage Customers" />
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
                                                <th>Full Name</th>
                                                
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Address</th> 
                                                <th>City</th> 
                                                <th>Postal</th> 
                                                <th>Country</th> 
                                                <!--<th>Action</th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String checkSql = "SELECT * FROM customers";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {
                                                        String id = checkResult.getString("customerid");
                                            %>
                                            <tr>
                                                <td><%= id%></td>
                                                <td><a class=""  href="${pageContext.request.contextPath}/customers/ViewOrders.jsp?id=<%= id%>"><%= checkResult.getString("firstname")%> <%= checkResult.getString("lastname")%></a></td>
                                                <td><%= checkResult.getString("email")%></td>
                                                <td><%= checkResult.getString("phone")%></td>
                                                <td><%= checkResult.getString("address")%></td>
                                                <td><%= checkResult.getString("city")%></td>
                                                <td><%= checkResult.getString("postalcode")%></td>
                                                <td><%= checkResult.getString("country")%></td>
<!--                                                    <td><a class="btn btn-sm btn-success"  href="UserUpdate.jsp?id=<%=id%>">Edit</a>
                                                    <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/UserDeleteController?id=<%=id%>" onclick="return confirm('Are you sure you want to delete?')">Delete</a>
                                                </td> -->
                                            </tr>

                                            <%

                                                    }
                                                } catch (SQLException ex) {
                                                    System.out.println(ex);
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
