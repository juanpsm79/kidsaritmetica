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
  	#preload-01 { background: url(http://test.playaddition.com/playBottonSelected.png) no-repeat -9999px -9999px; }
	#preload-02 { background: url(http://test.playaddition.com/playBotonSS.png) no-repeat -9999px -9999px; }
	#preload-03 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevel.png) no-repeat -9999px -9999px; }
	#preload-04 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevelSelect.png) no-repeat -9999px -9999px; }
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/jquery/jquery-ui.min.js"></script>
  <script src="./js/screenfull.js"></script>
  <script src="./js/current-device.min.js"></script>
  <script>
var dominio = "test.playaddition.com";
//  var dominio = "playaddition.com";
  var nivel = <%=nivel%>;
  
  $( function() {
	     window.addEventListener("orientationchange", resizePage);
	   
});
  function irNivel(obj){
	  obj.style.backgroundImage="url(playBotonSS.png)";
	  setTimeout(function(){
		  if(nivel<=11)
				location.href = "plantilla111.jsp";
		  else if(nivel==12 || nivel==13)
				location.href = "plantilla1.jsp";
		  else if(nivel<=22)
				location.href = "plantilla2.jsp";
		  else
				location.href = "plantilla3.jsp";
		  },500);
  }
  
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
  }
  
  function resizePage(){
	 if(device.type=='tablet' || device.type=='mobile'){
		 document.getElementById("pantallaCompletaDiv").style.visibility="visible";
	 }
  }
  
  function fullscreen(obj){
		if(obj.style.backgroundImage=="url(\"maximize-512.png\")"){
			screenfull.request();
			obj.style.backgroundImage="url(minimize-512.png)"
		} else {
			screenfull.exit();
			obj.style.backgroundImage="url(maximize-512.png)"
		}
	}
</script>


<!-- Global site tag (gtag.js) - Google Analytics
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-3');
</script>
 -->


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-1');
</script>
  

  
</head>

  <body onload="resizePage()">
  <div class="hidden">
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
			if (document.images) {
				var img1 = new Image();
				var img2 = new Image();
				var img3 = new Image();
				img1.src = "https://"+dominio+"/playBottonSelected.png";
				img2.src = "https://"+dominio+"/playBotonSS.png";
				img3.src = "https://"+dominio+"/aspaCerrarSelectYourLevelSelect.png";
			}

		//--><!]]>
		</script>
	</div>
 		<div style="position:absolute;left:10vw;width:40vw;height:46vw;background-size:40vw 45vw;background-image:url(<%=nombreImagen%>);background-repeat:no-repeat">	
		</div>
		
		
		<div style="position:absolute;width:30vw;left:68vw">
			<div id="botonSalir" onclick="irPrincipal()" onmouseout="this.style.backgroundImage='url(aspaCerrarSelectYourLevel.png)'" onmouseover="this.style.backgroundImage='url(aspaCerrarSelectYourLevelSelect.png)'" 
			     style="top:2vw;width:9vw;height:8vw;position:absolute;left:10vw;background-size:8vw 7vw;
					background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;cursor:pointer">
 			</div>
 			<div id="pantallaCompletaDiv" onclick="fullscreen(this)" style="visibility:hidden;position:absolute;left:26vw;cursor:pointer;width:5vw;height:5vw;background-size:5vw 5vw;background-repeat:no-repeat">
 				<div style="border:0px;right:0vw;cursor:pointer;width:5vw;height:4vw;background-color:white;background-size:5vw 4vw;background-repeat:no-repeat;background-image:url(maximize-512.png)" onclick="fullscreen(this)"></div>	
		    </div>	
			<div style="top:9.5vw;width:20vw;height:30vw;position:absolute;background-size:18vw 28vw;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 				
 			<% if(nivel.equalsIgnoreCase("1") || nivel.equalsIgnoreCase("2") || nivel.equalsIgnoreCase("3") || nivel.equalsIgnoreCase("4") ||
 					nivel.equalsIgnoreCase("5") || nivel.equalsIgnoreCase("6") || nivel.equalsIgnoreCase("7") || nivel.equalsIgnoreCase("8") ||
 					nivel.equalsIgnoreCase("9") || nivel.equalsIgnoreCase("10") || nivel.equalsIgnoreCase("11") || nivel.equalsIgnoreCase("12")){%>
 				<div onclick="javascript:window.open('https://storage.googleapis.com/testplayaddition.appspot.com/play_<%=nivel%>.mp4', '_blank', 'toolbar=no,scrollbars=no,resizable=no,top=150,left=300,width=600,height=400');" style="width:8.5vw;height:6.5vw;position:absolute;left:0.5vw;cursor:pointer;background-size:8.5vw 6.5vw;top:38.25vw;background-image:url(howToplay.png);background-repeat:no-repeat"></div>
 			<%}%>
 			<div id= "playSelectAllLevel" onclick="javascript:irNivel(this)" style="width:10vw;height:8vw;position:absolute;left:10vw;cursor:pointer;background-size:9vw 7vw;top:38vw;background-image:url(playBoton.png);background-repeat:no-repeat" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'"></div>
 		</div>
 		
  </body>
</html>