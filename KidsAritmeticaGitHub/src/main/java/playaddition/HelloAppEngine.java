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

import playaddition.model.Suma;
import playaddition.service.GeneradorSumas;

@WebServlet(name = "HelloAppEngine", urlPatterns = { "/hello" })
public class HelloAppEngine extends HttpServlet {

	private static final int MAX_COLISIONES = 300;
	private static final int NUMSUMAS = 50;
	private Integer colisiones = 0;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");

		request.getSession().setAttribute("nivel", request.getParameter("nivel"));

		GeneradorSumas generador = new GeneradorSumas();
		colisiones = 0;
		if (request.getSession().getAttribute("sumasNiveles") == null) {
			Map<String, List<Suma>> sumasNiveles = new HashMap<>();
			request.getSession().setAttribute("sumasNiveles", sumasNiveles);
		}
		Map<String, List<Suma>> sumasNiveles = (Map<String, List<Suma>>) request.getSession().getAttribute("sumasNiveles");
		if (sumasNiveles.get(request.getParameter("nivel")) != null)
			sumasNiveles.remove(request.getParameter("nivel"));
		sumasNiveles.put(request.getParameter("nivel"), new ArrayList<>());
		Suma nuevaSuma = null;
		int nivel = new Integer((String) request.getSession().getAttribute("nivel"));
		String leyenda = "";
		if (nivel<=12) {
			if (nivel==12)
				leyenda = "Level 12: one digit/one digit addition with regrouping in units";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel,
						colisiones, MAX_COLISIONES);
				if(nuevaSuma!=null) {
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\",\"nivel\": \""+nuevaSuma.getNivel() +"\"},");
				} else {
					List<Suma> sumasNivel = sumasNiveles.get(request.getParameter("nivel"));
					int sumasGeneradas = sumasNivel.size();
					int sumasPendientes = 50 - sumasGeneradas;
					for(int i=0;i<sumasPendientes;i++) {
						Suma suma = sumasNivel.get((i+sumasGeneradas)%sumasGeneradas);
						sumasNivel.add(suma);
						resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
								+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
					}
					
				}
				
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel==13) {
			//13 ---> 10:(15) y el 12:(35)
            //            (3),         (7)
			List<Suma> sumas10 = new ArrayList<Suma>();
			List<Suma> sumas12 = new ArrayList<Suma>();
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), 10,
						colisiones, MAX_COLISIONES);
				sumas10.add(nuevaSuma);
			}
			
			for (int i=0;i<35;i++) {
				nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), 12,
						colisiones, MAX_COLISIONES);
				sumas12.add(nuevaSuma);
			}
				
			ordenarSumasNivel25(sumas10,sumas12,sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 10 : 15, Level 12 : 35\"}");
			response.getWriter().write(resultado.toString());
						

		} else if (nivel == 14) {
			leyenda = "Level 14: two digits/one digit addition without regrouping";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel14(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 15) {
			leyenda = "Level 15: two digits/one digit addition with regrouping in units";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel15(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 16) {
			leyenda = "Level 16: two digits/one digit addition with regrouping in units and tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 17) {
			//17 ---> 14:(10), 15:(15), 16:(25)
            //            (2),     (3),     (5)
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			List<Suma> sumas14 = new ArrayList<Suma>();
			List<Suma> sumas15 = new ArrayList<Suma>();
			List<Suma> sumas16 = new ArrayList<Suma>();
			for (int i=0;i<10;i++) {
				nuevaSuma = generador.getOperandosNivel14(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas14.add(nuevaSuma);
			}
			
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.getOperandosNivel15(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas15.add(nuevaSuma);
			}
			
			for (int i=0;i<25;i++) {
				nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas16.add(nuevaSuma);
			}
			ordenarSumasNivel17(sumas14,sumas15,sumas16, sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}		
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 14: 10, Level 15: 15, Level 16: 25\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 18) {
			leyenda = "Level 18: two digits/two digits without regrouping";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 19) {
			leyenda = "Level 19: two digits/two digits regrouping in untis";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel19(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 20) {
			leyenda = "Level 20: two digits/two digits regrouping in tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel20(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 21) {
			leyenda = "Level 21: two digits/two digits regrouping in units and tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 22) {
			//22 ---> 18:(5), 19:(10), 20:(15), 21:(20)
	        //           (1),     (2),     (3),     (4)
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			List<Suma> sumas18 = new ArrayList<Suma>();
			List<Suma> sumas19 = new ArrayList<Suma>();
			List<Suma> sumas20 = new ArrayList<Suma>();
			List<Suma> sumas21 = new ArrayList<Suma>();


			for (int i=0;i<5;i++) {
				nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas18.add(nuevaSuma);
			}
			
			for (int i=0;i<10;i++) {
				nuevaSuma = generador.getOperandosNivel19(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas19.add(nuevaSuma);
			}
			
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.getOperandosNivel20(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas20.add(nuevaSuma);
			}
			
			for (int i=0;i<20;i++) {
				nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas21.add(nuevaSuma);
			}
				
			ordenarSumasNivel22(sumas18,sumas19,sumas20, sumas21, sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}		
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 18: 5, Level 19: 10, Level 20: 15, Level 21: 20\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 23) {
			leyenda = "Level 23: three digits/one digit addition without regrouping";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());
			response.getWriter().write(resultado.toString());
		} else if (nivel == 24) {
			leyenda = "Level 24: three digits/one digit addition with regrouping in units";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 25) {
			///25 ---> 23:(15), 24:(35) 
            ///            (3),     (7)
			List<Suma> sumas23 = new ArrayList<Suma>();
			List<Suma> sumas24 = new ArrayList<Suma>();
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas23.add(nuevaSuma);
			}
			
			for (int i=0;i<35;i++) {
				nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas24.add(nuevaSuma);
			}
				
			ordenarSumasNivel25(sumas23,sumas24,sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 23 : 15, Level 24 : 35\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 26) {
			leyenda = "Level 26: three digits/two digits addition without regrouping";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel26(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			
			response.getWriter().write(resultado.toString());
		} else if (nivel == 27) {
			leyenda = "Level 27: three digits/two digits addition with regrouping in units";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel27(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			
			response.getWriter().write(resultado.toString());
		} else if (nivel == 28) {
			leyenda = "Level 28: three digits/two digits addition with regrouping in tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel28(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			
			response.getWriter().write(resultado.toString());
		} else if (nivel == 29) {
			leyenda = "Level 29: three digits/two digits addition with regrouping in units and tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel29(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			
			response.getWriter().write(resultado.toString());
		} else if (nivel == 30) {
			leyenda = "Level 30: three digits/two digits addition with regrouping in tens and hundreds";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel30(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			
			response.getWriter().write(resultado.toString());
		} else if (nivel == 31) {
			leyenda = "Level 31: three digits/two digits addition with regrouping in units tens and hundreds";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel31(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 32) {
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			//32 ---> 26:(5), 27:(5), 28:(5), 29:(10), 30:(10), 31:(15)
	        //////////   (1),    (1),    (1),     (2),    (2),     (3),
			List<Suma> sumas26 = new ArrayList<Suma>();
			List<Suma> sumas27 = new ArrayList<Suma>();
			List<Suma> sumas28 = new ArrayList<Suma>();
			List<Suma> sumas29 = new ArrayList<Suma>();
			List<Suma> sumas30 = new ArrayList<Suma>();
			List<Suma> sumas31 = new ArrayList<Suma>();
			for (int i=0;i<5;i++) {
				nuevaSuma = generador.getOperandosNivel26(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas26.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel27(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas27.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel28(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas28.add(nuevaSuma);
			}
			
			for (int i=0;i<10;i++) {
				nuevaSuma = generador.getOperandosNivel29(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas29.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel30(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas30.add(nuevaSuma);
				
			}
			
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.getOperandosNivel31(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas31.add(nuevaSuma);
				
				
			}
			ordenarSumasNivel32(sumas26,sumas27,sumas28,sumas29,sumas30,sumas31, sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 26 : 5, Level 27 : 5, Level 28 :5, Level 29 :10 Level 30 :10, Level 31 :15\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 33) {
			leyenda = "Level 33: three digits/three digits addition without regrouping";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel33(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 34) {
			leyenda = "Level 34: three digits/three digits addition with regrouping in units";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel34(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 35) {
			leyenda = "Level 35: three digits/three digits addition with regrouping in tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel35(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 36) {
			leyenda = "Level 36: three digits/three digits addition with regrouping in units and tens";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel36(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 37) {
			leyenda = "Level 37: three digits/three digits addition with regrouping in units and hundreds";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel37(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 38) {
			leyenda = "Level 38: three digits/three digits addition with regrouping in tens and hundreds";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel38(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 39) {
			leyenda = "Level 39: three digits/three digits addition with regrouping in units tens and hundreds";
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				nuevaSuma = generador.getOperandosNivel39(sumasNiveles.get(request.getParameter("nivel")), colisiones,
						MAX_COLISIONES);
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			response.getWriter().write(resultado.toString());
		} else if (nivel == 40) {
			List<Suma> sumas33 = new ArrayList<Suma>();
			List<Suma> sumas34 = new ArrayList<Suma>();
			List<Suma> sumas35 = new ArrayList<Suma>();
			List<Suma> sumas36 = new ArrayList<Suma>();
			List<Suma> sumas37 = new ArrayList<Suma>();
			List<Suma> sumas38 = new ArrayList<Suma>();
			List<Suma> sumas39 = new ArrayList<Suma>();
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			//33:(5), 34:(5), 35:(5), 36:(10), 37:(5), 38:(5), 39:(15)
			for (int i=0;i<5;i++) {
				nuevaSuma = generador.getOperandosNivel33(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas33.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel34(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas34.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel35(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas35.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel37(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas37.add(nuevaSuma);
				
				nuevaSuma = generador.getOperandosNivel38(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas38.add(nuevaSuma);
				
			}
			for (int i=0;i<10;i++) {
				nuevaSuma = generador.getOperandosNivel36(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas36.add(nuevaSuma);
			}
			for (int i=0;i<15;i++) {
				nuevaSuma = generador.getOperandosNivel39(sumasNiveles.get(request.getParameter("nivel")),
						colisiones, MAX_COLISIONES);
				sumas39.add(nuevaSuma);
			}
			ordenarSumasNivel40(sumas33,sumas34,sumas35,sumas36,sumas37,sumas38,sumas39, sumasNiveles.get(request.getParameter("nivel")));
			List<Suma> sumas40 = sumasNiveles.get(request.getParameter("nivel"));
			Iterator<Suma> iter = sumas40.iterator();
			while (iter.hasNext()) {
				Suma suma = iter.next();
				if (suma!=null)
					resultado.append("{\"resultado\": \"" + suma.getResultadoSuma() + "\",\"operador1\": \"" + suma.getOperando1() + "\",\"operador2\": \""
						+ suma.getOperando2() + "\",\"nivel\": \""+suma.getNivel() +"\"},");
				
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 33 : 5, Level 34 : 5, Level 35 :5, Level 36 :10 Level 37 :5, Level 38 :5, Level 39 :15\"}");
			response.getWriter().write(resultado.toString());

		}
		request.getSession().setAttribute("sumas", sumasNiveles.get(request.getParameter("nivel")));
	}

	private void ordenarSumasNivel17(List<Suma> sumas14, List<Suma> sumas15, List<Suma> sumas16, List<Suma> sumas) {
		//17 ---> 14:(10), 15:(15), 16:(25)
        //            (2),     (3),     (5)
		for (int i=0;i<50;i++)
			sumas.add(null);
		int posicionLibre = 0;
		
			while (sumas.get(0)== null || sumas.get(1)==null || sumas.get(2)==null || sumas.get(3)==null || sumas.get(4)==null ||
					sumas.get(5)== null || sumas.get(6)==null || sumas.get(7)==null || sumas.get(8)==null || sumas.get(9)==null) {
				
				//14
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas14.get(0));
				sumas.add(posicionLibre, sumas14.get(1));
				//15
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas15.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas15.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas15.get(2));
				//16
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas16.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas16.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas16.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas16.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas16.get(4));
			}
			
			while(sumas.get(10)== null || sumas.get(11)==null || sumas.get(12)==null || sumas.get(13)==null || sumas.get(14)==null ||
					sumas.get(15)== null || sumas.get(16)==null || sumas.get(17)==null || sumas.get(18)==null || sumas.get(19)==null) {
				
				//14
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas14.get(2));
				sumas.add(posicionLibre, sumas14.get(3));
				//15
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas15.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas15.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas15.get(5));
				//16
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas16.get(5));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas16.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas16.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas16.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas16.get(9));
			}
			while(sumas.get(20)== null || sumas.get(21)==null || sumas.get(22)==null || sumas.get(23)==null || sumas.get(24)==null ||
					sumas.get(25)== null || sumas.get(26)==null || sumas.get(27)==null || sumas.get(28)==null || sumas.get(29)==null) {
				
				//14
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas14.get(4));
				sumas.add(posicionLibre, sumas14.get(5));
				//15
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas15.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas15.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas15.get(8));
				//16
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas16.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas16.get(11));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas16.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas16.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas16.get(14));
			}
			while(sumas.get(30)== null || sumas.get(31)==null || sumas.get(32)==null || sumas.get(33)==null || sumas.get(34)==null ||
					sumas.get(35)== null || sumas.get(36)==null || sumas.get(37)==null || sumas.get(38)==null || sumas.get(39)==null) {
				
				//14
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas14.get(6));
				sumas.add(posicionLibre, sumas14.get(7));
				//15
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas15.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas15.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas15.get(11));
				//16
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas16.get(15));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas16.get(16));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas16.get(17));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas16.get(18));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas16.get(19));
			}
			while(sumas.get(40)== null || sumas.get(41)==null || sumas.get(42)==null || sumas.get(43)==null || sumas.get(44)==null ||
					sumas.get(45)== null || sumas.get(46)==null || sumas.get(47)==null || sumas.get(48)==null || sumas.get(49)==null) {
				
				//14
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas14.get(8));
				sumas.add(posicionLibre, sumas14.get(9));
				//15
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas15.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas15.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas15.get(14));
				//16
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas16.get(20));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas16.get(21));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas16.get(22));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas16.get(23));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas16.get(24));
			}
		
	}

	private void ordenarSumasNivel22(List<Suma> sumas18, List<Suma> sumas19, List<Suma> sumas20, List<Suma> sumas21,
			List<Suma> sumas) {
		//22 ---> 18:(5), 19:(10), 20:(15), 21:(20)
        //           (1),     (2),     (3),     (4)
		for (int i=0;i<50;i++)
			sumas.add(null);
		int posicionLibre = 0;
		
			while (sumas.get(0)== null || sumas.get(1)==null || sumas.get(2)==null || sumas.get(3)==null || sumas.get(4)==null ||
					sumas.get(5)== null || sumas.get(6)==null || sumas.get(7)==null || sumas.get(8)==null || sumas.get(9)==null) {
				
				//18
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas18.get(0));
				//19
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas19.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas19.get(1));
				//20
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas20.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas20.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas20.get(2));
				//21
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas21.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas21.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas21.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas21.get(3));
			}
			
			while(sumas.get(10)== null || sumas.get(11)==null || sumas.get(12)==null || sumas.get(13)==null || sumas.get(14)==null ||
					sumas.get(15)== null || sumas.get(16)==null || sumas.get(17)==null || sumas.get(18)==null || sumas.get(19)==null) {
				
				//18
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas18.get(1));
				//19
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas19.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas19.get(3));
				//20
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas20.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas20.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas20.get(5));
				//21
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas21.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas21.get(5));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas21.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas21.get(7));
			}
			while(sumas.get(20)== null || sumas.get(21)==null || sumas.get(22)==null || sumas.get(23)==null || sumas.get(24)==null ||
					sumas.get(25)== null || sumas.get(26)==null || sumas.get(27)==null || sumas.get(28)==null || sumas.get(29)==null) {
				
				//18
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas18.get(2));
				//19
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas19.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas19.get(5));
				//20
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas20.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas20.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas20.get(8));
				//21
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas21.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas21.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas21.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas21.get(11));
			}
			while(sumas.get(30)== null || sumas.get(31)==null || sumas.get(32)==null || sumas.get(33)==null || sumas.get(34)==null ||
					sumas.get(35)== null || sumas.get(36)==null || sumas.get(37)==null || sumas.get(38)==null || sumas.get(39)==null) {
				
				//18
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas18.get(3));
				//19
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas19.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas19.get(7));
				//20
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas20.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas20.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas20.get(11));
				//21
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas21.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas21.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas21.get(14));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas21.get(15));
			}
			while(sumas.get(40)== null || sumas.get(41)==null || sumas.get(42)==null || sumas.get(43)==null || sumas.get(44)==null ||
					sumas.get(45)== null || sumas.get(46)==null || sumas.get(47)==null || sumas.get(48)==null || sumas.get(49)==null) {
				
				//18
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas18.get(4));
				//19
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas19.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas19.get(9));
				//20
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas20.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas20.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas20.get(14));
				//21
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas21.get(16));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas21.get(17));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas21.get(18));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas21.get(19));
			}
		
	}

	private void ordenarSumasNivel25(List<Suma> sumas23, List<Suma> sumas24, List<Suma> sumas) {
		///25 ---> 23:(15), 24:(35) 
        ///            (3),     (7),
		for (int i=0;i<50;i++)
			sumas.add(null);
		int posicionLibre = 0;
		
			while (sumas.get(0)== null || sumas.get(1)==null || sumas.get(2)==null || sumas.get(3)==null || sumas.get(4)==null ||
					sumas.get(5)== null || sumas.get(6)==null || sumas.get(7)==null || sumas.get(8)==null || sumas.get(9)==null) {
				
				//23
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas23.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas23.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas23.get(2));
				
				//24
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(5));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas24.get(6));
			}
			
			while(sumas.get(10)== null || sumas.get(11)==null || sumas.get(12)==null || sumas.get(13)==null || sumas.get(14)==null ||
					sumas.get(15)== null || sumas.get(16)==null || sumas.get(17)==null || sumas.get(18)==null || sumas.get(19)==null) {
				
				//23
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas23.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas23.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas23.get(5));
				
				//24
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(11));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas24.get(13));
			}
			while(sumas.get(20)== null || sumas.get(21)==null || sumas.get(22)==null || sumas.get(23)==null || sumas.get(24)==null ||
					sumas.get(25)== null || sumas.get(26)==null || sumas.get(27)==null || sumas.get(28)==null || sumas.get(29)==null) {
				
				//23
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas23.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas23.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas23.get(8));
				
				//24
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(14));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(15));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(16));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(17));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(18));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(19));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas24.get(20));
			}
			while(sumas.get(30)== null || sumas.get(31)==null || sumas.get(32)==null || sumas.get(33)==null || sumas.get(34)==null ||
					sumas.get(35)== null || sumas.get(36)==null || sumas.get(37)==null || sumas.get(38)==null || sumas.get(39)==null) {
				
				//23
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas23.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas23.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas23.get(11));
				
				//24
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(21));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(22));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(23));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(24));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(25));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(26));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas24.get(27));
			}
			while(sumas.get(40)== null || sumas.get(41)==null || sumas.get(42)==null || sumas.get(43)==null || sumas.get(44)==null ||
					sumas.get(45)== null || sumas.get(46)==null || sumas.get(47)==null || sumas.get(48)==null || sumas.get(49)==null) {
				
				//23
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas23.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas23.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas23.get(14));
				
				//24
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(28));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(29));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(30));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(31));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(32));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(33));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas24.get(34));
			}
		
	}

	private void ordenarSumasNivel32(List<Suma> sumas26, List<Suma> sumas27, List<Suma> sumas28, List<Suma> sumas29,
			List<Suma> sumas30, List<Suma> sumas31, List<Suma> sumas) {
		///32 ---> 26:(5), 27:(5), 28:(5), 29:(10), 30:(10), 31:(15)
       ////////////// (1),    (1),    (1),     (2),    (2),     (3),
		
		for (int i=0;i<50;i++)
			sumas.add(null);
		int posicionLibre = 0;
		
			while (sumas.get(0)== null || sumas.get(1)==null || sumas.get(2)==null || sumas.get(3)==null || sumas.get(4)==null ||
					sumas.get(5)== null || sumas.get(6)==null || sumas.get(7)==null || sumas.get(8)==null || sumas.get(9)==null) {
				
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas26.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas27.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas28.get(0));
				
				//29
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas29.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas29.get(1));
				
				//30
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas30.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas30.get(1));
				
				//31
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas31.get(0));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas31.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,10);
				sumas.add(posicionLibre, sumas31.get(2));
			}
			
			while(sumas.get(10)== null || sumas.get(11)==null || sumas.get(12)==null || sumas.get(13)==null || sumas.get(14)==null ||
					sumas.get(15)== null || sumas.get(16)==null || sumas.get(17)==null || sumas.get(18)==null || sumas.get(19)==null) {
				
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas26.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas27.get(1));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas28.get(1));
				
				//29
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas29.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas29.get(3));
				
				//30
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas30.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas30.get(3));
				
				//31
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas31.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas31.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,20);
				sumas.add(posicionLibre, sumas31.get(5));
			}
			while(sumas.get(20)== null || sumas.get(21)==null || sumas.get(22)==null || sumas.get(23)==null || sumas.get(24)==null ||
					sumas.get(25)== null || sumas.get(26)==null || sumas.get(27)==null || sumas.get(28)==null || sumas.get(29)==null) {
				
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas26.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas27.get(2));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas28.get(2));
				
				//29
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas29.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas29.get(5));
				
				//30
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas30.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas30.get(5));
				
				//31
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas31.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas31.get(7));
				posicionLibre = calcularPosicionLibreRango(sumas,30);
				sumas.add(posicionLibre, sumas31.get(8));
			}
			while(sumas.get(30)== null || sumas.get(31)==null || sumas.get(32)==null || sumas.get(33)==null || sumas.get(34)==null ||
					sumas.get(35)== null || sumas.get(36)==null || sumas.get(37)==null || sumas.get(38)==null || sumas.get(39)==null) {
				
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas26.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas27.get(3));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas28.get(3));
				
				//29
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas29.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas29.get(7));
				
				//30
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas30.get(6));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas30.get(7));
				
				//31
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas31.get(9));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas31.get(10));
				posicionLibre = calcularPosicionLibreRango(sumas,40);
				sumas.add(posicionLibre, sumas31.get(11));
			}
			while(sumas.get(40)== null || sumas.get(41)==null || sumas.get(42)==null || sumas.get(43)==null || sumas.get(44)==null ||
					sumas.get(45)== null || sumas.get(46)==null || sumas.get(47)==null || sumas.get(48)==null || sumas.get(49)==null) {
				
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas26.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas27.get(4));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas28.get(4));
				
				//29
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas29.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas29.get(9));
				
				//30
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas30.get(8));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas30.get(9));
				
				//31
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas31.get(12));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas31.get(13));
				posicionLibre = calcularPosicionLibreRango(sumas,50);
				sumas.add(posicionLibre, sumas31.get(14));
			}
		
	}

	private void ordenarSumasNivel40(List<Suma> sumas33, List<Suma> sumas34, List<Suma> sumas35, List<Suma> sumas36,
			List<Suma> sumas37, List<Suma> sumas38, List<Suma> sumas39, List<Suma> sumas40) {
		////33:(5), 34:(5), 35:(5), 36:(10), 37:(5), 38:(5), 39:(15)
        ///////(1),    (1),    (1),     (2),    (1),    (1),    (3)
			for (int i=0;i<50;i++)
				sumas40.add(null);
			int posicionLibre = 0;
			
				while (sumas40.get(0)== null || sumas40.get(1)==null || sumas40.get(2)==null || sumas40.get(3)==null || sumas40.get(4)==null ||
						sumas40.get(5)== null || sumas40.get(6)==null || sumas40.get(7)==null || sumas40.get(8)==null || sumas40.get(9)==null) {
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas33.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas34.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas35.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas37.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas38.get(0));
					//36
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas36.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas36.get(1));
					//39
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas39.get(0));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas39.get(1));
					posicionLibre = calcularPosicionLibreRango(sumas40,10);
					sumas40.add(posicionLibre, sumas39.get(2));
				}
				
				while(sumas40.get(10)== null || sumas40.get(11)==null || sumas40.get(12)==null || sumas40.get(13)==null || sumas40.get(14)==null ||
						sumas40.get(15)== null || sumas40.get(16)==null || sumas40.get(17)==null || sumas40.get(18)==null || sumas40.get(19)==null) {
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas33.get(1));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas34.get(1));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas35.get(1));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas37.get(1));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas38.get(1));
					//36
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas36.get(2));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas36.get(3));
					//39
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas39.get(3));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas39.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,20);
					sumas40.add(posicionLibre, sumas39.get(5));
				}
				while(sumas40.get(20)== null || sumas40.get(21)==null || sumas40.get(22)==null || sumas40.get(23)==null || sumas40.get(24)==null ||
						sumas40.get(25)== null || sumas40.get(26)==null || sumas40.get(27)==null || sumas40.get(28)==null || sumas40.get(29)==null) {
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas33.get(2));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas34.get(2));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas35.get(2));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas37.get(2));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas38.get(2));
					//36
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas36.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas36.get(5));
					//39
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas39.get(6));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas39.get(7));
					posicionLibre = calcularPosicionLibreRango(sumas40,30);
					sumas40.add(posicionLibre, sumas39.get(8));
				}
				while(sumas40.get(30)== null || sumas40.get(31)==null || sumas40.get(32)==null || sumas40.get(33)==null || sumas40.get(34)==null ||
						sumas40.get(35)== null || sumas40.get(36)==null || sumas40.get(37)==null || sumas40.get(38)==null || sumas40.get(39)==null) {
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas33.get(3));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas34.get(3));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas35.get(3));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas37.get(3));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas38.get(3));
					//36
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas36.get(6));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas36.get(7));
					//39
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas39.get(9));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas39.get(10));
					posicionLibre = calcularPosicionLibreRango(sumas40,40);
					sumas40.add(posicionLibre, sumas39.get(11));
				}
				while(sumas40.get(40)== null || sumas40.get(41)==null || sumas40.get(42)==null || sumas40.get(43)==null || sumas40.get(44)==null ||
						sumas40.get(45)== null || sumas40.get(46)==null || sumas40.get(47)==null || sumas40.get(48)==null || sumas40.get(49)==null) {
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas33.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas34.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas35.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas37.get(4));
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas38.get(4));
					//36
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas36.get(8));
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas36.get(9));
					//39
					posicionLibre = calcularPosicionLibreRango(sumas40,50);
					sumas40.add(posicionLibre, sumas39.get(12));
					posicionLibre = calcularPosicionLibreRango(sumas40, 50);
					sumas40.add(posicionLibre, sumas39.get(13));
					posicionLibre = calcularPosicionLibreRango(sumas40, 50);
					sumas40.add(posicionLibre, sumas39.get(14));
				}
			
	}

	private int calcularPosicionLibreRango(List<Suma> listaSumas, int indiceSupRango) {
		int index = new Random().ints(1, indiceSupRango-10, indiceSupRango).sum();
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

	private String getConnection() {

		String username = "juanpsm79";

		// TODO: fill this in
		// This is the password that was set via the Cloud Console or empty if never set
		// (not recommended).
		String password = "5326juan3738";

		// [START doc-example]
		String url = "jdbc:mysql://localhost:3306/kidsaritmetica";

		// [END doc-example]
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/kidsaritmetica?useSSL=false&cloudSqlInstance=kidsaritmetica:europe-west1:kidsaritmetica&socketFactory=com.google.cloud.sql.mysql.SocketFactory&user=juanpsm79&password=5326juan3738");
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
		} catch (Exception ex) {
			ex.printStackTrace();
			return ex.getMessage();
		}
		return tablas.toString();
	}
}