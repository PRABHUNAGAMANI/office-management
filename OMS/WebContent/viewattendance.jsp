<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
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
    
 <style>
.form-container {
    display: flex;
    justify-content: center; /* Center horizontally */
    align-items: center; /* Center vertically if needed */
    height: 100vh; /* Adjust height as necessary */
}

.button-container {
    display: flex;
    gap: 30px; /* Space between buttons */
}

.btn {
    padding: 15px 30px; /* Increase button size */
    font-size: 16px; /* Increase font size for better visibility */
    border: none; /* Remove default border */
    border-radius: 5px; /* Add rounded corners */
    background-color: #4CAF50; /* Change background color */
    color: white; /* Change text color */
    cursor: pointer; /* Change cursor to pointer on hover */
    transition: background-color 0.3s; /* Smooth transition for hover effect */
}

.btn:hover {
    background-color: #45a049; /* Darker shade on hover */
}

.button-container {
    display: flex;
    gap: 30px; /* Space between buttons */
    
}

.btn {
    padding: 15px 30px; /* Increase button size */
    margin-left:20px;
    font-size: 16px; /* Increase font size for better visibility */
    border: none; /* Remove default border */
    border-radius: 5px; /* Add rounded corners */
    background-color: #4CAF50; /* Change background color */
    color: white; /* Change text color */
    cursor: pointer; /* Change cursor to pointer on hover */
    transition: background-color 0.3s; /* Smooth transition for hover effect */
}

.btn:hover {
    background-color: #45a049; /* Darker shade on hover */
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

</script>
    

    <title>STUDENT ATTENDANCE PANEL</title>
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
            <!--  <li><a href="studenthome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name">HOME PAGE</span>
            </a></li>  -->
            
            <li><a href="javascript:void(0);" onclick="redirectToHomePage()">
    <i class="uil uil-estate"></i>
    <span class="link-name">HOME PAGE</span>
</a></li>
            
            <li><a href="#">
               <i class="uil uil-user"></i>
                <span class="link-name">PROFILE</span>
            </a></li>
            <li><a href="leaverequestform.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">LEAVE REQUEST</span>
            </a></li>
            <li><a href="viewstudentleaveform.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">LEAVE REPORT</span>
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
            <li><a href="signup.html">
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

        <!-- <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div> -->
        
        <!-- Profile Picture and Name -->
        <div class="profile">
            <img src="CSS/studentprofile.jpg" alt="User Profile">
            <div class="profile-info">
                <span class="profile-name"><%= username %></span>  <!-- Display the username stored in session -->
                <span class="profile-role">(<%= role %>)</span>  <!-- Display the role stored in session -->
            </div>
        </div>
    </div>
    
    <div class="dash-content">
        <div class="overview">
            <div class="title">
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">STUDENT HOME PAGE</span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">HOME PAGE</span>
                    <button type="submit" class="btn" onclick="window.location.href='studenthome.jsp'">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">STUDENT ATTENDANCE REPORT</span>
    <button type="button" class="btn" onclick="window.location.href='staffviewattendance.jsp'">Click</button>
</div>

                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">LEAVE REQUEST</span>
                    <button type="submit" class="btn" onclick="window.location.href='leaverequestform.jsp'">Click</button>
                </div>
            </div>
            
         
        </div>
    </div>


</section>

<script src="studenthome.js"></script>


</body>
</html>
