package com.student.example;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
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
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ApplyLeaveServlet")
public class ApplyLeaveServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String reason = request.getParameter("reason");

        // Retrieve user information from the session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        PrintWriter out =response.getWriter();
        // Convert date strings to Date objects
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate;
        Date endDate;
        try {
            startDate = dateFormat.parse(startDateStr);
            endDate = dateFormat.parse(endDateStr);
        } catch (ParseException e) {
            // Handle date parsing error
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        // Calculate the number of days between start and end dates
        long diffInMillies = Math.abs(endDate.getTime() - startDate.getTime());
        int leaveDays = (int) ((diffInMillies / (24 * 60 * 60 * 1000)) + 1);

        // MongoDB connection details
        String connectionString = "MongoDB connection URL";
        String databaseName = "LMS";
        String leavesCollectionName = "leaves";
        String employeeCollectionName = "employee"; // Collection name is the username

        try (MongoClient mongoClient = MongoClients.create(connectionString)) {
            // Connect to the "LMS" database
            MongoDatabase database = mongoClient.getDatabase(databaseName);

            // Get the "leaves" collection
            MongoCollection<Document> leavesCollection = database.getCollection(leavesCollectionName);

            // Create a new leave document
            Document leaveDocument = new Document()
                    .append("username", username)
                    .append("startDate", startDate)
                    .append("endDate", endDate)
                    .append("leaveDays", leaveDays) // Added total leave days
                    .append("reason", reason)
                    .append("status", "applied")
                    .append("applicationDate", new Date());

            // Insert the leave document into the "leaves" collection
            leavesCollection.insertOne(leaveDocument);

            // Get the "employee" collection
            MongoCollection<Document> employeeCollection = database.getCollection(employeeCollectionName);

            // Update the employee's leave count
            Document filter = new Document("username", username);
            Document update = new Document("$inc", new Document("leaves", -leaveDays));
            employeeCollection.updateOne(filter, update);

         // Get the updated leave count after applying leave
            long updatedLeaveCountLong = (Long) employeeCollection.find(filter).first().get("leaves");

            // Convert the leave count from Long to int
            int updatedLeaveCount = (int) updatedLeaveCountLong;

            // Set the updated leave count in the request attribute
            request.setAttribute("updatedLeaveCount", updatedLeaveCount);


            // Redirect to a success page or display a success message
//            request.getRequestDispatcher("success.jsp").forward(request, response);
            out.println("<script>");
            out.println("alert('Appplied for leave successfully');");
            out.println("</script>");
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();

            // Redirect to an error page or display an error message
            
        }
    }
}
