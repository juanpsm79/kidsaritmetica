<%@ page import="java.io.*,
                 java.net.*,
                 java.util.*" %>
<%
Locale locale = request.getLocale();
ResourceBundle RB = ResourceBundle.getBundle("Messages", locale);
String sNivel = RB.getString("nivel").toUpperCase();
String verTodosNiveles = RB.getString("verTodosNiveles");
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta http-equiv="Cache-control" content="public">
  <title>PlayAddition</title>
  <style type="text/css">
  
  	#preload-01 { background: url(http://test.playaddition.com/playBottonSelected.png) no-repeat -9999px -9999px; }
	#preload-02 { background: url(http://test.playaddition.com/playBotonSS.png) no-repeat -9999px -9999px; }
	#preload-03 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevel.png) no-repeat -9999px -9999px; }
	#preload-04 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevelSelect.png) no-repeat -9999px -9999px; }
	
	
  	@font-face{
	 	font-family:'BerlinDvwi';
 		src: url('BerlinDemi.ttf') format('truetype')
	}
  </style>
<script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/screenfull.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
<!-- Add Firebase products that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-database.js"></script>
  
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
 

  <script src="./js/jquery.flip.min.js"></script>
<script src="./js/current-device.min.js"></script>
  
  <script>
  var dominio = "test.playaddition.com";
  //var dominio = "playaddition.com";
  var check = false;
  var nivelSumaUsuario;
  $( function() {
	  window.addEventListener("orientationchange", resizePageHandler);
	  document.getElementById("capaNiveles").style.backgroundImage="url(loading.gif)";
      document.getElementById("capaNiveles").style.width="3vw";
      document.getElementById("capaNiveles").style.height="3vw"
      document.getElementById("capaNiveles").style.backgroundSize="3vw 3vw";
	  var firebaseConfig = {
			    apiKey: "AIzaSyDxPBEOIlqaXki7LVRLLVunVrwWmLXiyBQ",
			    authDomain: "fbplayaddition.firebaseapp.com",
			    databaseURL: "https://fbplayaddition.firebaseio.com",
			    projectId: "fbplayaddition",
			    storageBucket: "fbplayaddition.appspot.com",
			    messagingSenderId: "945530212708",
			    appId: "1:945530212708:web:38ba814515a7a3c0376a71",
			    measurementId: "G-LLPNBP9S9B"
	  };
	  firebase.initializeApp(firebaseConfig);
	  firebase.auth().onAuthStateChanged(function(user) { 
		if (user!=null) {
		  firebase.database().ref('/users/' + user.uid+'/nivelActualSuma').once('value').then (
			function(snapshot) {
				pintarTodosNivelesUsuario(snapshot.val());
		  })
		}else{
			pintarTodosNivelesUsuario(40);
		}
  	  }); 
  });
  
  function pintarTodosNivelesUsuario (nivelSumaUsuario){
	  var html;
	  if(nivelSumaUsuario<=10){
		  html=pintaNiveles("0vw",1, nivelSumaUsuario)
		  document.getElementById("capaNiveles").innerHTML = html; 
	  }else if (nivelSumaUsuario<=20){
		  html= pintaNiveles("0vw",1, nivelSumaUsuario)
		  html+=pintaNiveles("7.4vw",11, nivelSumaUsuario)
		  document.getElementById("capaNiveles").innerHTML = html; 
	  }else if (nivelSumaUsuario<=30){
		  html=pintaNiveles("0vw",1, nivelSumaUsuario)
		  html+=pintaNiveles("7.4vw",11, nivelSumaUsuario)
		  html+=pintaNiveles("14.8vw",21, nivelSumaUsuario)
		  document.getElementById("capaNiveles").innerHTML = html; 
	  }else if (nivelSumaUsuario<=40){
		  html=pintaNiveles("0vw",1, nivelSumaUsuario)
		  html+=pintaNiveles("7.4vw",11, nivelSumaUsuario)
		  html+=pintaNiveles("14.8vw",21, nivelSumaUsuario)
		  html+=pintaNiveles("22.1vw",31, nivelSumaUsuario)
		  document.getElementById("capaNiveles").innerHTML = html; 
	  }
	  for (i = 1; i <= nivelSumaUsuario; i++)
		    $("#"+i).flip({axis: 'y',trigger: 'click', reverse: true});
	  for (i = 1; i <= nivelSumaUsuario; i++)
	     document.getElementById(''+i).style.position="absolute";  
	  
  }
  function pintaNiveles(top, nivel, nivelSumaUsuario){
	  var html ="<div style='position:absolute;top:"+top+";width:75vw;height:7vw'>";
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;top:0vw;width:7vw;height:7vw;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if (nivel<10)
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if (nivel<10)
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
		html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>"; 
	  html+="</div>";
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0);\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  if(nivel<10)
		  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:2vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  else
	  	html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png);border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(126, 0, 0)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\"><%= sNivel %></label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"c.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(91, 155, 213)\">";
	  html+="</div>";
	  html+="</div>";

	  html+="</div>";
	  return html;
  }

  var nivelAnterior =null;
  
  function irPresentacion(){
	  	 
		 location.href = "presentacion.jsp"
  }
  
  function irPrincipal(obj){
	  if(obj!=null)
	  	obj.style.backgroundImage="url(playBotonSS.png)";
	  setTimeout(function(){
		  $.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+nivelAnterior},
			 // dataType: "json",
			  success : function(responseText) {
					location.href = "descripcionNivel.jsp";
			  }
			})
		  },500);
	  
		 
}
  
  function seleccionarNivel(idNivel){
	  if(nivelAnterior==idNivel)
		  return;
	  document.getElementById(""+idNivel).firstElementChild.nextElementSibling.style.borderColor="rgb(91, 155, 213)";
	  if(nivelAnterior!=null)
		  document.getElementById(""+nivelAnterior).firstElementChild.nextElementSibling.style.borderColor="rgb(126, 0, 0)";
	  nivelAnterior = idNivel;
  }
  
  var docLevelsWindow;
	
  function openDoc(){
	  docLevelsWindow = window.open("./selectAllLevels.jsp")
  }
  
  function callback(nivel){
	  
	  nivelAnterior = nivel;
	  docLevelsWindow.close();
	  irPrincipal();
  }
  
  function resizePageHandler(){
	  resizePage();
  }
  
  function resizePage(){
	 if(device.type=='tablet' || device.type=='mobile'){
		 document.getElementById("pantallaCompletaDiv").style.left="83vw";
		 document.getElementById("pantallaCompleta").style.visibility="visible";
		 document.getElementById("botonSalir").style.right="5vw";
	     if (window.orientation == 90 || window.orientation == -90) { //landscape Mode
	      	  	document.getElementById('seeAllLevels').style.top="11vw";
	   			document.getElementById('capaNiveles').style.top="18vw";
				document.getElementById('playSelectAllLevel').style.top="38vw";
				document.getElementById('selectYourLevel').style.width="50vw";
	     }else { //0 ->Portrait Mode
	    	  	document.getElementById('seeAllLevels').style.top="11vw";
				document.getElementById('capaNiveles').style.top="20vw";
				document.getElementById('playSelectAllLevel').style.top="40vw";
	   	 }
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
  
  /* View in fullscreen */
  function openFullscreen() {
    if (document.body.requestFullscreen) {
    	document.body.requestFullscreen();
    } else if (document.body.mozRequestFullScreen) { /* Firefox */
    	document.body.mozRequestFullScreen();
    } else if (document.body.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
    	document.body.webkitRequestFullscreen();
    } else if (document.body.msRequestFullscreen) { /* IE/Edge */
    	document.body.msRequestFullscreen();
    }
  }

  /* Close fullscreen */
  function closeFullscreen() {
    if (document.body.exitFullscreen) {
    	document.body.exitFullscreen();
    } else if (document.body.mozCancelFullScreen) { /* Firefox */
    	document.body.mozCancelFullScreen();
    } else if (document.body.webkitExitFullscreen) { /* Chrome, Safari and Opera */
    	document.body.webkitExitFullscreen();
    } else if (document.body.msExitFullscreen) { /* IE/Edge */
    	document.body.msExitFullscreen();
    }
  }
  
  </script>
</head>

  <body onload="resizePage();seleccionarNivel('1')">
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
  
		<div style="position:absolute;width:50vw;min-height:35vh">
			<img id="selectYourLevel" src="selectLevel.png" style="position:absolute;width:68vw;height:12vw">
			  
			<a id="seeAllLevels" onclick="openDoc()" style="position:absolute;top:11.35vw;left:1vw"><label style="text-decoration: underline;font-family:BerlinDvwi;font-size:2.3vw;color:rgb(46, 117, 182);cursor:pointer"><%= verTodosNiveles %></label></a>
			
		</div>
		
		<div style="position:absolute;width:76vw;top:6vw">
			<img src="logoPlayAdditionMini.png" style="position:absolute;width:15vw;left:71vw">
		</div>

		<div id="capaNiveles" style="position:absolute;width:75vw;top:14.5vw">
 		</div>
 		
 		<div id="pantallaCompletaDiv" style="position:absolute;width:14vw;top:1vw;left:85vw">
 			<div id="botonSalir" onclick="irPresentacion(this)" onmouseout="this.style.backgroundImage='url(aspaCerrarSelectYourLevel.png)'" onmouseover="this.style.backgroundImage='url(aspaCerrarSelectYourLevelSelect.png)'"  style="background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;background-size:7vw 7vw;position:absolute;width:7vw;height:7vw;cursor:pointer;right:3vw"></div>
 			<div id="pantallaCompleta" style="visibility:hidden;position:absolute;left:11vw;cursor:pointer;width:5vw;height:5vw;background-size:5vw 5vw;background-repeat:no-repeat" onclick="fullscreen(this)">
 				<button  style="border:0px;right:0vw;cursor:pointer;width:5vw;height:4vw;background-color:white;background-size:5vw 4vw;background-repeat:no-repeat;background-image:url(maximize-512.png)" onclick="fullscreen(this)"></button>	
		    </div>
 			
 			<div id= "playSelectAllLevel" onclick="javascript:irPrincipal(this)" style="background-image:url(playBoton.png);background-repeat:no-repeat;background-size:12vw 9vw;position:absolute;right:3vw;top:34.5vw;cursor:pointer;width:12vw;height:9vw" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'"></div>
 		</div>
  </body>
</html>