

 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%
    // Get the current session or create a new one if it doesn't exist
    String username = null;
    String role = null;

    // Use the implicit 'session' object to retrieve session data
    if (session != null) {
        username = (String) session.getAttribute("username");  // Retrieve the 'username' from session
        role = (String) session.getAttribute("role");  // Retrieve the 'role' from session
    }

    if (username == null || role == null) {
        // If there is no username or role in session (user is not logged in), redirect to login page
        response.sendRedirect("login.html");
    }
    
    // Initialize variables for form data
    String startDate = request.getParameter("leave-start-date");
    String endDate = request.getParameter("leave-end-date");
    String reason = request.getParameter("reason");
    String leaveDays = request.getParameter("leave-days");
    
    // Set approval_status to 'Pending' by default
    String approvalstatus = "Pending"; // This is automatically set, no need to fetch from form

    // Database connection setup
    String dbURL = "jdbc:mysql://localhost:3306/oms";
    String dbUser = "root";
    String dbPassword = "PRAbhu@mysql";

    // SQL query to insert the leave request into the database
    String sql = "INSERT INTO staff_leave_requests (username, start_date, end_date, reason, leave_days, approval_status) VALUES (?, ?, ?, ?, ?, ?)";
    Connection connection = null;
    PreparedStatement stmt = null;

    // Check if the form has been submitted
    if ("POST".equalsIgnoreCase(request.getMethod()) && startDate != null && endDate != null && reason != null && leaveDays != null) {
        try {
            // Establish database connection
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            stmt = connection.prepareStatement(sql);

            // Set the parameters for the SQL query
            stmt.setString(1, username);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            stmt.setString(4, reason);
            stmt.setInt(5, Integer.parseInt(leaveDays));
            stmt.setString(6, approvalstatus);  // Automatically set to 'Pending'

            // Execute the query and check if the insertion is successful
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Redirect to a success message or display success here
                out.println("<script>alert('Leave request successfully submitted!'); window.location.href='viewstaffleaveform.jsp';</script>");
            } else {
                // Display an error message if insertion fails
                out.println("<script>alert('Error: Could not submit leave request.');</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Database error: " + e.getMessage() + "');</script>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
 