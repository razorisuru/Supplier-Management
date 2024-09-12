/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SupplierController;

import Models.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author iduni
 */
@WebServlet(name = "AddSupplierController", urlPatterns = {"/AddSupplierController"})
public class AddSupplierController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        String company = request.getParameter("company");
        String ContactPerson = request.getParameter("ContactPerson");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String code = request.getParameter("code");
        String country = request.getParameter("country");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO suppliers(name,ContactPerson,email,phone,address,city,state,postalcode,country) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, company);
            stmt.setString(2, ContactPerson);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setString(6, city);
            stmt.setString(7, state);
            stmt.setString(8, code);
            stmt.setString(9, country);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
//                out.println("SUCCESS");
//                out.println("{ \"status\": \"ERROR\", \"message\": \"SIGNUP SUCCESSFULL. Now You Can login\" }");
                request.setAttribute("msg", "Supplier Added Successfully");
                request.setAttribute("clz", "alert-success");
                request.getRequestDispatcher("/suppliers/suppliers.jsp").forward(request, response);

            } else {
                request.setAttribute("Reg_msg", "SQL ERROR");
                request.setAttribute("Reg_clz", "alert-danger");
                request.getRequestDispatcher("/suppliers/AddSupplier.jsp").forward(request, response);
            }
            DatabaseConnection.closeConnection(conn);

        } catch (SQLException e) {
            request.setAttribute("Reg_msg", " "+e);
            request.setAttribute("Reg_clz", "alert-danger");
            request.getRequestDispatcher("/suppliers/AddSupplier.jsp").forward(request, response);
        }
    }
}
