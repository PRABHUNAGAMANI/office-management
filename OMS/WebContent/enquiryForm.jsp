<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/enquiryForm.css">
    <title>Enquiry Registration Form</title>
    <script src="enquiryForm.js"></script>
    <style type="text/css">
        /* --------------------------------------Style the submit button */
        .input-field.button input[type="submit"] {
            background-color: #4CBB17; /* Change background color to blue */
            color: white; /* Change text color to white */
            border: none; /* Remove default border */
            padding: 10px 20px; /* Add some padding */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Change cursor to pointer (hand symbol) */
            font-size: 16px; /* Increase font size */
            transition: background-color 0.3s; /* Smooth transition for hover effect */
        }

        /* Change background color on hover */
        .input-field.button input[type="submit"]:hover {
            background-color: #89CFF0; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <header>Enquiry Form</header>

        <form action="eFormInsert.jsp" method="post" name="enquiryForm1" onsubmit="return formValidation();">

            <div class="form first">
                <div class="fields">
                    <div class="input-field">
                        <label>Enquiry Attend Person Name</label>
                        <input type="text" name="attendPersonName" value="<%=session.getAttribute("username") != null ? session.getAttribute("username") : ""%>" placeholder="Enquiry Attend Person Name" readonly style="border: 2px solid green;">
                    </div>

                    <div class="input-field">
                        <label>Enquiry Form ID</label>
                        <input type="number" name="formID" id="formID" placeholder="Enquiry Form ID" readonly style="border: 2px solid green;">
                    </div>

					<div class="input-field">
						<label>Full Name</label> <input type="text" name="fullName"
							placeholder="Enter your name">
					</div>

					<div class="input-field">
						<label>Gender</label> <select name="gender">
							<option disabled selected>Select gender</option>
							<option>Male</option>
							<option>Female</option>
						</select>
					</div>

					<div class="input-field">
						<label>Mobile Number</label> <input type="number"
							name="mobileNumber" placeholder="Enter mobile number">
					</div>

					<div class="input-field">
						<label>Alternate Mobile Number</label> <input type="number"
							name="alternateMobileNumber"
							placeholder="Enter alternate mobile number">
					</div>

					<div class="input-field">
						<label>Email</label> <input type="text" name="email"
							placeholder="Enter your email">
					</div>

					<div class="input-field">
						<label>Highest Education</label> <select name="education">
							<option disabled selected>Select Highest Education</option>
							<option>B.E.EEE</option>
							<option>B.E.COMPUTER SCIENCE</option>
							<option>B.E.MECHANICAL</option>
							<option>BCA</option>
							<option>MCA</option>
							<option>BBA</option>
							<option>MBA</option>
						</select>
					</div>

					<div class="input-field">
						<label>Year of Passed Out</label> <input type="text"
							name="passedOutYear" placeholder="Enter year of passed out">
					</div>

					<div class="input-field">
						<label>Street</label> <input type="text" name="street"
							placeholder="Enter street name">
					</div>

					<div class="input-field">
						<label>City</label> <input type="text" name="city"
							placeholder="Enter city name">
					</div>

					<div class="input-field">
						<label>State</label> <input type="text" name="state"
							placeholder="Enter State name">
					</div>

					<div class="input-field">
						<label>Current Living City</label> <input type="text"
							name="currentLivingCity"
							placeholder="Enter current living city name">
					</div>

					<div class="input-field">
						<label>Enquiry Course Name</label> <select name="courseName">
							<option disabled selected>Select Enquiry Course Name</option>
							<option>Oracle Database</option>
							<option>Java Programming</option>
							<option>Web Development</option>
							<option>Data Science</option>
							<option>Machine Learning</option>
						</select>
					</div>

					<div class="input-field">
						<label>Working Status</label> <select name="workingStatus">
							<option disabled selected>Select Working Status</option>
							<option>Employed</option>
							<option>Unemployed</option>
							<option>Student</option>
						</select>
					</div>

				</div>

				<!-- Submit Button -->
				<div class="input-field button">
					<input type="submit" value="Submit">
				</div>
				
				 
				

			</div>
			<!-- End of form first -->
		</form>
		<!-- End of form -->
	</div>
	<!-- End of container -->
	
	
</body>
</html>