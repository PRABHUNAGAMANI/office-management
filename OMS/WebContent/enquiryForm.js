/*----------------Form validation start----------------------------------------------------------------------->*/

function formValidation() {
	let form = document.enquiryForm1;

	// Validate Enquiry Attend Person Name
	if (form.attendPersonName.value.trim() === "") {
		alert("Enter Enquiry Attend Person Name");
		form.attendPersonName.focus();
		return false;
	}

	// Validate Enquiry Form ID
	if (form.formID.value.trim() === "") {
		alert("Enter Enquiry Form ID");
		form.formID.focus();
		return false;
	}

	// Validate Full Name
	if (form.fullName.value.trim() === "") {
		alert("Enter your Full Name");
		form.fullName.focus();
		return false;
	}

	// Validate Gender (Dropdown)
	if (form.gender.value === "" || form.gender.value === "Select gender") {
		alert("Select Gender");
		form.gender.focus();
		return false;
	}

	// Validate Mobile Number
	let mobilePattern = /^[6-9]\d{9}$/; // Indian 10-digit mobile number pattern starting with 6-9
	if (form.mobileNumber.value.trim() === "") {
		alert("Enter Mobile Number");
		form.mobileNumber.focus();
		return false;
	} else if (!mobilePattern.test(form.mobileNumber.value)) {
		alert("Enter a valid Mobile Number");
		form.mobileNumber.focus();
		return false;
	}

	// Validate Alternate Mobile Number
	if (form.alternateMobileNumber.value.trim() !== "" && !mobilePattern.test(form.alternateMobileNumber.value)) {
		alert("Enter a valid Alternate Mobile Number");
		form.alternateMobileNumber.focus();
		return false;
	}

	// Validate Email
	let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	if (form.email.value.trim() === "") {
		alert("Enter your Email");
		form.email.focus();
		return false;
	} else if (!emailPattern.test(form.email.value)) {
		alert("Enter a valid Email");
		form.email.focus();
		return false;
	}

	// Validate Education (Dropdown)
	if (form.education.value === "" || form.education.value === "Select Highest Education") {
		alert("Select Highest Education");
		form.education.focus();
		return false;
	}

	// Validate Year of Passed Out
	if (form.passedOutYear.value.trim() === "") {
		alert("Enter Year of Passed Out");
		form.passedOutYear.focus();
		return false;
	}

	// Validate Street
	if (form.street.value.trim() === "") {
		alert("Enter Street Name");
		form.street.focus();
		return false;
	}

	// Validate City
	if (form.city.value.trim() === "") {
		alert("Enter City Name");
		form.city.focus();
		return false;
	}

	// Validate State
	if (form.state.value.trim() === "") {
		alert("Enter State Name");
		form.state.focus();
		return false;
	}

	// Validate Current Living City
	if (form.currentLivingCity.value.trim() === "") {
		alert("Enter Current Living City Name");
		form.currentLivingCity.focus();
		return false;
	}

	// Validate Enquiry Course Name (Dropdown)
	if (form.courseName.value === "" || form.courseName.value === "Select Enquiry Course Name") {
		alert("Select Enquiry Course Name");
		form.courseName.focus();
		return false;
	}

	// Validate Working Status (Dropdown)
	if (form.workingStatus.value === "" || form.workingStatus.value === "Select Working Status") {
		alert("Select Working Status");
		form.workingStatus.focus();
		return false;
	}

	return true; // If all validations pass
}


/*------------------------Form validation finish----------------------------------------------------------------------->*/


 /*----------------------JavaScript function to fetch the next available user ID from the server----------------------*/
 
 function fetchFormId() {
         fetch('getFormId.jsp')
             .then(response => {
                 if (!response.ok) {
                     throw new Error('Network response was not ok');
                 }
                 return response.text(); // Expect the form ID as plain text
             })
             .then(formID => {
                 document.getElementById('formID').value = formID.trim(); // Trim the fetched form ID
             })
             .catch(error => {
                 console.error('Error fetching form ID:', error);
                 alert('Could not fetch Form ID. Please try again later.');
             });
     }

     window.onload = function() {
         fetchFormId(); // Call the fetch function on page load
     };
 
 
/*----------------------finish JavaScript function to fetch the next available user ID from the server------------*/
