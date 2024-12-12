<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%
    String id = request.getParameter("id");
    String status = request.getParameter("status");
    String reason = request.getParameter("reason");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

        if ("completed".equals(status)) {
            ps = con.prepareStatement("UPDATE syllabus_upload SET status = ? WHERE id = ?");
            ps.setString(1, "Completed");
            ps.setString(2, id);
        } else if ("pending".equals(status)) {
            ps = con.prepareStatement("UPDATE syllabus_upload SET status = ?, reason = ? WHERE id = ?");
            ps.setString(1, "Pending");
            ps.setString(2, reason);
            ps.setString(3, id);
        }

        int rowsUpdated = ps.executeUpdate();
        if (rowsUpdated > 0) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        response.getWriter().write("failure");
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
