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

	private static final int MAX_COLISIONES = 200;
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
				sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
				resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
						+ nuevaSuma.getOperando2() + "\"},");
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"" + leyenda + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
			response.getWriter().write(resultado.toString());
		} else if (nivel==13) {
			int contador10 = 0;
			int contador11 = 0;
			int contador12 = 0;
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				int nivelAleatorio = new Random().ints(1, 10, 12).sum();
				switch (nivelAleatorio) {
					case 10:
						contador10++;
						nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel,
								colisiones, MAX_COLISIONES);
						sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
						resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
								+ nuevaSuma.getOperando2() + "\"},");
						break;
					case 11:
						contador11++;
						nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel,
								colisiones, MAX_COLISIONES);
						sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
						resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
								+ nuevaSuma.getOperando2() + "\"},");
						break;
					case 12:
						contador12++;
						nuevaSuma = generador.obtenerSumaNivel(sumasNiveles.get(request.getParameter("nivel")), nivel,
								colisiones, MAX_COLISIONES);
						sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
						resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
								+ nuevaSuma.getOperando2() + "\"},");
						break;
				}
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 10 :" + contador10 + ", Level 11 :" + contador11 + ", Level 12 :" + contador12 + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
			response.getWriter().write(resultado.toString());
		} else if (nivel == 17) {
			int contador14 = 0;
			int contador15 = 0;
			int contador16 = 0;
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				int nivelAleatorio = new Random().ints(1, 14, 17).sum();
				switch (nivelAleatorio) {
				case 14:
					contador14++;
					nuevaSuma = generador.getOperandosNivel14(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 15:
					contador15++;
					nuevaSuma = generador.getOperandosNivel15(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 16:
					contador16++;
					nuevaSuma = generador.getOperandosNivel16(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				}
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 14 :" + contador14 + ", Level 15 :" + contador15 + ", Level 16 :" + contador16 + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
			response.getWriter().write(resultado.toString());
		} else if (nivel == 22) {
			int contador18 = 0;
			int contador19 = 0;
			int contador20 = 0;
			int contador21 = 0;
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				int nivelAleatorio = new Random().ints(1, 18, 22).sum();
				switch (nivelAleatorio) {
				case 18:
					contador18++;
					nuevaSuma = generador.getOperandosNivel18(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 19:
					contador19++;
					nuevaSuma = generador.getOperandosNivel19(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 20:
					contador20++;
					nuevaSuma = generador.getOperandosNivel20(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 21:
					contador21++;
					nuevaSuma = generador.getOperandosNivel21(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				}
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 18 :" + contador18 + ", Level 19 :" + contador19 + ", Level 20 :" + contador20 + ", Level 21 :" + contador21 + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
			response.getWriter().write(resultado.toString());
		} else if (nivel == 25) {
			int contador23 = 0;
			int contador24 = 0;
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				int nivelAleatorio = new Random().ints(1, 23, 25).sum();
				switch (nivelAleatorio) {
				case 23:
					contador23++;
					nuevaSuma = generador.getOperandosNivel23(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 24:
					contador24++;
					nuevaSuma = generador.getOperandosNivel24(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				}
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 23 :" + contador23 + ", Level 24 :" + contador24 + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
			response.getWriter().write(resultado.toString());
		} else if (nivel == 32) {
			int contador26 = 0;
			int contador27 = 0;
			int contador28 = 0;
			int contador29 = 0;
			int contador30 = 0;
			int contador31 = 0;
			StringBuilder resultado = new StringBuilder("{\"sumas\":[");
			while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
				int nivelAleatorio = new Random().ints(1, 26, 32).sum();
				switch (nivelAleatorio) {
				case 26:
					contador26++;
					nuevaSuma = generador.getOperandosNivel26(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 27:
					contador27++;
					nuevaSuma = generador.getOperandosNivel27(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 28:
					contador28++;
					nuevaSuma = generador.getOperandosNivel28(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 29:
					contador29++;
					nuevaSuma = generador.getOperandosNivel29(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 30:
					contador30++;
					nuevaSuma = generador.getOperandosNivel30(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				case 31:
					contador31++;
					nuevaSuma = generador.getOperandosNivel31(sumasNiveles.get(request.getParameter("nivel")),
							colisiones, MAX_COLISIONES);
					sumasNiveles.get(request.getParameter("nivel")).add(nuevaSuma);
					resultado.append("{\"resultado\": \"" + nuevaSuma.getResultadoSuma() + "\",\"operador1\": \"" + nuevaSuma.getOperando1() + "\",\"operador2\": \""
							+ nuevaSuma.getOperando2() + "\"},");
					break;
				}
			}
			resultado.deleteCharAt(resultado.lastIndexOf(","));
			resultado.append("], \"leyenda\": \"Level 26 :" + contador26 + ", Level 27 :" + contador27 + ", Level 28 :" + contador28 + ", Level 29 :" + contador29 + ", Level 30 :" + contador30 + ", Level 31 :" + contador31 + "\"}");
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			/*sumasNiveles.get(request.getParameter("nivel"))
					.sort(Comparator.comparingInt(Suma::getResultadoSuma).reversed());*/
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
			//while (sumasNiveles.get(request.getParameter("nivel")).size() < NUMSUMAS) {
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