package com.student.example;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
//import com.mongodb.client.model.Filters;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        String employeeName = request.getParameter("employeeName");
        String dob = request.getParameter("dob");
        String doj = request.getParameter("doj");
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));
        int leaves = Integer.parseInt(request.getParameter("leaves"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        PrintWriter out = response.getWriter();
        // Hardcoded default password
        String password = "changeme";

        // MongoDB connection details
        String connectionString = "MongoDB connection URL";
        String databaseName = "LMS";
        String collectionName = "employee";

        try (MongoClient mongoClient = MongoClients.create(connectionString)) {
            // Connect to the "LMS" database
            MongoDatabase database = mongoClient.getDatabase(databaseName);

            // Get the "employee" collection
            MongoCollection<Document> collection = database.getCollection(collectionName);

            // Create a new employee document
            Document employee = new Document()
                    .append("name", employeeName)
                    .append("dob", dob)
                    .append("doj", doj)
                    .append("position", position)
                    .append("salary", salary)
                    .append("leaves", leaves)
                    .append("username", username)
                    .append("email", email)
                    .append("password", password);

            // Insert the document into the collection
            collection.insertOne(employee);
            
            

            // Redirect to a success page or display a success message
//            response.sendRedirect("employee.jsp");
            out.println("<script>");
            out.println("alert('Employee added successfully');");
            out.println("window.location.href='addEmployee.jsp';");
            out.println("</script>");
            
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();

            // Redirect to an error page or dispout.println("<script>");
            out.println("alert('Error');");
            out.println("window.location.href='addEmployee.jsp';");
            out.println("</script>");response.sendRedirect("error.jsp");
        }
    }
}
