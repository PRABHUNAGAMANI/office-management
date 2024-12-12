package OMSservlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class forgotpassword
 */
@WebServlet("/forgotpassword")
public class forgotpassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgotpassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		
//		    String email = request.getParameter("forgotemail");
		    String username = request.getParameter("forgotusername");
	        String password = request.getParameter("forgotpassword");
	        String confirmpassword = request.getParameter("forgotconfirmpassword");
	        String role = request.getParameter("forgotrole"); // Get the role
		
		
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			try 
			{
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
				PreparedStatement ps = con.prepareStatement("update signup set password=?,confirmpassword=? where username=? and role=?"); 
				
				ps.setString(1, password);
				ps.setString(2, confirmpassword);
				ps.setString(3, username);
				ps.setString(4, role);
				
				int i = ps.executeUpdate();
                if (i != 0) 
                {
                    pw.println("<script> alert('record updated successfully'); window.location.href='signup.html';</script>");
                } 
                else 
                {
                	 pw.println("<script> alert('record updated failed'); window.location.href='signup.html';</script>");
                }
				
				
				
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
