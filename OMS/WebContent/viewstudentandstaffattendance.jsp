<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
     // Get the current session or create a new one if it doesn't exist
     String username = null;  
    String role = null; 

    // Use the implicit 'session' object to retrieve session data
     if (session != null) { 
          username = (String) session.getAttribute("username");    // Retrieve the 'username' from session
         role = (String) session.getAttribute("role");  // Retrieve the 'role' from session
    } 

     if (username == null || role == null) { 
        // If there is no username or role in session (user is not logged in), redirect to login page
         response.sendRedirect("login.html");
    }  
    

    // Database connection and data retrieval
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        ps = con.prepareStatement("SELECT * FROM studentattendance WHERE role='student' and role='staff'");
      /*   ps.setString(1, username);  */
        /* ps.setString(1, role); */
        
        rs = ps.executeQuery();
%>
    


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Link to CSS -->
    <link rel="stylesheet" href="CSS/studenthome.css">
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>STUDENT DASHBOARD PANEL</title>
    
     <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type='submit'] {
            padding: 15px 30px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type='submit']:hover {
            background-color: #45a049;
        }
    </style>
    
</head>
<body>

<nav>
    <div class="logo-name">
        <div class="logo-image">
            <img src="CSS/logo.png" alt="">
        </div>
        <span class="logo_name">OMS</span>
    </div>

    <div class="menu-items">
        <ul class="nav-links">
            <li><a href="#">
                <i class="uil uil-estate"></i>
                <span class="link-name">STUDENT DASHBOARD PANEL</span>
            </a></li>
            <li><a href="#">
               <i class="uil uil-user"></i>
                <span class="link-name">PROFILE</span>
            </a></li>
            <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="#">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">LEAVE REQUEST</span>
            </a></li>
            <li><a href="#">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">ONLINE TEST</span>
            </a></li>
            <li><a href="#">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">RESUME</span>
            </a></li>
            <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li>
        </ul>
        
        <ul class="logout-mode">
            <li><a href="logout">
                <i class="uil uil-signout"></i>
                <span class="link-name">Logout</span>
            </a></li>

            <li class="mode">
                <a href="#">
                    <i class="uil uil-moon"></i>
                <span class="link-name">Dark Mode</span>
            </a>

            <div class="mode-toggle">
              <span class="switch"></span>
            </div>
        </li>
        </ul>
    </div>
</nav>

<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>

        <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div>
        
        <!-- Profile Picture and Name -->
        <div class="profile">
            <img src="CSS/studentprofile.jpg" alt="User Profile">
            <div class="profile-info">
                 <span class="profile-name"><%= username %></span>   <!-- Display the username stored in session -->
                 <span class="profile-role">(<%= role %>)</span>   <!-- Display the role stored in session -->
            </div>
        </div>
    </div>

    <div class="dash-content">
        <div class="overview">
            <div class="title">
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">STUDENT AATENDANCE REPORT</span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">STAFF PROFILE</span>
                    <button type="submit" class="btn">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">STAFF HOME PAGE</span>
    <button type="button" class="btn" onclick="window.location.href='studenthome.jsp'">Click</button>
</div>

                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">LEAVE REQUEST</span>
                    <button type="submit" class="btn">Click</button>
                </div>
            </div>
            
           
        </div>
    </div>
    
    
      <h2>ALL STUDENTS ATTENDANCE DETAILS</h2>
    
    <table>
        <thead>
            <tr>
                <th>STUDENT ID</th>
                <th>USERNAME</th>
                <th>ROLE</th>
                <th>ATTENDANCE DATE</th>
                <th>CHECK-IN TIME</th>
                <th>CHECK-OUT TIME</th>
                <th>TOTAL HOURS</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch and display data in table rows
                while (rs.next()) {
                    String id = rs.getString(1);
                    String userName = rs.getString(2);
                    String Role = rs.getString(3);
                    String attendancedate = rs.getString(4);
                    String checkintime = rs.getString(5);
                    String checkouttime = rs.getString(6);
                    String totalhours = rs.getString(7);
            %>
                <tr>
                    <td><%= id %></td>
                    <td><%= userName %></td>
                    <td><%= Role %></td>
                    <td><%= attendancedate %></td>
                    <td><%= checkintime %></td>
                    <td><%= checkouttime %></td>
                    <td><%= totalhours %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

   <!--  <form action="staffhome.jsp" method="get" style="margin-top: 20px;">
        <input type="submit" value="Back"/>
    </form> -->
    
</section>

<script src="studenthome.js"></script>

</body>
</html>
<%
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>