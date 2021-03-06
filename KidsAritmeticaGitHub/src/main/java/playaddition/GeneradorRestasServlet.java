package playaddition;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.soap.AddressingFeature.Responses;

import playaddition.model.Resta;
import playaddition.model.Suma;
import playaddition.service.GeneradorRestas;
import playaddition.service.GeneradorSumas;

@WebServlet(name = "GeneradorRestasServlet", urlPatterns = { "/restas" })
public class GeneradorRestasServlet extends HttpServlet {

	private static final int MAX_COLISIONES = 100;
	private static final int NUMSUMAS = 50;
	private Integer colisiones = 0;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		if(request.getParameter("nivel")==null && request.getParameter("nivel").equalsIgnoreCase(""))
			response.sendRedirect(request.getContextPath() + "/presentacion.jsp");
		response.setContentType("application/json");
		request.getSession().setAttribute("nivel", request.getParameter("nivel"));

		GeneradorRestas generador = new GeneradorRestas();
		colisiones = 0;
		if (request.getSession().getAttribute("restasNiveles") == null) {
			Map<String, List<Resta>> sumasNiveles = new HashMap<>();
			request.getSession().setAttribute("restasNiveles", sumasNiveles);
		}
		Map<String, List<Resta>> restaNiveles = (Map<String, List<Resta>>) request.getSession().getAttribute("restasNiveles");
		if (restaNiveles.get(request.getParameter("nivel")) != null)
			restaNiveles.remove(request.getParameter("nivel"));
		
