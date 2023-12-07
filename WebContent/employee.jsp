<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.bson.Document" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MongoDB Data Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/background1.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
        }

        .container {
            max-width: 80%;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
  <h1>Employees</h1>
    <%
       
        // Set up MongoDB connection
        MongoClient mongoClient = MongoClients.create("MongoDB connection URL");
        MongoDatabase database = mongoClient.getDatabase("LMS");
        MongoCollection<Document> collection = database.getCollection("employee");

        // Fetch all documents from the collection
        List<Document> employees = new ArrayList<>();
        collection.find().iterator().forEachRemaining(employees::add);
    %>

    <table>
        <thead>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Email</th>
                <th>Position</th>
                <th>Date of Joining</th>
                <th>Date of Birth</th>
                <th>Salary</th>
            </tr>
        </thead>
        <tbody>
            <% for (Document employee : employees) { %>
                <tr>
                    <td><%= employee.getString("username") %></td>
                    <td><%= employee.getString("name") %></td>
                    <td><%= employee.getString("email") %></td>
                    <td><%= employee.getString("position") %></td>

                    <td><%= employee.getString("doj") %></td>
                    <td><%= employee.getString("dob") %></td>
                    <td><%= employee.getDouble("salary") %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <%
        // Close MongoDB connection
        mongoClient.close();
    %>
</div>

</body>
</html>
