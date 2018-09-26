package kidsaritmetica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kidsaritmetica.model.Suma;
import kidsaritmetica.service.GeneradorSumas;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {
	
	private static final int MAX_COLISIONES = 50;

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
	  Map<String, String> options = new LinkedHashMap<>();
	    options.put("value1", "label1");
	    options.put("value2", "label2");
	    options.put("value3", "label3");
	   
	    //String conn = getConnection();
	    GeneradorSumas generador = new GeneradorSumas();
	    Map<String, List<Suma>> sumasNiveles = null;
	    if (request.getSession().getAttribute("sumasNiveles")==null) {
	    	sumasNiveles = new HashMap<>();
	    	sumasNiveles.put(request.getParameter("nivel"), new ArrayList<>());
	    	request.getSession().setAttribute("sumasNiveles", sumasNiveles);
	    } else {
	    	sumasNiveles = (Map<String, List<Suma>>)request.getSession().getAttribute("sumasNiveles");
	    	 if(sumasNiveles.get(request.getParameter("nivel"))==null)
	     		sumasNiveles.put(request.getParameter("nivel"), new ArrayList<>());
	    }
	    Suma nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), new Integer(request.getParameter("nivel")), 0,MAX_COLISIONES);
	    response.setContentType("application/json");
	    response.getWriter().write("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\",\"nivel\": \""+request.getParameter("nivel")+"\", \"errorMessage\": \"un error cualquiera\"}");
	   //response.getWriter().write("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\",\"tablas\": \""+conn+"\", \"nivel\": \""+request.getParameter("nivel")+"\", \"errorMessage\": \"un error cualquiera\"}");
  }
  
  
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
      	doPost(request, response);
	  
  }

	private String getConnection() {

	    String username = "juanpsm79";

	    // TODO: fill this in
	    // This is the password that was set via the Cloud Console or empty if never set
	    // (not recommended).
	    String password = "5326juan3738";

	   

	    //[START doc-example]
	    String url = System.getProperty("cloudsql");
	 
	    
	   //[END doc-example]
	    Connection connection = null;
		try {
			connection = DriverManager.getConnection(url);
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