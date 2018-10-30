package kidsaritmetica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.soap.AddressingFeature.Responses;

import kidsaritmetica.model.Suma;
import kidsaritmetica.service.GeneradorSumas;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {
	
	private static final int MAX_COLISIONES = 200;
	private Integer colisiones = 0;

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	  	response.setContentType("application/json");
	  	if(request.getParameter("accion").equalsIgnoreCase("subirNivel")) {
	  		String nivel =  (String) request.getSession().getAttribute("nivel");
	  		Integer level = new Integer(nivel);
	  		level++;
	  		request.getSession().setAttribute("nivel", level.toString());
	  		response.getWriter().write("{}");
	  		return;
	  	}
	  	
	  	
	    GeneradorSumas generador = new GeneradorSumas();
	    colisiones = 0;
	    if (request.getSession().getAttribute("sumasNiveles")==null) {
	    	Map<String, List<Suma>> sumasNiveles = new HashMap<>();
	    	request.getSession().setAttribute("sumasNiveles", sumasNiveles);
	    } 
	    Map<String, List<Suma>> sumasNiveles = (Map<String, List<Suma>>)request.getSession().getAttribute("sumasNiveles");
	    if(sumasNiveles.get(request.getParameter("nivel"))!=null)
	    	sumasNiveles.remove(request.getParameter("nivel"));
     	sumasNiveles.put(request.getParameter("nivel"), new ArrayList<>());
	    Suma nuevaSuma = null;
	    int nivel = new Integer(request.getParameter("nivel"));
	    String leyenda ="no leyenda";
	    if(nivel<=13) {
	    	if(nivel ==12)
	    		leyenda = "Level 12: one digit/one digit addition with regrouping in units";
	    	if(nivel ==13)
	    		leyenda = "Level 13: All additions Level 7 to 12";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel, colisiones,MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if(nivel ==14) {
	    	leyenda = "Level 14: two digits/one digit addition without regrouping";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if(nivel ==15) {
	    	leyenda = "Level 15: two digits/one digit addition with regrouping in units";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel17(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if(nivel ==16) {
	    	leyenda = "Level 16: two digits/one digit addition with regrouping in units and tens";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if(nivel ==17) {
	    	int nivelAleatorio =  new Random().ints(1, 14, 17).sum();
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	switch (nivelAleatorio) {
			    case 14:
			    	leyenda = "Level 14: two digits/one digit addition without regrouping";
			    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
			    		nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
					break;
				case 15:
			    	leyenda = "Level 15: two digits/one digit addition with regrouping in units";
			    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
			    		nuevaSuma = generador.getOperandosNivel17(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
			    	
			    	break;
				case 16:
			    	leyenda = "Level 16: two digits/one digit addition with regrouping in units and tens";
			    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
			    		nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
			    	break;
	    	}    	
	    }
	    else if (nivel ==18) {
	    	leyenda = "Level 18: two digits/two digits without regrouping";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }
	    else if (nivel ==19) {
	    	leyenda = "Level 19: two digits/two digits regrouping in untis";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel22(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }
	    else if (nivel ==20) {
	    	leyenda = "Level 20: two digits/two digits regrouping in tens";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if (nivel ==21) {
	    	leyenda = "Level 21: two digits/two digits regrouping in units and tens";
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    		nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
	    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
	    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
	    	}
	    	resultado.deleteCharAt(resultado.lastIndexOf(","));
	    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
	    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
	    	response.getWriter().write(resultado.toString());
	    }else if (nivel ==22) {
	    	int nivelAleatorio =  new Random().ints(1, 18, 22).sum();
	    	StringBuilder resultado = new StringBuilder("{\"sumas\":[");
	    	switch (nivelAleatorio) {
	    		case 18:
	    			leyenda = "Level 18: two digits/two digits without regrouping";
	    			while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    				nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
	    			break;
	    		case 19:
	    	    	leyenda = "Level 19: two digits/two digits regrouping in untis";
	    	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    	    		nuevaSuma = generador.getOperandosNivel22(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
	    	    	break;
	    		case 20:
	    	    	leyenda = "Level 20: two digits/two digits regrouping in tens";
	    	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    	    		nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
	    	    	break;
	    		case 21:
	    	    	leyenda = "Level 21: two digits/two digits regrouping in units and tens";
	    	    	while (sumasNiveles.get(request.getParameter("nivel")).size()<10) {
	    	    		nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")), colisiones, MAX_COLISIONES);
			    		sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
			    		resultado.append("{\"operador1\": \""+nuevaSuma.getOperando1()+"\",\"operador2\": \""+nuevaSuma.getOperando2()+"\"},");
			    	}
			    	resultado.deleteCharAt(resultado.lastIndexOf(","));
			    	resultado.append("], \"leyenda\": \""+leyenda+"\"}");
			    	sumasNiveles.get(request.getParameter("nivel")).sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			    	response.getWriter().write(resultado.toString());
	    	    	break;
	    	}	
	    }
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
	    String url = "jdbc:mysql://localhost:3306/kidsaritmetica";
	 
	    
	   //[END doc-example]
	    Connection connection = null;
		try {
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/kidsaritmetica?useSSL=false&cloudSqlInstance=kidsaritmetica:europe-west1:kidsaritmetica&socketFactory=com.google.cloud.sql.mysql.SocketFactory&user=juanpsm79&password=5326juan3738");
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