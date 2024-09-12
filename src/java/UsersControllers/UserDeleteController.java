/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsersControllers;

import SupplierController.*;
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
@WebServlet(name = "UserDeleteController", urlPatterns = {"/UserDeleteController"})
public class UserDeleteController extends HttpServlet {


   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        String sup_id = request.getParameter("id");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "DELETE from users where id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, sup_id);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
//                out.println("SUCCESS");
//                out.println("{ \"status\": \"ERROR\", \"message\": \"SIGNUP SUCCESSFULL. Now You Can login\" }");
                request.setAttribute("msg", "Delete success.");
                request.setAttribute("clz", "alert-success");
                request.getRequestDispatcher("/users/users.jsp").forward(request, response);

            } else {
                request.setAttribute("msg", "Data error.");
                request.setAttribute("clz", "alert-warning");
                request.getRequestDispatcher("/users/users.jsp").forward(request, response);
            }
            DatabaseConnection.closeConnection(conn);

        } catch (SQLException e) {
            request.setAttribute("msg", ""+e);
                request.setAttribute("clz", "alert-danger");
                request.getRequestDispatcher("/users/users.jsp").forward(request, response);
        }
    }

        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}
