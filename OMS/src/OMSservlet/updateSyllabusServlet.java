package OMSservlet;


import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateSyllabusServlet")
public class updateSyllabusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");         // Get the ID to update
        String finaldate = request.getParameter("finaldate"); // Get the final date
        String topic = request.getParameter("topic");     // Get the topic
        String syllabus = request.getParameter("syllabus"); // Get the syllabus content

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
            
            // SQL statement to update the syllabus
            String sql = "UPDATE syllabus_upload SET final_date = ?, topic = ?, syllabus = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            
            // Set parameters in the prepared statement
            ps.setString(1, finaldate);
            ps.setString(2, topic);
            ps.setString(3, syllabus);
            ps.setString(4, id);
            
            // Execute update query
            int rowsUpdated = ps.executeUpdate();
            
            // Check if the update was successful
            if (rowsUpdated > 0) {
                response.sendRedirect("viewsyllabus.jsp");
            } else {
                response.getWriter().println("Error updating syllabus.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

