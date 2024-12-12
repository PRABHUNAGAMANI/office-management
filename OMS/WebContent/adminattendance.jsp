<%@ page import="javax.servlet.http.HttpSession" %>
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

    <title>ADMIN ATTENDANCE PANEL</title>
    
      <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9; / Softer background /
            margin: 0;
            padding: 20px;
        }

        .dropdown-container {
            margin: 40px 0;
            text-align: center;
        }

        label {
            font-size: 22px;
            font-weight: bold;
            color: #5D6D7E; / Neutral dark blue-gray for text /
            margin-bottom: 10px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .dropdown {
            position: relative;
            display: inline-block;
            width: 260px; / Adjusted width for a balanced look /
        }

        .dropbtn {
            background-color: #1abc9c; / Teal background /
            color: white;
            padding: 14px;
            font-size: 18px;
            border: none;
            cursor: pointer;
            border-radius: 12px;
            width: 100%; / Matches dropdown width /
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            transition: background 0.3s, transform 0.2s, box-shadow 0.3s;
        }

        .dropbtn:hover {
            background-color: #16a085; / Darker teal for hover /
            transform: translateY(-3px); / Slight upward motion /
            box-shadow: 0 8px 15px rgba(22, 160, 133, 0.4); / Teal glow effect /
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #ffffff; / Pure white for better contrast /
            width: 100%; / Matches button width /
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
            border-radius: 12px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: #34495E; / Darker blue-gray for text /
            font-weight: 600;
            padding: 14px 18px;
            text-decoration: none;
            display: block;
            border-bottom: 1px solid #ddd; / Light gray border between items /
            transition: background 0.3s, color 0.3s;
        }

        .dropdown-content a:last-child {
            border-bottom: none; / Remove border from last item /
        }

        .dropdown-content a:hover {
            background-color: #ecf9f7; / Very light teal for hover /
            color: #1abc9c; / Matches button base color /
        }

        .dropdown:hover .dropdown-content {
            display: block; / Show dropdown on hover /
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
            <li><a href="adminhome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name">HOME PAGE </span>
            </a></li>
           <!--  <li><a href="staffviewattendance.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name">ATTENDANCE REPORT</span>
            </a></li> -->
            <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="viewstaffattendance.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">STAFF ATTENDANCE </span>
            </a></li>
            <li><a href="viewstudentattendance.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">STUDENT ATTENDANCE </span>
            </a></li>
            <li><a href="enquiryForm.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            <li><a href="viewenquiryform.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">ENQUIRY REPORT</span>
            </a></li>
            
             <li><a href="attempts.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">ENQUIRY FEEDBACK</span>
            </a></li>
            
              <li><a href="viewenquiryreasons.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">ENQUIRY FEEDBACK REASONS</span>
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
            <input type="text" placeholder="Search here...">
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
              <i class="uil uil-calendar-alt"></i>  <!-- Represents a calendar icon -->
                <span class="text"> ATTENDANCE REPORT </span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">STUDENT ATTENDANCE REPORT</span>
                    <button type="button" class="btn" onclick="window.location.href='viewstudentattendance.jsp'">Click</button>
                </div>
                 <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">STAFF ATTENDANCE REPORT</span>
                    <button type="button" class="btn" onclick="window.location.href='viewstaffattendance.jsp'">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text"> ADMIN ATTENDANCE REPORT </span>
    <button type="button" class="btn" onclick="window.location.href='staffviewattendance.jsp'">Click</button>
</div>

              
            </div>
            
            <br><br>
            
          
        </div>
    </div>
    
  <!--  <div class="dropdown-container">
    <label for="attendance">Attendance Report</label>
    <div class="dropdown">
        <button class="dropbtn">Attendance Reports</button>
        <div class="dropdown-content">
            <a href="staffviewattendance.jsp">admin Attendance Report</a>
            <a href="viewstaffattendance.jsp">Staff Attendance Report</a>
             <a href="viewstudentattendance.jsp">student Attendance Report</a>
        </div>
    </div>
</div> -->
    
</section>

<script src="studenthome.js"></script>

</body>
</html>
