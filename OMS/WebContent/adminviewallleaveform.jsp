<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    

    // Database connection and data retrieval
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        ps = con.prepareStatement("SELECT 'Staff' AS user_type, id, username, start_date, end_date, reason, leave_days, approval_status, granted_by FROM staff_leave_requests " +
                "UNION " +
                "SELECT 'Student' AS user_type, id, username, start_date, end_date, reason, leave_days, approval_status, granted_by FROM student_leave_requests");
       /*  ps.setString(1, username); */
       /*  ps.setString(2, role); */
        
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

   <title><%= role.toUpperCase() + " DASHBOARD PANEL" %></title>


    
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
    
   

<script>
    function redirectToHomePage() 
    {
        // Get the user's role from the session (retrieved via JSP)
        var role = '<%= role %>';  // This will contain either 'staff' or 'admin'

        // Redirect based on the user's role
        if (role === 'staff') 
        {
            window.location.href = 'staffhome.jsp';  // Redirect to staff home page
        } 
        else if (role === 'admin') 
        {
            window.location.href = 'adminhome.jsp';  // Redirect to admin home page
        }
        else if(role === 'student')
        {
        	 window.location.href = 'studenthome.jsp';  // Redirect to admin home page
        }
        else 
        {
            alert('Role not found or invalid. Please log in first.');
        }
    }
    
    
   
    function filterTable() {
        // Get the search input value
        var searchInput = document.getElementById('searchInput').value.toLowerCase(); // Convert to lowercase for case-insensitive comparison

        // Get the table and its rows
        var table = document.querySelector('table');
        var rows = table.getElementsByTagName('tr');

        // Loop through all rows, except for the header row (index 0)
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var cells = row.getElementsByTagName('td');

            // Get the username and role column values (assuming they are in columns 2 and 3, respectively)
            var username = cells[1].textContent.toLowerCase();  // Column 2: Username
            var role = cells[2].textContent.toLowerCase();      // Column 3: Role

            // If either username or role matches the search input, display the row
            if (username.indexOf(searchInput) > -1 || role.indexOf(searchInput) > -1) {
                row.style.display = '';  // Show the row
            } else {
                row.style.display = 'none';  // Hide the row
            }
        }
    }


   
    
</script>
    
     
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
            <li><a href="adminhome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name"> HOME PAGE </span>
            </a></li>
            <li><a href="attendance.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="staffviewattendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name"> ADMIN ATTENDANCE</span>
            </a></li>
            <li><a href="viewstaffattendance.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">STAFF ATTENDANCE</span>
            </a></li>
            <li><a href="viewstudentattendance.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">STUDENT ATTENDANCE</span>
            </a></li>
            <li><a href="enquiryForm.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            <li><a href="viewenquiryform.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">ENQUIRY REPORT </span>
            </a></li>
        </ul>
        
        <ul class="logout-mode">
            <li><a href="signup.html">
                <i class="uil uil-signout" style="color: red;"></i>
                <span class="link-name" style="color: red;">Logout</span>
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

     <!--  <div class="search-box">
    <i class="uil uil-search"></i>
    <input type="text" id="searchInput" placeholder="Search by Attendance" />
    <button class="search-btn" type="button" onclick="filterTable()">Search</button>
</div> -->

<div class="search-box">
    <i class="uil uil-search"></i>
    <input type="text" id="searchInput" placeholder="Search by Username or Role" onkeyup="filterTable()"/>
</div>



        
        <!-- Profile Picture and Name -->
        <div class="profile">
            <img src="CSS/studentprofile.jpg" alt="User Profile">
            <div class="profile-info">
                <span class="profile-name"><%= username.toUpperCase() %></span>  <!-- Display the username stored in session -->
                <span class="profile-role">(<%= role.toUpperCase() %>)</span>  <!-- Display the role stored in session -->
            </div>
        </div>
    </div>
    
   

    <div class="dash-content">
        <div class="overview">
            <div class="title">
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text"> ATTENDANCE REPORT</span>
            </div>

           <!--  <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text"> PROFILE</span>
                    <button type="submit" class="btn">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">STAFF HOME PAGE</span>
    <button type="button" class="btn" onclick="window.location.href='staffhome.jsp'">Click</button>
</div>

 
 <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">HOME PAGE</span>
    <button type="button" class="btn" onclick="redirectToHomePage()">Click</button>
</div>
 
 
                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">LEAVE REQUEST</span>
                    <button type="submit" class="btn">Click</button>
                </div>
            </div> -->
            
           
        </div>
    </div>
    
    
    
    
    
      <h2>STUDENT AND STAFF LEAVE REPORT</h2>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
            <th>USERNAME</th>
             <th>ROLE</th>
            <th>STRAT DATE</th>
            <th>END DATE</th>
            <th>REASON</th>
            <th>LEAVE DAYS</th>
            <th>APPROVAL STATUS</th>
            <th>GRANTED BY </th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch and display data in table rows
                while (rs.next()) {
                  /*   String id = rs.getString(1);
                    String userName = rs.getString(2);
                    String startdate = rs.getString(3);
                    String enddate = rs.getString(4);
                    String reason = rs.getString(5);
                    String leavedays = rs.getString(6);
                    String approvalstatus = rs.getString(7);
                    String grantedby = rs.getString(8); */
                    
                    String userType = rs.getString("user_type");  // Correctly fetching the 'user_type' column
                    String id = rs.getString("id");
                    String userName = rs.getString("username");
                   
                    String startdate = rs.getString("start_date");
                    String enddate = rs.getString("end_date");
                    String reason = rs.getString("reason");
                    String leavedays = rs.getString("leave_days");
                    String approvalstatus = rs.getString("approval_status");
                    String grantedby = rs.getString("granted_by");
                   
            %>
                <tr>
                    <td><%= id %></td>
                    <td><%= userName %></td>
                      <td><%= userType %></td>
                    <td><%= startdate %></td>
                    <td><%= enddate %></td>
                    <td><%= reason %></td>
                    <td><%= leavedays %></td>
                    <%-- <td><%= approvalstatus %></td> --%>
                    
                     <td style="color: <%= "Pending".equals(approvalstatus) ? "red" : "green" %>;">
                    <%= approvalstatus %>
                </td>
                    
                    <td><%= grantedby %></td>
                  
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