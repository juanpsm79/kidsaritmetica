
//STEP 1. Import required packages
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;

public class FirstExample {
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";  
   static final String DB_URL = "jdbc:oracle:thin:@//lorabddvo302:1521/ECODEX";

   //  Database credentials
   static final String USER = "ECODEXINT";
   static final String PASS = "FRIJ135";
   
   public static void main(String[] args) {
   /*Connection conn = null;
   Statement stmt = null;
   try{
      //STEP 2: Register JDBC driver
      Class.forName(JDBC_DRIVER);

      //STEP 3: Open a connection
      System.out.println("Connecting to database...");
      conn = DriverManager.getConnection(DB_URL,USER,PASS);

      //STEP 4: Execute a query
      System.out.println("Creating statement...");
      stmt = conn.createStatement();
      String sql;
      sql = "SELECT FROM ECX_ECX_ENTITY";
      ResultSet rs = stmt.executeQuery(sql);

      //STEP 5: Extract data from result set
      int i=0;
      while(rs.next()){
         //Retrieve by column name
    	  //int id  = rs.getInt("id");
    	  //int age = rs.getInt("age");
    	  //String first = rs.getString("first");
    	  //String last = rs.getString("last");
    	  
         //Display values
         System.out.print("ID: " + rs.getMetaData().getColumnName(i));
         //System.out.print(", Age: " + age);
         //System.out.print(", First: " + first);
         //System.out.println(", Last: " + last);
         i++;
      }
      //STEP 6: Clean-up environment
      rs.close();
      stmt.close();
      conn.close();
   }catch(SQLException se){
      //Handle errors for JDBC
      se.printStackTrace();
   }catch(Exception e){
      //Handle errors for Class.forName
      e.printStackTrace();
   }finally{
      //finally block used to close resources
      try{
         if(stmt!=null)
            stmt.close();
      }catch(SQLException se2){
      }// nothing we can do
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }//end finally try
   }//end try*/
   System.out.println("Goodbye!");
   try {
	FirstExample.sendGet();
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
}//end main
   
   private static void sendGet() throws Exception {

		String url = "http://preocapalogs01/INTEGRACION/INTECODEX/Ecodex/catalinaDomibus.out.1";
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod("GET");

		//add request header
		//con.setRequestProperty("User-Agent", USER_AGENT);

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);

		InputStream is = 
		         con.getInputStream();
		
		FileOutputStream os = new FileOutputStream("C:\\Users\\Juan\\catalina.txt");
        byte[] buffer = new byte[1024];
        int length;
        while ((length = is.read(buffer)) > 0) {
            os.write(buffer, 0, length);
        }
		/*String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();*/

		//print result
		//System.out.println(response.toString());

	}
}//end FirstExample
