<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <script>
        
        function navigateToModule(module) {
            var username = '<%= session.getAttribute("username") %>';
            var password = '<%= session.getAttribute("password") %>';
            
            // Create a form element
            var form = document.createElement('form');
            form.method = 'GET'; // Set the desired HTTP method
            form.style.display = 'none'; // Hide the form
            
            // Create input elements for username and password
            var usernameInput = document.createElement('input');
            usernameInput.type = 'hidden';
            usernameInput.name = 'username';
            usernameInput.value = username;
            
            var passwordInput = document.createElement('input');
            passwordInput.type = 'hidden';
            passwordInput.name = 'password';
            passwordInput.value = password;
            
            // Append input elements to the form
            form.appendChild(usernameInput);
            form.appendChild(passwordInput);
            
            // Append the form to the body
            document.body.appendChild(form);
            
            // Set the action URL based on the selected module
            if (module === 'applyLeave') {
                form.action = 'applyLeave.jsp';
            } else if (module === 'leaveRecordPersonal') {
                form.action = 'leaveRecordPersonal.jsp';
            } else if (module === 'profile') {
                form.action = 'profile.jsp';
            } else if (module === 'logout') {
                form.action = 'LogoutServlet';
            }
            
            // Submit the form
            form.submit();
        }

    </script>
    <style type="text/css">

		body {
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		    background-image: url('images/background1.jpg'); /* Replace with your image path */
		    background-size: cover;
		    background-position: center;
		}
		
		.container {
		    max-width: 400px;
		    height: 500px;
		    margin: 50px auto;
		    background: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
		    padding: 20px;
		    border-radius: 5px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    text-align: center;
		}
		
		h1 {
		    color: #333;
		}
		
		/* Dropdown Styles */
		.dropdown {
		    display: block;
		    width: 100%; /* Set width to 100% */
		    margin-top: 15px;
		    margin-bottom: 15px; /* Add margin for separation */
		}
		
		.dropbtn {
		    background-color: #4caf50;
		    color: white;
		    padding: 10px;
		    font-size: 16px;
		    border: none;
		    cursor: pointer;
		    width: 100%; /* Set width to 100% */
		    margin-bottom: 15px;
		}
		
		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f9f9f9;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
		    z-index: 1;
		}
		
		.dropdown-content a {
		    color: #333;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		.dropdown-content a:hover {
		    background-color: #f1f1f1;
		}
		
		.dropdown:hover .dropdown-content {
		    display: block;
		}
		
		/* Links Styles */
		a {
		    display: block;
		    margin-top: 10px;
		    text-decoration: none;
		    color: #333;
		    padding: 10px;
		    background-color: #4caf50;
		    color: white;
		    border-radius: 5px;
		}
		
		a:hover {
		    background-color: #45a049;
		}
		#debug-info {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }

</style>
</head>
<body>
	<div class="container">
		<h1>Welcome!</h1>
		

	    
	
	    <!-- Links to other modules -->
	    <a href="javascript:void(0);" onclick="navigateToModule('applyLeave')">Apply for Leave</a><br>
	    <a href="javascript:void(0);" onclick="navigateToModule('profile')">Profile</a><br>
	    <a href="javascript:void(0);" onclick="navigateToModule('leaveRecordPersonal')">Leave Record</a><br>
	    <a href="javascript:void(0);" onclick="navigateToModule('logout')">Logout</a>
	</div>
    
</body>
</html>
