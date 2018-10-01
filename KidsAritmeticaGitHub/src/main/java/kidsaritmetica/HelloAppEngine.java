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
import java.util.Random;

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
	
	private static final int MAX_COLISIONES = 100;
	private Integer colisiones = 0;

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
	  	response.setContentType("application/json");
	    GeneradorSumas generador = new GeneradorSumas();
	    colisiones = 0;
	    if (request.getSession().getAttribute("sumasNiveles")==null) {
	    	Map<String, List<Suma>> sumasNiveles = new HashMap<>();
	    	request.getSession().setAttribute("sumasNiveles", sumasNiveles);
	    } 
	    Map<String, List<Suma>> sumasNiveles = (Map<String, List<Suma>>)request.getSession().getAttribute("sumasNiveles");
	    if(sumasNiveles.get(request.getParameter("nivel"))==null)
     		sumasNiveles.put(request.getParameter("nivel"), new ArrayList<>());
	    Suma nuevaSuma = null;
	    int nivel = new Integer(request.getParameter("nivel"));
	    String leyenda ="no leyenda";
	    if(nivel<=15) {
	    	nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel, colisiones,MAX_COLISIONES);
	    }else if(nivel ==16) {
	    	nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/one digit addition without regrouping";
	    }else if(nivel ==17) {
	    	nuevaSuma = generador.getOperandosNivel17(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/one digit addition with regrouping in units";
	    }else if(nivel ==18) {
	    	nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/one digit addition with regrouping in units and tens";
	    }else if(nivel ==19 || nivel ==20) {
	    	int nivelAleatorio =  new Random().ints(1, 16, 19).sum();
	    	switch (nivelAleatorio) {
			    case 16:
			    	nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    	leyenda = "two digits/one digit addition without regrouping";
					break;
				case 17:
					nuevaSuma = generador.getOperandosNivel17(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    	leyenda = "two digits/one digit addition with regrouping in units";
			    	break;
				case 18:
					nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    	leyenda = "two digits/one digit addition with regrouping in units and tens";
			    	break;
	    	}    	
	    }
	    else if (nivel ==21) {
	    	nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/two digits without regrouping";
	    }
	    else if (nivel ==22) {
	    	nuevaSuma = generador.getOperandosNivel22(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/two digits regrouping in untis";
	    }
	    else if (nivel ==23) {
	    	nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/two digits regrouping in tens";
	    }else if (nivel ==24) {
	    	nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	leyenda = "two digits/two digits regrouping in units and tens";
	    }else if (nivel ==25 || nivel ==26) {
	    	int nivelAleatorio =  new Random().ints(1, 21, 25).sum();
	    	switch (nivelAleatorio) {
	    		case 21:
	    			nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    			leyenda = "two digits/two digits without regrouping";
	    			break;
	    		case 22:
	    			nuevaSuma = generador.getOperandosNivel22(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	    	leyenda = "two digits/two digits regrouping in untis";
	    	    	break;
	    		case 23:
	    			nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	    	leyenda = "two digits/two digits regrouping in tens";
	    	    	break;
	    		case 24:
	    			nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    	    	leyenda = "two digits/two digits regrouping in units and tens";
	    	    	break;
	    	}	
	    }
	    
	    response.getWriter().write("{\"colisiones\": \""+colisiones+"\",\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\",\"nivel\": \""+request.getParameter("nivel")+"\", \"leyenda\": \""+leyenda+"\"}");
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