package playaddition;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.common.collect.Lists;

@WebServlet(name = "TokenGenerator", urlPatterns = { "/getToken" })
public class TokenGenerator extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		try {
		 GoogleCredentials utilCredentials =  GoogleCredentials.fromStream(this.getClass().getResourceAsStream("playaddition-317446f475bf.json"))
		            .createScoped(Lists.newArrayList("https://www.googleapis.com/auth/analytics.readonly"));
		            AccessToken accessToken = utilCredentials.refreshAccessToken();
			StringBuilder resultado = new StringBuilder();
			System.out.println(accessToken.getTokenValue());
			resultado.append("{\"token\": \"" + accessToken.getTokenValue() + "\"}");
			response.getWriter().write(resultado.toString());
		
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}

	
}