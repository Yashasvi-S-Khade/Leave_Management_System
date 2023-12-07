package com.student.example;
//
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user input from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // MongoDB Atlas connection information
        String connectionString = "MongoDB connection URL";
        String databaseName = "LMS";
        String collectionName = "employee";

        try (MongoClient mongoClient = MongoClients.create(connectionString)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);

            // Create a query to find a document with the provided username and password
            Document query = new Document("username", username)
                    .append("password", password);

            // Check if a document with the provided credentials exists
            Document result = collection.find(query).first();

            if (result != null) {
                // Authentication successful

                // Store user information in the session
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("password", password);
             

                // Add debug statements
                System.out.println("Debug: Username in session: " + session.getAttribute("username"));
                System.out.println("Debug: Password in session: " + session.getAttribute("password"));


                // Forward to different pages based on the username
                if ("admin".equals(username)) {
                    // Redirect to adminhome.jsp
                    response.sendRedirect(request.getContextPath() + "/adminhome.jsp");
                 
                } else {
                    // Redirect to home.jsp
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                 
                }
            } else {
                // Authentication failed, redirect back to the login page
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }
}

