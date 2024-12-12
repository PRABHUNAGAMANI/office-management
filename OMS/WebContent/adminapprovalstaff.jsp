
 
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>

<%
    // Get the staff username and leave request ID from the session and the request
    String adminUsername = (String) session.getAttribute("username");  // Staff's username from session
    String role = (String) session.getAttribute("role");  // Role from session
    String requestId = request.getParameter("requestId");

    // Check if the role is staff and if the requestId is valid
    if (adminUsername == null || requestId == null || !role.equals("admin")) {
        response.sendRedirect("signup.html"); // Redirect to login page if not logged in or invalid request
        return;
    }

    // Database connection setup
    String dbURL = "jdbc:mysql://localhost:3306/oms";
    String dbUser = "root";
    String dbPassword = "PRAbhu@mysql";

    // SQL query to update the approval status and set granted_by
    String updateSQL = "UPDATE staff_leave_requests SET approval_status = 'Granted', granted_by = ? WHERE id = ?";
    Connection connection = null;
    PreparedStatement stmt = null;

    try {
        // Establish database connection
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = connection.prepareStatement(updateSQL);

        // Set the parameters for the SQL query
        stmt.setString(1, adminUsername); // Staff username
        stmt.setString(2, requestId);     // Leave request ID

        // Execute the update query
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            response.getWriter().write("success");  // If the update was successful, return success
        } else {
            response.getWriter().write("error");   // If no rows were affected, return error
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().write("error");  // Return error if an exception occurs
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
 

