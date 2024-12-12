/*package OMSservlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.*;
import java.time.format.*;
import java.math.BigDecimal;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oms"; // Update your DB URL
    private static final String DB_USERNAME = "root"; // Update with your DB username
    private static final String DB_PASSWORD = "PRAbhu@mysql"; // Update with your DB password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	 response.setContentType("text/html");
         PrintWriter pw = response.getWriter();
    	
        // Get the session and the logged-in username
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || role == null) {
            response.sendRedirect("signup.html");  // If user is not logged in, redirect to login page
            return;
        }

        // Retrieve form data
        String attendanceDate = request.getParameter("attendance_date");
        String checkinTime = request.getParameter("checkin_time");  // Example: "02:30 PM"
        String checkoutTime = request.getParameter("checkout_time"); // Example: "05:30 PM"
        String totalHours = request.getParameter("total_hours");

        // Convert date to SQL Date
        LocalDate date = LocalDate.parse(attendanceDate);
        java.sql.Date sqlDate = java.sql.Date.valueOf(date);

        // Calculate the total hours (if needed, you can move this logic into the server-side)
        BigDecimal totalHoursDecimal = calculateTotalHours(checkinTime, checkoutTime);

        // Database connection setup
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            // SQL insert statement to save attendance
            String sql = "INSERT INTO studentattendance (username, role, attendance_date, checkin_time, checkout_time, total_hours) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                // Set values from the form
                ps.setString(1, username);
                ps.setString(2, role);
                ps.setDate(3, sqlDate);
                ps.setString(4, checkinTime); // checkin_time (hh:mm AM/PM)
                ps.setString(5, checkoutTime); // checkout_time (hh:mm AM/PM)
                ps.setBigDecimal(6, totalHoursDecimal); // total_hours as a decimal

                // Execute the update to insert the data into the database
                int result = ps.executeUpdate();

                if (result > 0) {
                    // Check role and redirect accordingly
                    if ("student".equalsIgnoreCase(role)) 
                    {
                        response.sendRedirect("viewattendance.jsp");  // Redirect to student home if role is student
                    } 
                    else if ("staff".equalsIgnoreCase(role)) 
                    {
                        response.sendRedirect("staffattendance.jsp");  // Redirect to staff home if role is staff
                    } 
                    else if ("admin".equalsIgnoreCase(role)) 
                    {
                        response.sendRedirect("adminattendance.jsp");  // Redirect to staff home if role is staff
                    } 
                    else 
                    {
                        pw.println("<script>alert('Unknown role!'); window.location.href='signup.html';</script>");
                    }
                } 
                else 
                {
                    // If there is an issue, redirect to error page
                    pw.println("<script>alert('Attendance not saved!'); window.location.href='studenthome.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("attendanceError.jsp");  // Handle DB errors and redirect to error page
        }
    }
    *//**
     * Helper method to calculate total hours based on check-in and check-out times.
     * The time is assumed to be in the format "hh:mm AM/PM"
     * @param checkinTime Check-in time (hh:mm AM/PM)
     * @param checkoutTime Check-out time (hh:mm AM/PM)
     * @return Total hours worked as a BigDecimal
     *//*
    private BigDecimal calculateTotalHours(String checkinTime, String checkoutTime) {
        // Define a date-time formatter for parsing the time (12-hour format with AM/PM)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");

        try {
            // Parse the check-in and check-out times
            LocalTime checkin = LocalTime.parse(checkinTime, formatter);
            LocalTime checkout = LocalTime.parse(checkoutTime, formatter);

            // Calculate the duration between check-in and check-out
            long durationInMinutes = Duration.between(checkin, checkout).toMinutes();

            // Convert the duration to hours (allowing for fractions of an hour)
            return BigDecimal.valueOf(durationInMinutes).divide(BigDecimal.valueOf(60), 2, BigDecimal.ROUND_HALF_UP);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return BigDecimal.ZERO;  // In case of parsing error, return 0 hours
        }
    }
}
*/



package OMSservlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.*;
import java.time.format.*;
import java.math.BigDecimal;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/oms"; // Update your DB URL
    private static final String DB_USERNAME = "root"; // Update with your DB username
    private static final String DB_PASSWORD = "PRAbhu@mysql"; // Update with your DB password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Set response content type
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        // Get the session and the logged-in username
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // Redirect if user is not logged in
        if (username == null || role == null) {
            response.sendRedirect("signup.html");  // If user is not logged in, redirect to login page
            return;
        }

        // Retrieve form data
        String attendanceDate = request.getParameter("attendance_date");
        String checkinTime = request.getParameter("checkin_time");
        String checkoutTime = request.getParameter("checkout_time");
        String totalHoursStr = request.getParameter("total_hours");

        // Convert date to SQL Date
        LocalDate date = LocalDate.parse(attendanceDate);
        java.sql.Date sqlDate = java.sql.Date.valueOf(date);

        // Calculate total hours (if needed, you can move this logic into the server-side)
        BigDecimal totalHours = calculateTotalHours(checkinTime, checkoutTime);

        // Database connection setup
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            // SQL insert statement to save attendance
            String sql = "INSERT INTO studentattendance (username, role, attendance_date, checkin_time, checkout_time, total_hours, weekly_total_hours, monthly_total_hours) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            // Calculate weekly and monthly total hours
            BigDecimal weeklyTotalHours = calculateWeeklyTotalHours(username, conn, date);
            BigDecimal monthlyTotalHours = calculateMonthlyTotalHours(username, conn, date);

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                // Set values from the form
                ps.setString(1, username);
                ps.setString(2, role);
                ps.setDate(3, sqlDate);
                ps.setString(4, checkinTime); // checkin_time (hh:mm AM/PM)
                ps.setString(5, checkoutTime); // checkout_time (hh:mm AM/PM)
                ps.setBigDecimal(6, totalHours); // total_hours as a decimal
                ps.setBigDecimal(7, weeklyTotalHours); // weekly total hours
                ps.setBigDecimal(8, monthlyTotalHours); // monthly total hours

                // Execute the update to insert the data into the database
                int result = ps.executeUpdate();

                if (result > 0) {
                    // Redirect to role-specific page after successful insertion
                    if ("student".equalsIgnoreCase(role)) {
                        response.sendRedirect("viewattendance.jsp");  // Redirect to student home if role is student
                    } else if ("staff".equalsIgnoreCase(role)) {
                        response.sendRedirect("staffattendance.jsp");  // Redirect to staff home if role is staff
                    } else if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("adminattendance.jsp");  // Redirect to admin home if role is admin
                    } else {
                        pw.println("<script>alert('Unknown role!'); window.location.href='signup.html';</script>");
                    }
                } else {
                    // If there is an issue, redirect to error page
                    pw.println("<script>alert('Attendance not saved!'); window.location.href='studenthome.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("attendanceError.jsp");  // Handle DB errors and redirect to error page
        }
    }

    /**
     * Helper method to calculate total hours based on check-in and check-out times.
     * The time is assumed to be in the format "hh:mm AM/PM"
     * @param checkinTime Check-in time (hh:mm AM/PM)
     * @param checkoutTime Check-out time (hh:mm AM/PM)
     * @return Total hours worked as a BigDecimal
     */
    private BigDecimal calculateTotalHours(String checkinTime, String checkoutTime) {
        // Define a date-time formatter for parsing the time (12-hour format with AM/PM)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");

        try {
            // Parse the check-in and check-out times
            LocalTime checkin = LocalTime.parse(checkinTime, formatter);
            LocalTime checkout = LocalTime.parse(checkoutTime, formatter);

            // Calculate the duration between check-in and check-out
            long durationInMinutes = Duration.between(checkin, checkout).toMinutes();

            // Convert the duration to hours (allowing for fractions of an hour)
            return BigDecimal.valueOf(durationInMinutes).divide(BigDecimal.valueOf(60), 2, BigDecimal.ROUND_HALF_UP);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return BigDecimal.ZERO;  // In case of parsing error, return 0 hours
        }
    }

    /**
     * Helper method to calculate weekly total hours for a given user.
     * @param username The username of the user
     * @param conn The database connection
     * @param date The current date for reference
     * @return The total hours worked in the current week
     */
    private BigDecimal calculateWeeklyTotalHours(String username, Connection conn, LocalDate date) throws SQLException {
        LocalDate startOfWeek = date.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = date.with(DayOfWeek.SUNDAY);

        String sql = "SELECT SUM(total_hours) FROM studentattendance "
                   + "WHERE username = ? AND attendance_date BETWEEN ? AND ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setDate(2, java.sql.Date.valueOf(startOfWeek));
            ps.setDate(3, java.sql.Date.valueOf(endOfWeek));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1) : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }

    /**
     * Helper method to calculate monthly total hours for a given user.
     * @param username The username of the user
     * @param conn The database connection
     * @param date The current date for reference
     * @return The total hours worked in the current month
     */
    private BigDecimal calculateMonthlyTotalHours(String username, Connection conn, LocalDate date) throws SQLException {
        LocalDate startOfMonth = date.withDayOfMonth(1);
        LocalDate endOfMonth = date.withDayOfMonth(date.lengthOfMonth());

        String sql = "SELECT SUM(total_hours) FROM studentattendance "
                   + "WHERE username = ? AND attendance_date BETWEEN ? AND ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setDate(2, java.sql.Date.valueOf(startOfMonth));
            ps.setDate(3, java.sql.Date.valueOf(endOfMonth));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1) : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }
}
