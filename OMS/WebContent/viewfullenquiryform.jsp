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
           ps = con.prepareStatement("SELECT * FROM eFormInsert"); 
        
        rs = ps.executeQuery(); 
        
        
       
        
        
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Link to CSS -->
    <!-- <link rel="stylesheet" href="CSS/studenthome.css"> -->
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>STUDENT DASHBOARD PANEL</title>
    
    <style>
    
/* General Reset and Layout */
body, html {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    height: 100%; /* Ensure the body takes full height */
    overflow: hidden; /* Prevent scrolling */
}

h2 {
    text-align: center;
    margin-top: 20px;
    margin-bottom: 10px; /* Add space between h2 and table */
}

/* Centering the table container */
.table-container {
    display: flex;
    justify-content: flex-start; /* Horizontally center the table */
    align-items: flex-start; /* Vertically center the table */
    height: 100vh; /* Use full viewport height */
    overflow: auto; /* Allow internal scroll within the table container if necessary */
}

/* Table Styling */
table {
    width: 100%; /* Ensure the table fits the full width of the screen */
    table-layout: auto; /* Automatically adjust column width based on content */
    border-collapse: collapse; /* Merge borders */
}

th, td {
    padding: 8px; /* Add space inside table cells */
    text-align: left;
    border: 1px solid #ddd; /* Add light border for clarity */
    word-wrap: break-word; /* Ensure text fits inside cells */
}

th {
    background-color: #f2f2f2; /* Light grey background for headers */
}

/* Buttons Styling */
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

/* Update and Delete Button Styling */
.update-btn, .delete-btn {
    padding: 5px 10px;
    margin-bottom: 10px;
    text-decoration: none;
    color: white;
    border-radius: 5px;
}

.update-btn {
    background-color: #4CAF50;
}

.update-btn:hover {
    background-color: #45a049;
}

.delete-btn {
    background-color: #f44336;
}

.delete-btn:hover {
    background-color: #da190b;
}

/* Add some padding around the table */
table {
    margin: 0 auto;
    margin-top: 30px;
}

/* Make the table responsive to small screens */
@media (max-width: 768px) {
    table {
        font-size: 12px; /* Reduce font size for smaller screens */
    }

    th, td {
        padding: 5px;
    }
}


/* Style for the footer links at the bottom-left */
.footer-links {
    position: fixed;
    bottom: 30px; /* Distance from the bottom of the page */
    left: 10px; /* Distance from the left of the page */
    font-size: 14px;
    color: #333;
}

.footer-link {
    text-decoration: none;
    color: #4CAF50; /* Green color for the links */
    padding: 5px;
}

.footer-link:hover {
    color: #45a049; /* Slightly darker green on hover */
}


