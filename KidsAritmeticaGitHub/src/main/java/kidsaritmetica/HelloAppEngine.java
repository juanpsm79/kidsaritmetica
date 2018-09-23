package kidsaritmetica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
      
	  Map<String, String> options = new LinkedHashMap<>();
	    options.put("value1", "label1");
	    options.put("value2", "label2");
	    options.put("value3", "label3");
	   
	    String conn = getConnection();

	    response.setContentType("application/json");
	    response.getWriter().write("{\"tablas\": \""+conn+"\", \"nivel\": \""+request.getParameter("nivel")+"\", \"errorMessage\": \"un error cualquiera\"}");
  }

	private String getConnection() {
		
	    String instanceConnectionName = "kidsaritmetica:europe-west1:kidsaritmetica";

	    // TODO: fill this in
	    // The database from which to list tables.
	    String databaseName = "kidsaritmetica";

	    String username = "juanpsm79";

	    // TODO: fill this in
	    // This is the password that was set via the Cloud Console or empty if never set
	    // (not recommended).
	    String password = "5326juan3738";

	   

	    //[START doc-example]
	    String jdbcUrl = String.format(
	        "jdbc:mysql://google/%s?cloudSqlInstance=%s"
	            + "&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
	        databaseName,
	        instanceConnectionName);
	 
	    
	   //[END doc-example]
	    Connection connection = null;
		try {
			connection = DriverManager.getConnection(jdbcUrl, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
			return e.getMessage();
		}
		StringBuilder tablas = new StringBuilder("cocoa");
	    try (Statement statement = connection.createStatement()) {
	      ResultSet resultSet = statement.executeQuery("SHOW TABLES");
	      while (resultSet.next()) {
	    	  tablas.append(resultSet.getString(1));
	      }
	    } catch(Exception ex) {
	    	ex.printStackTrace();
	    	return ex.getMessage();
	    }
		return tablas.toString();
	}
}