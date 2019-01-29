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
 		<div style="position:absolute;left:10vw;width:40vw;height:46vw;background-size:40vw 45vw;background-image:url(<%=nombreImagen%>);background-repeat:no-repeat">	
		</div>
		
		
		<div style="position:absolute;width:30vw;left:55vw">
			<div onclick="irPrincipal()" style="top:2vw;width:30vw;height:13vw;position:absolute;background-size:8vw 7vw;background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;cursor:pointer">
 			</div>	
			<div style="top:9.5vw;width:20vw;height:30vw;position:absolute;background-size:18vw 28vw;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 			<div style="width:10vw;height:8vw;position:absolute;cursor:pointer;background-size:9vw 7vw;top:38vw;background-image:url(playSelectAllLevel.png);background-repeat:no-repeat" onclick="javascript:irNivel()">
 			</div>
 		</div>
 		
  </body>
</html>