</style>

        
</head>
<body>

      <h2>ENQUIRY REPORT</h2>
    <div class="table-container">
   
    <table>
     
        <thead>
            <tr>
                <th>ID</th> 
                <th>ADMIN NAME</th>
                <th>FORMID</th>
                <th>FULLNAME</th>
                 <th>GENDER</th>
                <th>MOBILE NUMBER</th>
                 <th>ALTERNATE MOBILE NUMBER</th> 
                <th>EMAIL</th>
                 <th>EDUCATION</th>
                <th>PASSED OUT YEAR</th>
                <!--  <th>STREET</th>  -->
                <th>CITY</th>
                <th>STATE</th>
                <th>CURRENT LIVING CITY</th> 
                <th>COURSE NAME</th>
                 <th>WORKING STATUS</th>  
                <!-- <th>NUMBER OF ATTEMPTS</th>
                <th>REASONS</th>
                <th>STUDENT STATUS</th> -->
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch and display data in table rows
                while (rs.next()) {
                     String id = rs.getString(1); 
                    String adminname = rs.getString(2);
                    String formid = rs.getString(3);
                    String fullname = rs.getString(4);
                     String gender = rs.getString(5); 
                    String mobilenumber = rs.getString(6);
                    String alternatemobilenumber = rs.getString(7); 
                    String email=rs.getString(8);
                     String education=rs.getString(9);
                    String passedoutyear = rs.getString(10);
                    /*  String street = rs.getString(11);  */
                    String city = rs.getString(12);
                    String state = rs.getString(13);
                    String currentlivingcity = rs.getString(14);  
                    String coursename = rs.getString(15);
                     String workingstatus = rs.getString(16);  
            %>
                <tr>
                    <td><%= id %></td> 
                    <td><%= adminname %></td>
                    <td><%= formid %></td>
                    <td><%= fullname %></td>
                    <td><%= gender %></td>
                    <td><%= mobilenumber %></td>
                    <td><%= alternatemobilenumber %></td>
                    <td><%= email %></td>
                    <td><%= education %></td>
                    <td><%= passedoutyear %></td>
                   <%--  <td><%= street %></td>  --%>
                    <td><%= city %></td>
                    <td><%= state %></td>
                    <td><%= currentlivingcity %></td> 
                    <td><%= coursename %></td>
                    <td><%= workingstatus %></td> 
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    
    </div>
    
    
    <!-- Footer with links -->
    <div class="footer-links">
        <a href="signup.html" class="footer-link">LOGOUT</a> | 
        <a href="adminhome.jsp" class="footer-link">ADMIN HOME PAGE</a>
    </div>

</body>

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

 
 
 
<%--  <%@ page import="javax.servlet.http.HttpSession" %>
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
        
        // SQL query to get selected columns from both eFormInsert and attempts table
        String query = "SELECT e.id AS eform_id, e.attendPersonName, e.formID, e.fullName, e.mobileNumber, e.email, e.courseName, " +
                       "a.attempt_number, a.reason, a.student_status " +
                       "FROM eFormInsert e " +
                       "JOIN attempts a ON e.id = a.eform_id";

        // Create the PreparedStatement
        ps = con.prepareStatement(query);

        // Execute the query
        rs = ps.executeQuery();
        
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>ENQUIRY REPORT</title>
    
    <style>
        /* General Reset and Layout */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
        }

        /* Table Styling */
        table {
            width: 60%; /* Ensure the table fits the full width of the screen */
            table-layout: auto; /* Automatically adjust column width based on content */
            border-collapse: collapse; /* Merge borders */
        }

        th, td {
            padding: 8px; /* Add space inside table cells */
            text-align: left;
            border: 1px solid #ddd; /* Add light border for clarity */
            word-wrap: break-word; /* Ensure text fits inside cells */
        }

        th {
            background-color: #f2f2f2; /* Light grey background for headers */
        }

        /* Buttons Styling */
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

        /* Update and Delete Button Styling */
        .update-btn, .delete-btn {
            padding: 5px 10px;
            margin-bottom: 10px;
            text-decoration: none;
            color: white;
            border-radius: 5px;
        }

        .update-btn {
            background-color: #4CAF50;
        }

        .update-btn:hover {
            background-color: #45a049;
        }

        .delete-btn {
            background-color: #f44336;
        }

        .delete-btn:hover {
            background-color: #da190b;
        }

        /* Add some padding around the table */
        table {
            margin: 0 auto;
            margin-top: 30px;
        }

        /* Make the table responsive to small screens */
        @media (max-width: 768px) {
            table {
                font-size: 12px; /* Reduce font size for smaller screens */
            }

            th, td {
                padding: 5px;
            }
        }
    </style>
        
</head>
<body>

    <h2>ENQUIRY REPORT</h2>
    
    <table>
        <thead>
            <tr>
                <th>ID</th> 
                <th>ADMIN NAME</th>
                <th>FORMID</th>
                <th>FULLNAME</th>
                <th>MOBILE NUMBER</th>
                <th>EMAIL</th>
                <th>COURSE NAME</th>
                <th>NUMBER OF ATTEMPTS</th>
                <th>REASONS</th>
                <th>STUDENT STATUS</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch and display data in table rows
                while (rs.next()) {
                    String id = rs.getString("eform_id"); 
                    String adminname = rs.getString("attendPersonName");
                    String formid = rs.getString("formID");
                    String fullname = rs.getString("fullName");
                    String mobilenumber = rs.getString("mobileNumber");
                    String email = rs.getString("email");
                    String coursename = rs.getString("courseName");
                    int attemptNumber = rs.getInt("attempt_number");
                    String reason = rs.getString("reason");
                    String studentStatus = rs.getString("student_status");
            %>
                <tr>
                    <td><%= id %></td> 
                    <td><%= adminname %></td>
                    <td><%= formid %></td>
                    <td><%= fullname %></td>
                    <td><%= mobilenumber %></td>
                    <td><%= email %></td>
                    <td><%= coursename %></td>
                    <td><%= attemptNumber %></td>
                    <td><%= reason %></td>
                    <td><%= studentStatus %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

</body>
</html>

<%
    } catch (ClassNotFoundException | SQLException e) {
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
  --%>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 