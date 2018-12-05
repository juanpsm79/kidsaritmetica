<%@page import="playaddition.model.Suma"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
String nombreImagen = "GoToLevel"+nivel+".png";
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script>
  var nivel = <%=nivel%>;
  function irNivel(){
	  if(nivel<=13)
			location.href = "plantilla1.jsp";
	  else if(nivel<=22)
			location.href = "plantilla2.jsp";
	  else
			location.href = "plantilla3.jsp";
  }
  
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
  }
  </script>
</head>

  <body>
 		<div style="width:640px;height:100%;background-image:url(<%=nombreImagen%>);background-repeat:no-repeat;float:left">	
		</div>
		
		
		<div style="width:430px;height:100%;float:left;position:relative;left:150px">	
			<div style="position:relative;top:25px;width:100%;height:451px;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 			<div style="position:relative;top:75px;left:98px;cursor:pointer;width:100%;height:167px;background-image:url(playSelectAllLevel.png);background-repeat:no-repeat;" onclick="irNivel()">
 			</div>
 		</div>
 		
  </body>
</html>