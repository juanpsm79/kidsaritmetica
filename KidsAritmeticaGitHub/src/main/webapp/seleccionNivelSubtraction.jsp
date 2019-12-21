<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta http-equiv="Cache-control" content="public">
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDvwi';
 		src: url('BerlinDemi.ttf') format('truetype')
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>
<!-- Add Firebase products that you want to use -->
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-database.js"></script>
  <script src="./js/jquery.flip.min.js"></script>
  <script src="./js/current-device.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-3');
</script>



<!-- Global site tag (gtag.js) - Google Analytics 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-1');
</script>
-->  

  
<script>
var dominio = "test.playaddition.com";
//  var dominio = "playaddition.com";
  var check = false;
  $( function() {
	  var nivelSumaUsuario;
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
		  firebase.database().ref('/users/' + user.uid+'/nivelActualResta').once('value').then (
			function(snapshot) {
				pintarTodosNivelesUsuario(snapshot.val())
		  })
		} else{
			pintarTodosNivelesUsuario(40);
		}
		window.addEventListener("orientationchange", resizePageHandler);
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
	  var html ="<div style=\"position:absolute;top:"+top+";width:75vw;height:7vw\">";
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;top:0vw;width:7vw;height:7vw;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;text-align:center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
	  html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
	  html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center\">";
	  html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);\">";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
	  html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
      html+="</div>";	
	  html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red\">";
	  html+="</div>";
	  html+="</div>";
	  nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
		
      html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\"  style=\"position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
      html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
      html+="</div>";	
      html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red\">";
      html+="</div>";
      html+="</div>";
      nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
		
      html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
      html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
      html+="</div>";	
      html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red\">";
      html+="</div>";
      html+="</div>";
      nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
      html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
      html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
      html+="</div>";	
      html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red\">";
      html+="</div>";
      html+="</div>";
      nivel++;
	  if(nivel>nivelSumaUsuario){
		  html+="</div>";
		  return html;
	  }
      html+="<div id=\""+nivel+"\" onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center\">";
      html+="<div class=\"front\" style=\"position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)\">";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold\">LEVEL</label>";
      html+="<label onclick=\"seleccionarNivel('"+nivel+"')\" style=\"position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold\">"+nivel+"</label>";
      html+="</div>";	
      html+="<div class=\"back\" style=\"position:absolute;background:url("+nivel+"cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:red\">";
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
	  obj.style.backgroundImage="url(playBotonSS.png)";
	  setTimeout(function(){
		  $.ajax({
			  url: "/restas",
			  method: "post",
			  data:{nivel: ''+nivelAnterior},
			 // dataType: "json",
			  success : function(responseText) {
				  location.href = "descripcionSubtraction.jsp";
			  }
			})
		  },500);
	  
		 
}
  
  function seleccionarNivel(idNivel){
	  
	  if(nivelAnterior==idNivel){
		  //alert($("#"+idNivel).isFlipped)
		  return;
	  }
	  document.getElementById(""+idNivel).firstElementChild.nextElementSibling.style.borderColor="red";
	  if(nivelAnterior!=null)
		  document.getElementById(""+nivelAnterior).firstElementChild.nextElementSibling.style.borderColor="rgb(32, 56, 100)";
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
  
  </script>
</head>

  <body onload="seleccionarNivel('1');resizePage()">
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
		</div>
		
		<div style="position:absolute;width:76vw;top:9vw">
			<img src="logoPlaySubtractionMini.png" style="position:absolute;width:18vw;left:71vw">
		</div>

		<div id="capaNiveles" style="position:absolute;width:75vw;top:14.5vw"> 
		<!--
			<div style="position:absolute;top:0vw;width:75vw;height:7vw">
			
	  			<div id="1" onclick="seleccionarNivel('1')" style="position:absolute;cursor:pointer;top:0vw;width:7vw;height:7vw;cursor:pointer;
	  			 text-align:center">
	  			 
	  				<div id="front" class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
								<label onclick="seleccionarNivel('1')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
								<label onclick="seleccionarNivel('1')" style="position:absolute;left:2.5vw;top:2.3vw;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">1</label>
					</div>	
					<div class="back" style="position:absolute;background:url(1cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.4vw;border-color:red">
  					</div>
  					
  					
				</div>
				
				<div id="2" onclick="seleccionarNivel('2')"  style="position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('2')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('2')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">2</label>
					</div>	
					<div class="back" style="position:absolute;background:url(2cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="3" onclick="seleccionarNivel('3')" style="position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('3')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('3')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">3</label>
					</div>	
					<div class="back" style="position:absolute;background:url(3cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="4" onclick="seleccionarNivel('4')" style="position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('4')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('4')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">4</label>
					</div>	
					<div class="back" style="position:absolute;background:url(4cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="5" onclick="seleccionarNivel('5')" style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;
				text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('5')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('5')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">5</label>
					</div>	
					<div class="back" style="position:absolute;background:url(5cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="6" onclick="seleccionarNivel('6')"  style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;
				border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);">
							<label onclick="seleccionarNivel('6')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('6')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">6</label>
					</div>	
					<div class="back" style="position:absolute;background:url(6cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="7" onclick="seleccionarNivel('7')"  style="position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;
				border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('7')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('7')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">7</label>
					</div>	
					<div class="back" style="position:absolute;background:url(7cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="8" onclick="seleccionarNivel('8')" style="position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;
				border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('8')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('8')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">8</label>
					</div>	
					<div class="back" style="position:absolute;background:url(8cs.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="9" onclick="seleccionarNivel('9')" style="position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;
				border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('9')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('9')" style="position:absolute;left:2.5vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">9</label>
					</div>	
					<div class="back" style="position:absolute;background:url(9cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>

				</div>
				
				<div id="10" onclick="seleccionarNivel('10')" style="position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;
				border-width: 0.4vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('10')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('10')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">10</label>
					</div>	
					<div class="back" style="position:absolute;background:url(10cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.4vw 0.4vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

 			</div>
 			
 			<div style="position:absolute;top:7.6vw;width:75vw;height:7vw">
	  			<div id="11" onclick="seleccionarNivel('11')" style="position:absolute;top:0vw;width:7vw;height:7vw;cursor:pointer;
	  			 text-align:center">
	  			 
	  				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
								<label onclick="seleccionarNivel('11')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
								<label onclick="seleccionarNivel('11')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">11</label>
					</div>	
					<div class="back" style="position:absolute;background:url(11cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:red">
  					</div>
  					
  					
				</div>
				
				<div id="12" onclick="seleccionarNivel('12')"  style="position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('12')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('12')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">12</label>
					</div>	
					<div class="back" style="position:absolute;background:url(12cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="13" onclick="seleccionarNivel('13')" style="position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('13')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('13')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">13</label>
					</div>	
					<div class="back" style="position:absolute;background:url(13cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				<div id="14" onclick="seleccionarNivel('14')" style="position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('14')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('14')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">14</label>
					</div>	
					<div class="back" style="position:absolute;background:url(14cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
			

				
				<div id="15" onclick="seleccionarNivel('15')" style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;
				text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('15')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('15')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">15</label>
					</div>	
					<div class="back" style="position:absolute;background:url(15cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="16" onclick="seleccionarNivel('16')"  style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);">
							<label onclick="seleccionarNivel('16')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('16')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">16</label>
					</div>	
					<div class="back" style="position:absolute;background:url(16cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="17" onclick="seleccionarNivel('17')"  style="position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('17')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('17')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">17</label>
					</div>	
					<div class="back" style="position:absolute;background:url(17cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="18" onclick="seleccionarNivel('18')" style="position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('18')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('18')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">18</label>
					</div>	
					<div class="back" style="position:absolute;background:url(18cs.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="19" onclick="seleccionarNivel('19')" style="position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('19')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('19')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">19</label>
					</div>	
					<div class="back" style="position:absolute;background:url(19cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>

				</div>
				
				<div id="20" onclick="seleccionarNivel('20')" style="position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('20')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('20')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">20</label>
					</div>	
					<div class="back" style="position:absolute;background:url(20cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

 			</div>
 			
 			
 			
 			
 			
 			
 			<div style="position:absolute;top:15vw;width:75vw;height:7vw">
			
	  			<div id="21" onclick="seleccionarNivel('21')" style="position:absolute;top:0vw;width:7vw;height:7vw;cursor:pointer;
	  			 text-align:center">
	  			 
	  				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
								<label onclick="seleccionarNivel('21')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
								<label onclick="seleccionarNivel('21')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">21</label>
					</div>	
					<div class="back" style="position:absolute;background:url(21cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:red">
  					</div>
  					
  					
				</div>
				
				<div id="22" onclick="seleccionarNivel('22')"  style="position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('22')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('22')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">22</label>
					</div>	
					<div class="back" style="position:absolute;background:url(22cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="23" onclick="seleccionarNivel('23')" style="position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('23')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('23')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">23</label>
					</div>	
					<div class="back" style="position:absolute;background:url(23cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="24" onclick="seleccionarNivel('24')" style="position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('24')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('24')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">24</label>
					</div>	
					<div class="back" style="position:absolute;background:url(24cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="25" onclick="seleccionarNivel('25')" style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;
				text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('25')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('25')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">25</label>
					</div>	
					<div class="back" style="position:absolute;background:url(25cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="26" onclick="seleccionarNivel('26')"  style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);">
							<label onclick="seleccionarNivel('26')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('26')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">26</label>
					</div>	
					<div class="back" style="position:absolute;background:url(26cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="27" onclick="seleccionarNivel('27')"  style="position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('27')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('27')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">27</label>
					</div>	
					<div class="back" style="position:absolute;background:url(27cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="28" onclick="seleccionarNivel('28')" style="position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('28')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('28')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">28</label>
					</div>	
					<div class="back" style="position:absolute;background:url(28cs.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="29" onclick="seleccionarNivel('29')" style="position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('29')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('29')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">29</label>
					</div>	
					<div class="back" style="position:absolute;background:url(29cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.2vw 0.2vw;border-color:red">
  					</div>

				</div>
				
				<div id="30" onclick="seleccionarNivel('30')" style="position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('30')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('30')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">30</label>
					</div>	
					<div class="back" style="position:absolute;background:url(30cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:red">
  					</div>
				</div>

 			</div>
 			
 			
 			
 			
 			
 			<div style="position:absolute;top:22.3vw;width:75vw;height:7vw">
			
	  			<div id="31" onclick="seleccionarNivel('31')" style="position:absolute;top:0vw;width:7vw;height:7vw;cursor:pointer;
	  			 text-align:center">
	  			 
	  				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.4vw;border-color:rgb(32, 56, 100)">
								<label onclick="seleccionarNivel('31')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
								<label onclick="seleccionarNivel('31')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">31</label>
					</div>	
					<div class="back" style="position:absolute;background:url(31cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.4vw;border-color:red">
  					</div>
  					
  					
				</div>
				
				<div id="32" onclick="seleccionarNivel('32')"  style="position:absolute;left:7.6vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('32')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('32')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">32</label>
					</div>	
					<div class="back" style="position:absolute;background:url(32cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="33" onclick="seleccionarNivel('33')" style="position:absolute;left:15vw;top:0vw;width:7vw;height:7vw;cursor:pointer;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('33')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('33')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">33</label>
					</div>	
					<div class="back" style="position:absolute;background:url(33cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="34" onclick="seleccionarNivel('34')" style="position:absolute;left:22.4vw;top:0vw;width:7vw;height:7vw;cursor:pointer;
				text-align:center">
				
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('34')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('34')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">34</label>
					</div>	
					<div class="back" style="position:absolute;background:url(34cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="35" onclick="seleccionarNivel('35')" style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:29.8vw;
				text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('35')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('35')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">35</label>
					</div>	
					<div class="back" style="position:absolute;background:url(35cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="36" onclick="seleccionarNivel('36')"  style="position:absolute;cursor:pointer;width:7vw;height:7vw;left:37.2vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);">
							<label onclick="seleccionarNivel('36')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('36')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">36</label>
					</div>	
					<div class="back" style="position:absolute;background:url(36cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				
				<div id="37" onclick="seleccionarNivel('37')"  style="position:absolute;left:44.6vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('37')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('37')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">37</label>
					</div>	
					<div class="back" style="position:absolute;background:url(37cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>

				
				<div id="38" onclick="seleccionarNivel('38')" style="position:absolute;left:52vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('38')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('38')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">38</label>
					</div>	
					<div class="back" style="position:absolute;background:url(38cs.png);background-repeat:no-repeat;background-size:7vw 7vw;width:7vw;height:7vw;border:solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>
				
				<div id="39" onclick="seleccionarNivel('39')" style="position:absolute;left:59.4vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('39')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('39')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">39</label>
					</div>	
					<div class="back" style="position:absolute;background:url(39cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.3vw 0.4vw 0.2vw;border-color:red">
  					</div>

				</div>
				
				<div id="40" onclick="seleccionarNivel('40')" style="position:absolute;left:66.8vw;cursor:pointer;width:7vw;height:7vw;text-align: center">
				<div class="front" style="position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormalSubtraction.png);border: solid;border-width: 0.2vw 0.4vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100)">
							<label onclick="seleccionarNivel('40')" style="position:absolute;left:1vw;top:0.8vw;cursor:pointer;color:white;font-family:Calibri;font-size:1.7vw;font-weight:bold">LEVEL</label>
							<label onclick="seleccionarNivel('40')" style="position:absolute;left:1.25vw;top:2.3vw;cursor:pointer;color:white;font-family:Calibri;font-size:4vw;font-weight:bold">40</label>
					</div>	
					<div class="back" style="position:absolute;background:url(40cs.png);background-repeat:no-repeat;width:7vw;height:7vw;background-size:7vw 7vw;border:solid;border-width: 0.2vw 0.4vw 0.4vw 0.2vw;border-color:red">
  					</div>
				</div>

 			</div>
 			-->
 		</div>
 		
 		<div style="position:absolute;width:14vw;top:1vw;left:85vw">
 			<div onclick="irPresentacion(this)" onmouseout="this.style.backgroundImage='url(aspaCerrarSelectYourLevel.png)'" onmouseover="this.style.backgroundImage='url(aspaCerrarSelectYourLevelSelect.png)'" style="background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;background-size:7vw 7vw;position:absolute;width:7vw;height:7vw;cursor:pointer;right:3vw"></div>
 			<div id= "playSelectAllLevel" onclick="javascript:irPrincipal(this)" style="background-image:url(playBoton.png);background-repeat:no-repeat;background-size:12vw 9vw;position:absolute;right:3vw;top:34.5vw;cursor:pointer;width:12vw;height:9vw" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'"></div>
 		</div>
  </body>
</html>