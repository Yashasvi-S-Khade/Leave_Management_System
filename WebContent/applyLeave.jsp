<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Leave</title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/background1.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
            color: #fff;
        }

       .container {
    max-width: 400px;
    height: 600px;
    margin: 50px auto;
    background: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
}

        h1 {
            color: #333;
            text-align:center;
        }

        /* Add your specific styles for this page below this line */

h3 {
    color: #333;
    text-align: left;
}

label {
    display: inline-block;
    margin-bottom: 8px;
    color: #333;
    width: 100px; /* Adjust the width as needed */
}


/* Add this style to highlight the Start Date label */

input, textarea {
    width: calc(100% - 120px); /* Adjust the width to leave space for labels */
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
p {
    color: #000;
    text-align: left;
}

    </style>
</head>
<body>
    
        
        <%@ include file="navbar.jsp" %>
		<div class="container">
		<h1 >Apply for Leave</h1>
        <%
            String connectionString = "MongoDB connection URL";
            String databaseName = "LMS";
            String collectionName = "employee";
            String username = (String) session.getAttribute("username");

            try (MongoClient mongoClient = MongoClients.create(connectionString)) {
                MongoDatabase database = mongoClient.getDatabase(databaseName);
                MongoCollection<Document> collection = database.getCollection(collectionName);

                Document query = new Document("username", username);
                List<Document> users = collection.find(query).into(new ArrayList<>());

                for (Document user : users) {
                    // Compare usernames
                    String userUsername = user.getString("username");
                    if (username.equals(userUsername)) {
                        String employeeName = user.getString("name");
                        String email = user.getString("email");
                        String position = user.getString("position");

                        // Use Number class to handle both Integer and Long values
                        Number leavesNumber = (Number) user.get("leaves");
                        long leaves = leavesNumber.longValue();

                        request.setAttribute("employeeName", employeeName);
                        request.setAttribute("email", email);
                        request.setAttribute("position", position);
                        request.setAttribute("leaves", leaves);

                        // Break the loop once a match is found
                        break;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle exceptions as needed
            }
        %>

        <!-- Display user profile information -->
        <h3>Profile Information:</h3>
        <p>Username: <%= session.getAttribute("username") %></p>
        <p>Name: <%= request.getAttribute("employeeName") %></p>
        <p>Email: <%= request.getAttribute("email") %></p>
        <p>Position: <%= request.getAttribute("position") %></p>
        <p>Leaves Remaining: <%= request.getAttribute("leaves") %></p>

        <!-- Display leave application form if leaves are available -->
        <c:if test="${requestScope.leavesAvailable}">
            <h3>Leave Application:</h3>
            <form action="ApplyLeaveServlet" method="post">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required><br>

                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required><br>

                <label for="reason">Reason:</label>
                <textarea id="reason" name="reason" rows="4" cols="50" required></textarea><br>

                <input type="submit" value="Apply">
            </form>
        </c:if>

        <!-- Display message if no leaves are available -->
        <c:if test="${!requestScope.leavesAvailable}">
            
        </c:if>
    </div>
</body>
</html>