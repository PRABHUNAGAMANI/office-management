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

/**
 * Servlet implementation class viewattendance
 */
@WebServlet("/viewattendance")
public class viewattendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewattendance() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	
	{
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

        try 
        {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 try 
			 {
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
				 PreparedStatement ps = con.prepareStatement("SELECT * FROM studentattendance where username=? and role=?");
	                
				 ps.setString(1,username);
				 ps.setString(2, role);
				 
	                ResultSet rs = ps.executeQuery();
	                
	                
	                // Start of HTML table
	                pw.print("<html><body>");
	                pw.print("<h2>STUDENT ATTENDANCE DETAILS</h2>");
	                pw.print("<table border='1' cellpadding='5' cellspacing='0'>");
	                pw.print("<tr><th>STUDENT ID</th><th>USERNAME</th><th>ROLE</th><th>ATTENDANCE_DATE</th><th>CHECKIN_TIME</th><th>CHECKOUT_TIME</th><th>TOTAL_HOURS</th></tr>");
	                
	                // Fetch and display data in table rows
	                while (rs.next()) {
	                    String id = rs.getString(1);
	                    String userName = rs.getString(2);
	                    String Role = rs.getString(3);
	                    String attendancedate = rs.getString(4);
	                    String checkintime = rs.getString(5);
	                    String checkouttime = rs.getString(6);
	                    String totalhours = rs.getString(7);
	                  
	                    
	                    
	                    pw.print("<tr>");
	                    pw.print("<td>" + id + "</td>");
	                    pw.print("<td>" + username + "</td>");
	                    pw.print("<td>" + role + "</td>");
	                    pw.print("<td>" + attendancedate + "</td>");
	                    pw.print("<td>" + checkintime + "</td>");
	                    pw.print("<td>" + checkouttime + "</td>");
	                    pw.print("<td>" + totalhours + "</td>");
	                    
	                    
	                    pw.print("</tr>");
	                }
	                
	                // End of table and HTML page
	                pw.print("</table>");
	                // Add Back Button with styles
	                pw.print("<form action='staffhome.jsp' method='get' style='margin-top: 20px;'>"); // Add margin-top for spacing
	                pw.print("<input type='submit' value='Back' style='padding: 15px 30px; font-size: 16px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;'/>");
	                pw.print("</form>");
	                pw.print("</body></html>");
	                
	                
			}
			 catch (SQLException e) 
			 {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
        catch (ClassNotFoundException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        
        
    
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
