package playaddition;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentCatalog;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;


/**
 * Servlet implementation class DescargaFichero
 */
@WebServlet("/DescargaFichero")
public class DescargaFichero extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DescargaFichero() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("accion")!=null && request.getParameter("accion").equalsIgnoreCase("datos")) {
        	response.setContentType("application/json");
        	introducirDatosSession(request);
        	response.getWriter().write("{\"resultado\":1}");
        }
    }

	private void introducirDatosSession(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		int alumnos=0;
		for (int i=1;i<=30;i++) {
			if(request.getParameter("usu"+i).length()>0) {
				alumnos++;
				sesion.setAttribute("usu"+i, request.getParameter("usu"+i));
				sesion.setAttribute("pass"+i, request.getParameter("pass"+i));
			}
		}
		if(alumnos<=19) {
			sesion.setAttribute("pdf","playAdditionListadoClaseCorta.pdf");
		}else {
			sesion.setAttribute("pdf","playAdditionListadoClase.pdf");
		}
		sesion.setAttribute("password", request.getParameter("password"));
	}
	
	protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
    	Locale currentLocale = request.getLocale();
    	response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=List.pdf");
        ServletOutputStream stream = response.getOutputStream();
        InputStream input = this.getClass().getResourceAsStream((String)sesion.getAttribute("pdf"));
        PDDocument document = PDDocument.load(input);
        PDDocumentCatalog docCatalog = document.getDocumentCatalog();
        PDAcroForm acroForm = docCatalog.getAcroForm();
   
        PDField field = acroForm.getField("listadoClase");
        if(currentLocale.getLanguage()=="es")
        	field.setValue("Listado de alumnos");
        else if(currentLocale.getLanguage()=="en")
        	field.setValue("List of students");
        field.setReadOnly(true);
        
        field = acroForm.getField("usuario");
        if(currentLocale.getLanguage()=="es")
        	field.setValue("Usuario");
        else if(currentLocale.getLanguage()=="en")
        	field.setValue("Username");
        field.setReadOnly(true);
        
        field = acroForm.getField("password");
        if(currentLocale.getLanguage()=="es")
        	field.setValue("Contraseña");
        else if(currentLocale.getLanguage()=="en")
        	field.setValue("Password");
        field.setReadOnly(true);
        
        for (int i=1;i<=30;i++) {
        	if(sesion.getAttribute("usu"+i)!=null) {
        		field = acroForm.getField("usu"+i);
        		if(field!=null) {
        			field.setValue((String)sesion.getAttribute("usu"+i));
	        		field.setReadOnly(true);
        		}
	        	field = acroForm.getField("pass"+i);
	        	if(field!=null) {
	        		field.setValue((String)sesion.getAttribute("pass"+i));
	        		field.setReadOnly(true);
	        	}
        	}else {
        		field = acroForm.getField("usu"+i);
        		if(field!=null)
        			field.setReadOnly(true);
        		field = acroForm.getField("pass"+i);
        		if(field!=null)
        			field.setReadOnly(true);
        	}
        }
        document.save(stream);
        stream.flush();
        stream.close();
	}
}
