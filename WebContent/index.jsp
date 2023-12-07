<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/background1.jpg'); /* replace with your image path */
            background-size: cover;
            margin: 0;
            padding: 0;
        }
        
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            opacity: 0; /* initially set opacity to 0 */
            animation: fadeIn 1s forwards; /* fade-in animation */
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        
        h2 {
            color: #333;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }
        
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }
        
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        
        .title {
            color: #fff;
            font-size: 60px;
            margin-top: 50px;
        }
    </style>

    <script>
        // Wait for the DOM to be ready
        document.addEventListener('DOMContentLoaded', function() {
            // Delay the form display by 2 seconds
            setTimeout(function() {
                document.getElementById('login-container').style.display = 'block';
            }, 2000);
        });
    </script>
</head>
<body>
    <div class="login-container" id="login-container" style="display: none;">
        <h1>Welcome to Leave Management System!</h1>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>

            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>