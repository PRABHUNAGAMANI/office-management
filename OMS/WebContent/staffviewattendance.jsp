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
        ps = con.prepareStatement("SELECT * FROM studentattendance WHERE username=? AND role=?");
        ps.setString(1, username);
        ps.setString(2, role);
        
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
        // Get the search input value (attendance date)
        var searchInput = document.getElementById('searchInput').value;

        // Check if a date is entered
        if (!searchInput) {
            return;  // If the input is empty, return without doing anything
        }

        // Get the table
        var table = document.querySelector('table');
        
        // Get all table rows
        var rows = table.getElementsByTagName('tr');
        
        // Loop through all rows, and hide the ones that don't match the search query
        for (var i = 1; i < rows.length; i++) {  // Start from 1 to skip the table header row
            var row = rows[i];
            var cells = row.getElementsByTagName('td');
            var attendanceDate = cells[3].textContent.trim();  // Assuming attendance date is in the 4th column (index 3)

            // Check if the attendance date matches the search input
            if (attendanceDate.indexOf(searchInput) > -1) {
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
           <!--  <li><a href="#">
                <i class="uil uil-estate"></i>
                <span class="link-name">HOME</span>
            </a></li> -->
            
            <li><a href="javascript:void(0);" onclick="redirectToHomePage()">
    <i class="uil uil-estate"></i>
    <span class="link-name">HOME PAGE</span>
</a></li>
            
            
            <li><a href="#">
               <i class="uil uil-user"></i>
                <span class="link-name">PROFILE</span>
            </a></li>
            <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="viewstaffattendance.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">STAFF LEAVE REQUEST</span>
            </a></li>
           <!--  <li><a href="viewstaffleaveform.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">LEAVE REPORT</span>
            </a></li> -->
            
            <li><a href="viewstudentattendance.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">STUDENT LEAVE REPORT</span>
            </a></li>
            
           <!--  <li><a href="viewstaffleaveform.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">LEAVE REPORT</span>
            </a></li> -->
            
            <li><a href="enquiryForm.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            
            <li><a href="viewenquiryform.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">ENQUIRY REPORT</span>
            </a></li>
            
            
             <li><a href="#">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">ONLINE TEST</span>
            </a></li> 
           <!--  <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li> -->
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
                <span class="text"><%= role.toUpperCase() + " ATTENDANCE REPORT" %></span>
            </div>

           <!--  <div class="boxes">
                 <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text"> STUDENT ATTENDANCE REPORT</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewstudentattendance.jsp'">Click</button>
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
                    <span class="text">STAFF ATTENDANCE REPORT</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewstaffattendance.jsp'">Click</button>
                </div>
            </div> -->
            
           
        </div>
    </div>
    
    
    
    
    
       <h2><%= username.toUpperCase() + " ATTENDANCE REPORT" %></h2> 
    
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
                <th>WEEKLY TOTAL HOURS</th>
                 <th>MONTHLY TOTAL HOURS</th>
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
                    String weeklytotalhours=rs.getString(8);
                    String monthlytotalhours=rs.getString(9);
            %>
                <tr>
                    <td><%= id %></td>
                    <td><%= userName %></td>
                    <td><%= Role %></td>
                    <td><%= attendancedate %></td>
                    <td><%= checkintime %></td>
                    <td><%= checkouttime %></td>
                    <td><%= totalhours %></td>
                    <td><%= weeklytotalhours %></td>
                    <td><%= monthlytotalhours %></td>
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