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
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public login() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String username = request.getParameter("loginusername");
        String password = request.getParameter("loginpassword");
        String role = request.getParameter("loginrole"); // Get the role

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM signup WHERE username=? AND password=? AND role=?")) {

                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, role);

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    // Create a session for the user and store the username
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username); // Store the username in session
                    session.setAttribute("role", role); // Store the role in session

                    // Redirect based on user role
                    if ("student".equalsIgnoreCase(role)) 
                    {
                        response.sendRedirect("studenthome.jsp");
                    } 
                    else if ("staff".equalsIgnoreCase(role)) 
                    {
                        response.sendRedirect("staffhome.jsp");
                    }
                    else if("Admin".equalsIgnoreCase(role))
                    {
                    	response.sendRedirect("adminhome.jsp");
                    }
                    else 
                    {
                        pw.println("<script>alert('Unknown role!'); window.location.href='signup.html';</script>");
                    }
                }
                else 
                {
                    pw.println("<script>alert('Invalid credentials!'); window.location.href='signup.html';</script>");
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Simple validation - check username and password
//        if ("admin".equals(username) && "password".equals(password)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);  // Store username in session
//            response.sendRedirect("attendanceForm.jsp");  // Redirect to the attendance form page
//        } else {
//            response.sendRedirect("login.jsp");  // Redirect back to login page on failure
//        }
    }
}