		request.getSession().setAttribute("assistance", false);
		request.getSession().setAttribute("tensRegrouping", false);
		request.getSession().setAttribute("hundredsRegrouping", false);
		request.getSession().setAttribute("wa", false);
		restaNiveles.put(request.getParameter("nivel"), new ArrayList<>());
		
		
		Resta nuevaResta = null;
		int nivel = new Integer((String) request.getSession().getAttribute("nivel"));
		String leyenda = "";
		if (nivel<11 && nivel!=5) {  
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), nivel,
							colisiones, MAX_COLISIONES);
					if(nuevaResta!=null) {
						restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
						resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getNivel() +"\"},");
					} else {
						List<Resta> restasNivel = restaNiveles.get(request.getParameter("nivel"));
						int restasGeneradas = restasNivel.size();
						int sumasPendientes = 50 - restasGeneradas;
						for(int i=0;i<sumasPendientes;i++) {
							Resta resta = restasNivel.get((i+restasGeneradas)%restasGeneradas);
							restasNivel.add(resta);
							resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
									+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
						}
						
					}
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==5) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 1:(10) 2:(10), 3(30), 4(50)
	            //en 15     (1),   (2)    (4)    (8)   
				
				List<Resta> restas4 = new ArrayList<Resta>();
				List<Resta> restas5 = new ArrayList<Resta>();
				
				for (int i=0;i<6;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas4, 4,
							colisiones, MAX_COLISIONES);
					restas4.add(nuevaResta);
					restas5.add(nuevaResta);
				}
				for (int i=0;i<2;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas4, 2,
							colisiones, MAX_COLISIONES);
					restas4.add(nuevaResta);
					restas5.add(nuevaResta);
				}
				
				Random rand = new Random();
				List<Resta> restasNivel = restaNiveles.get(request.getParameter("nivel"));
				for (int i = 0; i<8; i++) {
			        int randomIndex = rand.nextInt(restas4.size());
			        Resta randomElement = restas4.get(randomIndex);
			        restasNivel.add(randomElement);
			        restas4.remove(randomIndex);
			    }
				restasNivel.addAll(restas5);
				
				
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 1 : 1, Level 2 : 2, Level 3 : 4, Level 4 : 8\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==11) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 6:(10) 7:(10)  8:(10)   9(30)  10(40)
	            //en 15     (1),   (2)     (2)     (4)     (6)
				
				List<Resta> restas10 = new ArrayList<Resta>();
				for (int i=0;i<6;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas10, 10,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);	
				}
				
				for (int i=0;i<4;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas10, 9,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);
				}
				
				for (int i=0;i<2;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas10, 8,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);
				}
				
				for (int i=0;i<2;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas10, 7,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);
				}
				
				for (int i=0;i<1;i++) {
					nuevaResta = generador.obtenerRestaNivel(restas10, 6,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);
				}
				Random rand = new Random();
				List<Resta> restasNivel = restaNiveles.get(request.getParameter("nivel"));
				for (int i = 0; i<15; i++) {
			        int randomIndex = rand.nextInt(restas10.size());
			        Resta randomElement = restas10.get(randomIndex);
			        restasNivel.add(randomElement);
			        restas10.remove(randomIndex);
			    }
				
				
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 6 : 1, Level 7 : 2, Level 8 : 2, Level 9 : 4, Level 10 : 6\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==12) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 12: two digits/one digit. Subtrahend is smaller";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel12(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("wa", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==13) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 13: two digits/one digit. Subtrahend is bigger";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel13(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==14) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 12:(40) 13:(60)
	            //en 15      (6),    (9)
				List<Resta> restas12 = new ArrayList<Resta>();
				List<Resta> restas13 = new ArrayList<Resta>();
				
				for (int i=0;i<18;i++) {
					nuevaResta = generador.getOperandosNivel12(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas12.add(nuevaResta);
				}
				for (int i=0;i<27;i++) {
					nuevaResta = generador.getOperandosNivel13(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas13.add(nuevaResta);
				}
				
				ordenarRestasNivel14(restas12, restas13, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 6 : 1, Level 7 : 2, Level 8 : 2, Level 9 : 4, Level 10 : 6\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==15) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 15: TWO-DIGIT/ONE DIGIT 20 - 49. Subtraction Without Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel15(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==16 || nivel==17) {
			request.getSession().setAttribute("assistance", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 16/17: TWO-DIGIT/ONE DIGIT 20 - 49. Subtraction With Regrouping in Tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel1617(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==16)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==18) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 12:(30) 13:(70)
	            //en 18      (4),   (11)
				List<Resta> restas15 = new ArrayList<Resta>();
				List<Resta> restas17 = new ArrayList<Resta>();
				
				for (int i=0;i<12;i++) {
					nuevaResta = generador.getOperandosNivel15(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas15.add(nuevaResta);
				}
				for (int i=0;i<33;i++) {
					nuevaResta = generador.getOperandosNivel1617(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas17.add(nuevaResta);
				}
				
				ordenarRestasNivel18(restas15, restas17, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 15: 4, Level 17: 11\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("assistance", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==19) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 19: TWO-DIGIT/ONE DIGIT 50 - 99. Subtraction Without Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel19(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==20 || nivel==21) {
			request.getSession().setAttribute("assistance", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 20/21: TWO-DIGIT/ONE DIGIT 50 - 99. Subtraction With Regrouping in Tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel2021(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==20)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		}else if (nivel==22) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 20:(30) 21:(70)
	            //en 18      (4),   (11)
				List<Resta> restas19 = new ArrayList<Resta>();
				List<Resta> restas21 = new ArrayList<Resta>();
				
				for (int i=0;i<12;i++) {
					nuevaResta = generador.getOperandosNivel19(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas19.add(nuevaResta);
				}
				for (int i=0;i<33;i++) {
					nuevaResta = generador.getOperandosNivel2021(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas21.add(nuevaResta);
				}
				//misma distribución 30% - 70% que en nivel 18
				ordenarRestasNivel18(restas19, restas21, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 15: 4, Level 17: 11\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("assistance", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==23) {
			request.getSession().setAttribute("assistance", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 23: Two digits/Two digits. Without Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel23(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==24 || nivel==25) {
			request.getSession().setAttribute("assistance", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 24/25: two digits/two digits. Regrouping in tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel2425(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==24)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==26) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 23:(30) 25:(70)
	            //en 18      (4),   (11)
				List<Resta> restas23 = new ArrayList<Resta>();
				List<Resta> restas25 = new ArrayList<Resta>();
				
				for (int i=0;i<12;i++) {
					nuevaResta = generador.getOperandosNivel23(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas23.add(nuevaResta);
				}
				for (int i=0;i<33;i++) {
					nuevaResta = generador.getOperandosNivel2425(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas25.add(nuevaResta);
				}
				//misma distribución 30% - 70% que en nivel 18
				ordenarRestasNivel18(restas23, restas25, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 23: 4, Level 25: 11\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("assistance", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==27) {
			request.getSession().setAttribute("assistance", false);
			request.getSession().setAttribute("tensRegrouping", false);
			request.getSession().setAttribute("hundredsRegrouping", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 27: Three digits/One digits. Without Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel27(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==28 || nivel==29) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 28/29: Three digits/One digits. Subtraction With Regrouping in Tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel2829(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==28)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==30 || nivel==31) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 30/31: three digits/one digits. Regrouping in hundred and tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel3031(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==30)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==32) {
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//% ---> 29:(30) 31:(70)
	            //en 18      (4),   (11)
				List<Resta> restas27 = new ArrayList<Resta>();
				List<Resta> restas29 = new ArrayList<Resta>();
				List<Resta> restas31 = new ArrayList<Resta>();
				
				for (int i=0;i<12;i++) {
					nuevaResta = generador.getOperandosNivel27(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas27.add(nuevaResta);
				}
				for (int i=0;i<24;i++) {
					nuevaResta = generador.getOperandosNivel2829(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas29.add(nuevaResta);
				}
				for (int i=0;i<9;i++) {
					nuevaResta = generador.getOperandosNivel3031(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas31.add(nuevaResta);
				}
				//misma distribución 30% - 70% que en nivel 18
				ordenarRestasNivel32(restas27, restas29,  restas31, restaNiveles.get(request.getParameter("nivel")));
				//ordenarRestasNivel18(restas29, restas31, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 27:30%, Level 29: 50%, Level 31: 20%\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("assistance", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==33) {
			request.getSession().setAttribute("assistance", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 33: Three digits/Two digits. Without Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel33(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		} else if (nivel==34 || nivel==35) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 34/35: Three digits/Two digits. Subtraction With Regrouping in Tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel3435(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==34)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==36 || nivel==37) {
			request.getSession().setAttribute("assistance", true);
			if (nivel==37)
				request.getSession().setAttribute("wa", false);
			request.getSession().setAttribute("tensRegrouping", false);
			request.getSession().setAttribute("hundredsRegrouping", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 36/37: Three digits/Two digits. Subtraction With Regrouping in Hundreds";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel3637(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==36)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==38 || nivel==39) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 38/39: three digits/two digits. Regrouping in hundred and tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel3839(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==38)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		}  else if (nivel==40) {
			request.getSession().setAttribute("assistance", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			try {
				//%      L33 10%, L35 25%, L37 25%, L39 40%
	            //en 15      (1),     (3)      (4)      (7)
				List<Resta> restas33 = new ArrayList<Resta>();
				List<Resta> restas35 = new ArrayList<Resta>();
				List<Resta> restas37 = new ArrayList<Resta>();
				List<Resta> restas39 = new ArrayList<Resta>();
				
				for (int i=0;i<3;i++) {
					nuevaResta = generador.getOperandosNivel33(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas33.add(nuevaResta);
				}
				for (int i=0;i<9;i++) {
					nuevaResta = generador.getOperandosNivel3435(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas35.add(nuevaResta);
				}
				for (int i=0;i<12;i++) {
					nuevaResta = generador.getOperandosNivel3637(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas37.add(nuevaResta);
				}
				for (int i=0;i<21;i++) {
					nuevaResta = generador.getOperandosNivel3839(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restas39.add(nuevaResta);
				}
				
				ordenarRestasNivel40(restas33, restas35, restas37, restas39, restaNiveles.get(request.getParameter("nivel")));
				List<Resta> restas = restaNiveles.get(request.getParameter("nivel"));
				Iterator<Resta> iter = restas.iterator();
				while (iter.hasNext()) {
					Resta resta = iter.next();
					if (resta!=null)
						resultado.append("{\"resultado\": \"" + resta.getResultadoResta() + "\",\"operador1\": \"" + resta.getOperando1() + "\",\"operador2\": \""
							+ resta.getOperando2() + "\",\"nivel\": \""+resta.getNivel() +"\"},");
					
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"Level 33: 1, Level 35: 3, Level 37: 4, Level 39: 7\"}");
				response.getWriter().write(resultado.toString());
				request.getSession().setAttribute("assistance", false);
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}

		} else if (nivel==41 || nivel==42) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", false);
			request.getSession().setAttribute("hundredsRegrouping", true);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 41,42: three digits/two digits. Regrouping in hundred";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel4142(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			if(nivel==41)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
		} else if (nivel==43 || nivel==44) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", true);
			if(nivel==43)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 43,44: three digits/two digits. Regrouping in hundred and tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel4344(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			
		} else if (nivel==46) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", false);
			request.getSession().setAttribute("hundredsRegrouping", false);
			request.getSession().setAttribute("wa", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 46: three digits/three digits. Wihtout Regrouping";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel46(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
		
				
		} else if (nivel==47 || nivel==48) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", false);
			if(nivel==47)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 47,48: three digits/three digits. Regrouping in tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel4748(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			
		} else if (nivel==49 || nivel==50) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", false);
			request.getSession().setAttribute("hundredsRegrouping", true);
			if(nivel==49)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 47,48: three digits/three digits. Regrouping in tens";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel4950(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			
		} else if (nivel==51 || nivel==52) {
			request.getSession().setAttribute("assistance", true);
			request.getSession().setAttribute("tensRegrouping", true);
			request.getSession().setAttribute("hundredsRegrouping", true);
			if(nivel==51)
				request.getSession().setAttribute("wa", true);
			else
				request.getSession().setAttribute("wa", false);
			StringBuilder resultado = new StringBuilder("{\"restas\":[");
			leyenda = "Level 51,52: three digits/three digits. Regrouping in tens and hundreds";
			try {
				while (restaNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
					nuevaResta = generador.getOperandosNivel5152(restaNiveles.get(request.getParameter("nivel")), colisiones,
							MAX_COLISIONES);
					restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
					resultado.append("{\"resultado\": \"" + nuevaResta.getResultadoResta() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
							+ nuevaResta.getOperando2() + "\"},");
				}
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}catch(Exception ex) {
				ex.printStackTrace();
				nuevaResta = new Resta();
				nuevaResta.setOperando1(-1);
				nuevaResta.setOperando2(-1);
				restaNiveles.get(request.getParameter("nivel")).add(nuevaResta);
				resultado.append("{\"resultado\": \"" + nuevaResta.getOperando1() + "\",\"operador1\": \"" + nuevaResta.getOperando1() + "\",\"operador2\": \""
						+ nuevaResta.getOperando2() + "\",\"nivel\": \""+nuevaResta.getOperando1() +"\"},");
				resultado.deleteCharAt(resultado.lastIndexOf(","));
				resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
				response.getWriter().write(resultado.toString());
			}
			
		} else 
			response.getWriter().write("{\"resultado\":\"1\"}");
		request.getSession().setAttribute("restas", restaNiveles.get(request.getParameter("nivel")));
	}

	

	private void ordenarRestasNivel14(List<Resta> restas12, List<Resta> restas13, List<Resta> restas) {
		//% ---> 12:(40) 13:(60)
        //en 15      (6),    (9)
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				
				//12
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas12.get(5));
				
				//13
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas13.get(8));
				
				
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				
				//12
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas12.get(11));
				
				//13
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(11));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(15));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas13.get(17));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//12
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(15));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas12.get(17));
				
				//13
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(18));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(19));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(20));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(21));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(22));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(23));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(24));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(25));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas13.get(26));
			}
		
	}
	
	
	private void ordenarRestasNivel18(List<Resta> restas15, List<Resta> restas17, List<Resta> restas) {
		//% ---> 15:(40) 17:(60)
        //en 15      (4),    (11)
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				
				//15
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas15.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas15.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas15.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas15.get(3));
				
				
				
				//17
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas17.get(10));
				
				
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				
				//15
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas15.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas15.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas15.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas15.get(7));
				
				
				
				//17
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(11));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(15));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(17));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(18));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(19));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(20));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas17.get(21));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//15
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas15.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas15.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas15.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas15.get(11));
				
				
				
				//17
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(22));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(23));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(24));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(25));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(26));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(27));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(28));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(29));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(30));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(31));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas17.get(32));
			}
		
	}

	private void ordenarRestasNivel5(List<Resta> restas1, List<Resta> restas2, List<Resta> restas3,
			List<Resta> restas4, List<Resta> restas) {
		//% ---> 1:(10) 2:(10), 3(30), 4(50)
        //en 15     (1),   (2)    (4)    (8)
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				
				//1
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas1.get(0));
				//2
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas2.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas2.get(1));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas3.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas3.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas3.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas3.get(3));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas4.get(7));
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				
				//1
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas1.get(1));
				//2
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas2.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas2.get(3));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas3.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas3.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas3.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas3.get(7));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(11));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas4.get(15));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//1
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas1.get(2));
				//2
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas2.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas2.get(5));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas3.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas3.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas3.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas3.get(11));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(17));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(18));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(19));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(20));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(21));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(22));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas4.get(23));
			}
	}

	private void ordenarRestasNivel11(List<Resta> restas6, List<Resta> restas7, List<Resta> restas8,
			List<Resta> restas9, List<Resta> restas10, List<Resta> restas) {
		//% ---> 6:(10) 7:(10)  8:(10)   9(30)  10(40)
        //en 15     (1),   (2)     (2)     (4)     (6)
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				//1
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas6.get(0));
				//7
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas7.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas7.get(1));
				//8
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas8.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas8.get(1));
				//9
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas9.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas9.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas9.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas9.get(3));
				//10
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas10.get(5));
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				//1
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas6.get(1));
				//7
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas7.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas7.get(3));
				//8
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas8.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas8.get(3));
				//9
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas9.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas9.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas9.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas9.get(7));
				//10
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas10.get(11));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//1
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas6.get(2));
				//7
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas7.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas7.get(5));
				//8
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas8.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas8.get(5));
				//9
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas9.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas9.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas9.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas9.get(11));
				//10
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(15));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas10.get(17));
			}
		
	}
	
	private void ordenarRestasNivel32(List<Resta> restas27, List<Resta> restas29,
			List<Resta> restas31, List<Resta> restas) {
		//%      L27 30%, L29 50%, L31 20%
        
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas31.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas31.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas31.get(2));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas27.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas27.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas27.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas27.get(3));
				
				//8
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas29.get(7));
				
				
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				//3
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas31.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas31.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas31.get(5));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas27.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas27.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas27.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas27.get(7));
				
				//8
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(11));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(13));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas29.get(15));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas31.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas31.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas31.get(8));
				
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas27.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas27.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas27.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas27.get(11));
				
				//8
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(17));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(18));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(19));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(20));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(21));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(22));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas29.get(23));
			}
		
	}
	
	private void ordenarRestasNivel40(List<Resta> restas33, List<Resta> restas35, List<Resta> restas37,
			List<Resta> restas39, List<Resta> restas) {
		//%      L33 10%, L35 25%, L37 25%, L39 40%
        //en 15      (1),     (3)      (4)      (7)
		for (int i=0;i<45;i++)
			restas.add(null);
		int posicionLibre = 0;
		
			while (restas.get(0)== null || restas.get(1)==null || restas.get(2)==null || restas.get(3)==null || restas.get(4)==null ||
					restas.get(5)== null || restas.get(6)==null || restas.get(7)==null || restas.get(8)==null || restas.get(9)==null ||
					restas.get(10)== null || restas.get(11)==null || restas.get(12)==null || restas.get(13)==null || restas.get(14)==null) {
				//1
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas33.get(0));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas35.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas35.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas35.get(2));
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas37.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas37.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas37.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas37.get(3));
				
				//7
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(0));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(1));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(2));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,15);
				restas.add(posicionLibre, restas39.get(6));
				
				
			}
			
			while(restas.get(15)== null || restas.get(16)==null || restas.get(17)==null || restas.get(18)==null || restas.get(19)==null ||
					restas.get(20)== null || restas.get(21)==null || restas.get(22)==null || restas.get(23)==null || restas.get(24)==null ||
					restas.get(25)== null || restas.get(26)==null || restas.get(27)==null || restas.get(28)==null || restas.get(29)==null) {
				//1
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas33.get(1));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas35.get(3));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas35.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas35.get(5));
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas37.get(4));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas37.get(5));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas37.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas37.get(7));
				
				//7
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(11));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(12));
				posicionLibre = calcularPosicionLibreRango(restas,30);
				restas.add(posicionLibre, restas39.get(13));
			}
			while(restas.get(30)== null || restas.get(31)==null || restas.get(32)==null || restas.get(33)==null || restas.get(34)==null ||
					restas.get(35)== null || restas.get(36)==null || restas.get(37)==null || restas.get(38)==null || restas.get(39)==null ||
					restas.get(40)== null || restas.get(41)==null || restas.get(42)==null || restas.get(43)==null || restas.get(44)==null) {
				
				//1
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas33.get(2));
				
				//3
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas35.get(6));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas35.get(7));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas35.get(8));
				
				//4
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas37.get(8));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas37.get(9));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas37.get(10));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas37.get(11));
				
				//7
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(14));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(15));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(16));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(17));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(18));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(19));
				posicionLibre = calcularPosicionLibreRango(restas,45);
				restas.add(posicionLibre, restas39.get(20));
			}
		
	}

	private int calcularPosicionLibreRango(List<Resta> listaSumas, int indiceSupRango) {
		int index = new Random().ints(1, indiceSupRango-15, indiceSupRango).sum();
		if (listaSumas.get(index)==null) {
			listaSumas.remove(index);
			return index;
		}
		else 
			return calcularPosicionLibreRango(listaSumas, indiceSupRango);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);

	}

}