package playaddition;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import playaddition.model.Usuario;


@WebServlet(name = "LoginServlet", urlPatterns = { "/loginUser" })
public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
		 Usuario usuario = new Usuario();
		 
		 usuario.setId(request.getParameter("loginId"));
		 usuario.setLoginUsuario(request.getParameter("loginuser"));
		 request.getSession().setAttribute("usuario", usuario);
		 request.getRequestDispatcher("/presentacion.jsp").forward(request, response);
		
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}

	
}
