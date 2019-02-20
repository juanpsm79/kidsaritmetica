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

	private static final int MAX_COLISIONES = 300;
	private static final int NUMSUMAS = 50;
	private Integer colisiones = 0;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
				List<Resta> restas1 = new ArrayList<Resta>();
				List<Resta> restas2 = new ArrayList<Resta>();
				List<Resta> restas3 = new ArrayList<Resta>();
				List<Resta> restas4 = new ArrayList<Resta>();
				for (int i=0;i<3;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 1,
							colisiones, MAX_COLISIONES);
					restas1.add(nuevaResta);
				}
				for (int i=0;i<6;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 2,
							colisiones, MAX_COLISIONES);
					restas2.add(nuevaResta);
				}
				for (int i=0;i<12;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 3,
							colisiones, MAX_COLISIONES);
					restas3.add(nuevaResta);
				}
				for (int i=0;i<24;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 4,
							colisiones, MAX_COLISIONES);
					restas4.add(nuevaResta);
				}	
				ordenarRestasNivel5(restas1, restas2, restas3, restas4, restaNiveles.get(request.getParameter("nivel")));
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
				List<Resta> restas6 = new ArrayList<Resta>();
				List<Resta> restas7 = new ArrayList<Resta>();
				List<Resta> restas8 = new ArrayList<Resta>();
				List<Resta> restas9 = new ArrayList<Resta>();
				List<Resta> restas10 = new ArrayList<Resta>();
				for (int i=0;i<3;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 6,
							colisiones, MAX_COLISIONES);
					restas6.add(nuevaResta);
				}
				for (int i=0;i<6;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 7,
							colisiones, MAX_COLISIONES);
					restas7.add(nuevaResta);
				}
				for (int i=0;i<6;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 8,
							colisiones, MAX_COLISIONES);
					restas8.add(nuevaResta);
				}
				for (int i=0;i<12;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 9,
							colisiones, MAX_COLISIONES);
					restas9.add(nuevaResta);
				}
				for (int i=0;i<18;i++) {
					nuevaResta = generador.obtenerRestaNivel(restaNiveles.get(request.getParameter("nivel")), 10,
							colisiones, MAX_COLISIONES);
					restas10.add(nuevaResta);
				}
				ordenarRestasNivel11(restas6, restas7, restas8, restas9, restas10, restaNiveles.get(request.getParameter("nivel")));
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
		}else if (nivel==13) {
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

		}else 
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