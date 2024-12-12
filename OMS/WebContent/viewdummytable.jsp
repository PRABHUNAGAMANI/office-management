<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String eformIdString = request.getParameter("eform_id");
    out.println("<h3>eform_id parameter: " + eformIdString + "</h3>");

 // Get eform_id from request
    int eformId = -1;  // Initialize with a default invalid value
    
    // Check if eform_id is present and valid
    if (eformIdString != null && !eformIdString.isEmpty()) {
        try {
            eformId = Integer.parseInt(eformIdString); // Attempt to parse it to an integer
        } catch (NumberFormatException e) {
            // Handle invalid number format exception
            out.println("<h3 style='color:red;'>Invalid eform_id parameter. Please check the input.</h3>");
            return;
        }
    } else {
        out.println("<h3 style='color:red;'>eform_id is missing or invalid.</h3>");
        return;
    }
    
    String eformFullname = "";
    String attemptNumber = "";
    String attemptReason = "";

    try {
        // Load MySQL JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

        // Query to join eFormInsert and dummy_attempts based on eform_id
        ps = con.prepareStatement(
            "SELECT e.fullname AS eform_fullname, d.attempt_number, d.reason " +
            "FROM eFormInsert e " +
            "JOIN dummy_attempts d ON e.eform_id = d.eform_id " +
            "WHERE e.eform_id = ?");
        ps.setInt(1, eformId); // Set eform_id as a parameter
        rs = ps.executeQuery();

        // Process the result set
        if (rs.next()) {
            eformFullname = rs.getString("eform_fullname");
            attemptNumber = rs.getString("attempt_number");
            attemptReason = rs.getString("reason");
        } else {
            out.println("<h3 style='color:red;'>No record found for eform_id: " + eformId + "</h3>");
            return;
        }
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
</head>
<body>
    <h2>Student Full Name and Attempt Details</h2>
    <p><strong>From eFormInsert:</strong> <%= eformFullname %></p>
    <p><strong>Attempt Number:</strong> <%= attemptNumber != null ? attemptNumber : "No attempt data" %></p>
    <p><strong>Attempt Reason:</strong> <%= attemptReason != null ? attemptReason : "No reason provided" %></p>
</body>
</html>

<%
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;'>An error occurred while retrieving the data. Please try again later.</h3>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
