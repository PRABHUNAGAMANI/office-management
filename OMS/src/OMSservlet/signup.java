package OMSservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class signup
 */
@WebServlet("/signup")
public class signup extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public signup() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("signemail");
        String username = request.getParameter("signupusername");
        String password = request.getParameter("signpassword");
        String confirmpassword = request.getParameter("signconfirmpassword");
        String role = request.getParameter("signuprole"); // Get the role

        // Check if username is already registered for the same role
        if (isUsernameRegistered(username, role)) {
            pw.print("<script>alert('Username is already taken for this role! Please choose a different username.'); window.location='signup.html';</script>");
            return; // Stop further processing
        }

        // Proceed with registration if no duplicate username
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
                 PreparedStatement ps = con.prepareStatement("INSERT INTO signup (email, username, password, confirmpassword, role) VALUES (?,?,?,?,?)")) {

                ps.setString(1, email);
                ps.setString(2, username);
                ps.setString(3, password);
                ps.setString(4, confirmpassword);
                ps.setString(5, role);

                int i = ps.executeUpdate();
                if (i != 0) {
                    pw.print("<script>alert('Record added successfully!'); window.location='signup.html';</script>");
                } else {
                    pw.print("<script>alert('Record not added'); window.location='signup.html';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    // Method to check if username is already registered for the same role
    private boolean isUsernameRegistered(String username, String role) {
        boolean isRegistered = false;
        try {
            // Ensure the correct database credentials
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
                 PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM signup WHERE username = ? AND role = ?")) {

                ps.setString(1, username);
                ps.setString(2, role);

                // Execute query and check the result
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    // If count > 0, it means the username exists for the given role
                    isRegistered = rs.getInt(1) > 0;
                }
                rs.close();  // Close the result set
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return isRegistered;
    }
}
