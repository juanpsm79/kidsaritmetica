<%@page import="playaddition.model.Suma"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
String nombreImagen = "GoToLevel"+nivel+".png";
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
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
  <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-131500537-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-131500537-1');
</script>
  
</head>

  <body>
 		<div style="position:absolute;left:10vw;width:50vw;height:70vw;background-size:50vw 60vw;background-image:url(<%=nombreImagen%>);background-repeat:no-repeat;float:left">	
		</div>
		
		
		<div style="position:absolute;width:30vw;left:65vw">	
			<div style="top:2vw;width:30vw;height:35vw;position:absolute;background-size:25vw 35vw;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 			<div style="width:30vw;height:13vw;position:absolute;cursor:pointer;background-size:15vw 13vw;top:45vw;background-image:url(playSelectAllLevel.png);background-repeat:no-repeat" onclick="irNivel()">
 			</div>
 		</div>
 		
  </body>
</html>