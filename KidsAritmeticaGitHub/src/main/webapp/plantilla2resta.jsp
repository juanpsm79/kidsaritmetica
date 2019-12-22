<%@page import="playaddition.model.Resta"%>
<%@ page import="java.io.*,
                 java.net.*,
                 java.util.*" %>
<%
Locale locale = request.getLocale();
ResourceBundle RB = ResourceBundle.getBundle("Messages", locale);
String sNivel = RB.getString("nivel").toUpperCase();
String verTodosNiveles = RB.getString("verTodosNiveles");
String nivel =  (String) session.getAttribute("nivel");
List<Resta>  restas = (List<Resta>) session.getAttribute("restas");
boolean assistance = (Boolean)session.getAttribute("assistance");
boolean wa = (Boolean)session.getAttribute("wa");
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta http-equiv="Cache-control" content="public">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>PlayAddition</title>
  <style>
  	#preload-03 { background: url(http://test.playaddition.com/checkBoton.png) no-repeat -9999px -9999px; }
	#preload-04 { background: url(http://test.playaddition.com/checkBotonClick.png) no-repeat -9999px -9999px; }
	#preload-05 { background: url(http://test.playaddition.com/startOverBoton.png) no-repeat -9999px -9999px; }
	#preload-06 { background: url(http://test.playaddition.com/levelUpBoton.png) no-repeat -9999px -9999px; }
	#preload-07 { background: url(http://test.playaddition.com/correctBoton.png) no-repeat -9999px -9999px; }
   @font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
   @font-face{
	 	font-family:'digital7';
 		src: url('digital7.ttf');
	}
	
	@font-face{
	 	font-family:'digital7mono';
 		src: url('digital7Mono.ttf');
	}
	
  a {
	    font-family:"Berlin Sans FB Demi";  
	    color:rgb(0, 112, 192);
	    font-size: 28px;
	    cursor: pointer;
	}
	
	.unselectable {
	    -moz-user-select: -moz-none;
	    -khtml-user-select: none;
	    -webkit-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
  
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>
	<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-auth.js"></script>
	<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-database.js"></script>
  
  
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
var nivelUsuario = null;
var nivel = <%=nivel%>;
var assistanceMode = <%=wa%>;
var assistance = <%=assistance%>;
var dominio = "test.playaddition.com";
var usuario;
$(function(){
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
		 usuario = user
		 firebase.database().ref('/users/' + user.uid+'/nivelActualResta').once('value').then (
			function(snapshot) {
				nivelUsuario = snapshot.val();
	     })
	 }
  }); 
});
	
  
  var sumas = [];
  var indexSuma = -1;
 <%
   int sumasNecesarias = 10;
 if(nivel.equalsIgnoreCase("5") || nivel.equalsIgnoreCase("11") || nivel.equalsIgnoreCase("18")
		 ||nivel.equalsIgnoreCase("14") || nivel.equalsIgnoreCase("18") || nivel.equalsIgnoreCase("22") || nivel.equalsIgnoreCase("26"))
	  			sumasNecesarias = 15;
   Iterator<Resta> iter = restas.iterator();
   int i = 0;
   while(iter.hasNext()){
	   Resta suma = iter.next();%>
 	 sumas[<%=i%>] = {operador1:"<%=suma.getOperando1()%>", operador2:"<%=suma.getOperando2()%>", resultado:"<%=suma.getResultadoResta()%>", nivel:"<%=suma.getNivel()%>"};
  <%i++;}%>
	
  function subirNivel() {
		$.ajax({
			  url: "/restas",
			  method: "post",
			  data:{nivel: ''+nivel, accion:'subirNivel'},
			  success : function(responseText) {
				  location.href = "descripcionSubtraction.jsp";
			  }  
			});
	}
  

	function calcularSuma() {
		indexSuma++
		 if(sumas[indexSuma].operador1<10){
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1;
			 document.getElementById('decenasCifra1').innerHTML = "";
			// document.getElementById("unidadesCifra1").style.left = "84px";
		 }else {
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(1);
			 document.getElementById('decenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(0);
		 }
		
		 if(sumas[indexSuma].operador2<10){
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2;
			 document.getElementById('decenasCifra2').innerHTML = "";
			 //document.getElementById("unidadesCifra2").style.left = "84px";
		 }else {
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(1);
			 document.getElementById('decenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(0);
		 }
		 
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
		 //document.getElementById('sumaCentenasCifra').innerHTML ="";
		 
		 document.getElementById('sumaUnidadesCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaDecenasCifra').style.color="rgb(0,110,188)";
		// document.getElementById('sumaCentenasCifra').style.color="rgb(0,110,188)";
		assistance = true;
		
		 
		 <%if(nivel.equalsIgnoreCase("12") || nivel.equalsIgnoreCase("15") || nivel.equalsIgnoreCase("13")|| nivel.equalsIgnoreCase("14")
				 || nivel.equalsIgnoreCase("19") || nivel.equalsIgnoreCase("23")){%>
		 		document.getElementById("casillaLlevada").style.visibility="hidden";
		 		document.getElementById("decenasCifra1").style.cursor="default";
		 		assistance = false;
		  <%}%>
	     
	     document.getElementById("casillaLlevada").style.borderStyle = "none";
		 document.getElementById('cifraCasillaLlevada').innerHTML="";
		 
		 document.getElementById("tachada").style.visibility="hidden";
	  	 document.getElementById("eluno").style.visibility="hidden";
	     setSelected ("sumaUnidades");
	     
	}
	
	function asyncCall() {
		if(sumasActuales<<%=sumasNecesarias%>) {
	  		calcularSuma();
	  		document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
	  		bloquearInteracciones = false;
		}else {
			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(levelUpBoton.png)";
	  		nivelIniciado = false;
	  		nivel++;
	  		if(usuario!=null && usuario.uid!=null && nivel>nivelUsuario)
  		    	firebase.database().ref('users/' + usuario.uid).update({"nivelActualResta":nivel});
	  		document.getElementById('capaBotonCheckSuma').onclick=function(){subirNivel()}
	  		document.body.onkeydown = function(evObject){
	  			if(window.event)
	  		  	      var keyCode = window.event.keyCode;       // IE
	  		  	else
	  		  	      var keyCode = evObject.which;
  		  		if (keyCode==13)
  		  			subirNivel();
  			};
		}
	}

  
  
  function comprobarSuma(){
	  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBotonClick.png)';
	  if(document.getElementById('sumaUnidadesCifra').innerHTML=='' || document.getElementById('sumaUnidadesCifra').innerHTML==null ) {
		  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBoton.png)';
		  	return;
	  } else {
		  if (!bloquearInteracciones) {
			  bloquearInteracciones = true;
			  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBotonClick.png)';
			  var decenas = document.getElementById('sumaDecenasCifra').innerHTML;
			  if(document.getElementById('sumaDecenasCifra').innerHTML=='' ||
					  document.getElementById('sumaDecenasCifra').innerHTML==null)
				  decenas="0";
			  var sumaAlumno = (
					  10*parseInt(decenas, 10) +
				  parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
			  
			  var operador1 = (10*parseInt(document.getElementById('decenasCifra1').innerHTML, 10) +
				  parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
			  
			  decenas = document.getElementById('decenasCifra2').innerHTML;
			  if(document.getElementById('decenasCifra2').innerHTML=='' ||
					  document.getElementById('decenasCifra2').innerHTML==null)
				  decenas="0";
			  var operador2 = (10*parseInt(decenas, 10) +
				  parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
			  
			  if (sumaAlumno == operador1-operador2){
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(correctBoton.png)";
				  sumasActuales++;
				  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/<%=sumasNecesarias%>";
				  setTimeout(asyncCall, 600);
			  } else {
				 if(sumas[indexSuma].resultado.length == 2) {
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaDecenasCifra').innerHTML)
						  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
				  }else if(sumas[indexSuma].resultado.length == 1) {
			  		  if(document.getElementById('sumaDecenasCifra').innerHTML!="0")  
			  			  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
			  	  }
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(startOverBoton.png)";
				  sumasActuales = 0;
				  document.getElementById('indicadorSumas').innerHTML = "0/<%=sumasNecesarias%>";
				  document.getElementById('capaBotonCheckSuma').onclick = function(){
					  	calcularSuma();
			  			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
			  			bloquearInteracciones = false;
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){this.style.backgroundImage="url(checkBotonClick.png)";setTimeout(comprobarSuma, 400)}
			  			document.body.onkeydown = function(evObject){
				  			if(window.event)
				  		  	      var keyCode = window.event.keyCode;       // IE
				  		  	else
				  		  	      var keyCode = evObject.which;
				  	  		if(!bloquearInteracciones) {
				  		  		makeUnselectable();
				  		  		if(keyCode==8 || keyCode==46)
				  		  			document.getElementById(""+casillaSeleccionada).firstElementChild.innerHTML ="";
				  		  		else if (keyCode==13)
				  		  			comprobarSuma();
				  	  		}
			  			};
			  	  };
			  	  document.body.onkeydown = function(evObject){
		  			if(window.event)
		  		  	      var keyCode = window.event.keyCode;       // IE
		  		  	else
		  		  	      var keyCode = evObject.which;
		  	  		if (keyCode==13){
			  	  		calcularSuma();
			  			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
			  			bloquearInteracciones = false;
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){comprobarSuma()}
			  			document.body.onkeydown = function(evObject){
				  			if(window.event)
				  		  	      var keyCode = window.event.keyCode;       // IE
				  		  	else
				  		  	      var keyCode = evObject.which;
				  	  		if(!bloquearInteracciones) {
				  		  		makeUnselectable();
				  		  		if(keyCode==8 || keyCode==46)
				  		  			document.getElementById(""+casillaSeleccionada).firstElementChild.innerHTML ="";
				  		  		else if (keyCode==13)
				  		  			comprobarSuma();
				  	  		}
			  			};
			  	  	}
	  			  };
			  }
			  
		  } else
			  return;
  		}
  	}
  


   function iniciarCrono() {
        emp=new Date();
        elcrono=setInterval(tiempo,10);
   }
  			
  function tiempo() { 
	  if(nivelIniciado) {
	       actual=new Date();
	       cro=actual-emp;
	       cr=new Date();
	       cr.setTime(cro); 
	       sg=cr.getSeconds();
	       mn=cr.getMinutes();
	       if (sg<10) {sg="0"+sg;} 
	       if (mn<10) {mn="0"+mn;} 
	       document.getElementById('minutero').innerHTML =""+mn+":"+sg;
	  }
    }
  	
  	function clickCifraSuma(cifra) {
  		makeUnselectable();
  		if(!bloquearInteracciones) {
  			setSelected(cifra.id);
  		}
  	}
  	
  	
  	function dobleClickCifraSuma(cifra) {
  		makeUnselectable();
  		if(!bloquearInteracciones) {
  			cifra.firstElementChild.innerHTML ="";
  			setSelected(cifra.id);
  		}
  	}
  	
  	function ponerDigito (idDigito) {
  	  if(!bloquearInteracciones) {
  		var digito = document.getElementById(idDigito).firstElementChild.firstChild.nodeValue;
  	 	document.getElementById(''+casillaSeleccionada).firstElementChild.innerHTML = ""+digito;
  	  	if(casillaSeleccionada=='sumaUnidades'){
  		  document.getElementById(''+casillaSeleccionada).style.borderColor="black";
		  var divCifra = document.getElementById(''+casillaSeleccionada).previousElementSibling;
		  divCifra.style.borderColor="blue";
		  casillaSeleccionada=''+divCifra.id;
  	  	} else if(casillaSeleccionada=="casillaLlevada"){
  	  		document.getElementById("cifraCasillaLlevada").innerHTML = ""+digito;
  	  		if(document.getElementById("eluno").style.visibility=="hidden")
  	  			document.getElementById("unidadesCifra1").style.cursor="pointer";
  	  		setSelected ("sumaUnidades");
  		}
  	  }
    }
  	
  	function setSelected (id) {
  		casillaSeleccionada = id;
  		if (id=='sumaDecenas') {
  			document.getElementById("sumaDecenas").style.borderColor="blue";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevada").style.border = "";
  		} else if (id=='sumaUnidades') {
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="blue";
  			document.getElementById("casillaLlevada").style.border = "";
  		} else if (id=='casillaLlevada'){
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevada").style.border = "0.2vw solid blue";
	  		document.getElementById("casillaLlevada").style.borderRadius="0.1vw";
  		}
  	}
  	
  	function makeUnselectable() {
 		 if (window.getSelection) {window.getSelection().removeAllRanges();}
 		 else if (document.selection) {document.selection.empty();}
 	}
  	
  	var emp;
  	var casillaSeleccionada='sumaUnidades';
  	var nivelIniciado = true;
  	var sumasActuales = 0;
  	var bloquearInteracciones = false;
  	var navegador;  
  	
  	function borrarNumero(evObject) {
  		if(window.event)
	  	      var keyCode = window.event.keyCode;       // IE
	  	else
	  	      var keyCode = evObject.which;
  		if(!bloquearInteracciones) {
	  		makeUnselectable();
	  		if(keyCode==8 || keyCode==46)
	  			document.getElementById(""+digitoSuma).firstElementChild.innerHTML ="";
	  		else if (keyCode==13)
	  			comprobarSuma();
  		}
  	}
  	
  	function ponerNumero(evObject) {
  		if(!bloquearInteracciones) {
	  		makeUnselectable();
	  		var obj;
	  		if(window.event)
	  	      var keyCode = window.event.keyCode;       // IE
	  	   else
	  	      var keyCode = evObject.which;
			 if (keyCode==48) {
				obj = document.getElementById("cero");
				obj.style.backgroundColor="rgb(236, 178, 178)";
	  	    	ponerDigito("cero");
			 } else if(keyCode==49){
				obj = document.getElementById("uno");
				obj.style.backgroundColor="rgb(236, 178, 178)";
		    	ponerDigito("uno");
	  	     } else if(keyCode==50){
	  	    	obj = document.getElementById("dos");
	  	    	obj.style.backgroundColor="rgb(236, 178, 178)";
		    	ponerDigito("dos");
	  	  	 } else if(keyCode==51){
	  	  		obj = document.getElementById("tres");
	  	  	obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("tres");
	  		 } else if(keyCode==52){
	  			obj = document.getElementById("cuatro");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("cuatro");
	  		 } else if(keyCode==53){
	  			obj = document.getElementById("cinco");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("cinco");
	  		 } else if(keyCode==54){
	  			obj = document.getElementById("seis");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("seis");
	  		 } else if(keyCode==55){
	  			obj = document.getElementById("siete");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("siete");
	  		 } else if(keyCode==56){
	  			obj = document.getElementById("ocho");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("ocho");
	  		} else if(keyCode==57){
	  			obj = document.getElementById("nueve");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("nueve");
	  		}
			setTimeout(function(){obj.style.backgroundColor=""},500);
  		}
  	}
  	
  	function onClickCifra(obj){
  		if(!bloquearInteracciones) {
  			makeUnselectable();
  			obj.style.backgroundColor="rgb(236, 178, 178)";
  			ponerDigito(obj.id);
  			setTimeout(function(){obj.style.backgroundColor=""},500);
  		}
  	}
  	
  	function initAssistance() {
	  	if(assistance){
	  		document.getElementById("tachada").style.visibility="visible";
	  		document.getElementById("tachada").style.backgroundSize="6vw 6vw";
	  		if(assistanceMode){
	  			var numero = parseInt(document.getElementById('decenasCifra1').innerHTML, 10) - 1;
	  			document.getElementById("cifraCasillaLlevada").innerHTML = ""+numero;
	  			document.getElementById("eluno").style.visibility="visible";
	  		}else{
	  			if(document.getElementById("cifraCasillaLlevada").innerHTML!="" && document.getElementById("eluno").style.visibility=="hidden")
	  				document.getElementById("unidadesCifra1").style.cursor="pointer";
	  			setSelected("casillaLlevada");
	  		}
	  	}
  	}
  	
  	function setOneAssistance(){
  		if(document.getElementById("cifraCasillaLlevada").innerHTML!="" && document.getElementById("eluno").style.visibility=="hidden"){
  			document.getElementById("eluno").style.visibility="visible";
  			document.getElementById("unidadesCifra1").style.cursor="default";
  			
  		}
  	}
  	var imagen = null;
  	function cambiaImagen(id){
  		if(imagen==null){
  			imagen=id;
  			document.getElementById(""+imagen).style.backgroundImage="url(cruzconpunto.png)";
  			document.getElementById(""+imagen+"label").style.color="red";
  		}else{
  			document.getElementById(""+id).style.backgroundImage="url(cruzconpunto.png)";
  			document.getElementById(""+imagen).style.backgroundImage="url(cruz.png)";
  			document.getElementById(""+id+"label").style.color="red";
  			document.getElementById(""+imagen+"label").style.color="rgb(102, 145, 49)";
  			imagen = id;
  		}
  	}
	  
  </script>
</head>

  <body onload="javascript:calcularSuma();iniciarCrono()" onkeypress="javascript:ponerNumero(event)" onkeydown="javascript:borrarNumero(event)">

	<div id="contenedor" class="unselectable" style="position:absolute;width:99vw">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="position:absolute;width:16.17vw;height:20vw;background-image:url(marcador.png);background-repeat:no-repeat;background-size:16.15vw 19.15vw;text-align:center">
				<div style="width:16.15vw;position:absolute">
						<label style="color:white;font-family:BerlinDemi;font-size:3.2vw;"><%= sNivel %>&nbsp;</label><label id="nivel" style="color:white;font-family:BerlinDemi;font-size:4.5vw;"><%=nivel%></label>
				</div>
				
				<div style="width:16.15vw;position:absolute;top:4vw">
						<label id="indicadorSumas" style="color:rgb(99, 43, 141);font-family:Times New Roman;font-size:6.3vw;font-weight:bold">0/<%=sumasNecesarias%></label>
				</div>
				<div style="width:16.15vw;position:absolute;top:13.5vw">
						<label id="minutero" style="color:black;font-size:4.4vw;font-family:digital7mono">00:00</label>
				</div>
			</div>
				
			<div style="position:absolute;left:22.45vw;width:34.5vw;height:34.5vw;background-size:34.5vw 33.5vw;background-image:url(cuadroResta2.png);background-repeat:no-repeat">
				<!--CASILLAS LLEVADA -->
				<div style="width:62vw;left:18.82vw;position:absolute;top:1vw">
					<div id="casillaLlevada" onclick="javascript:if(document.getElementById('tachada').style.visibility=='visible')setSelected('casillaLlevada')" style="position:absolute;z-index:2;background-image:url(casillaLlevada.png);background-repeat:no-repeat;background-size:2.5vw 3.5vw;width:2.5vw;height:3.5vw">
							<label id="cifraCasillaLlevada" style="position:absolute;left:0.15vw;top:-1.15vw;font-family:Calibri;font-size:4.5vw;font-weight:bold;font-color:black"></label>
					</div>
					<!--  
						<a id="llevadaDecenas" style="position:absolute;left:8.1vw">
							<img src="casillaLlevada.png" style="position:absolute;cursor:pointer;width:2vw;height:3vw" onclick="javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}">	
						</a>
					-->
				</div>
					
				<!--PRIMER OPERADOR  -->
				<div style="width:62vw;left:17.5vw;position:absolute;bottom:31.5vw">
							<label id="decenasCifra1" style="position:absolute;cursor:pointer;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black" onclick="javascript:initAssistance()">&nbsp;</label>
							<div id="tachada" onclick="javascript:initAssistance()" style="width:6vw;height:6vw;cursor:pointer;background-image:url(tacha.png);background-repeat:no-repeat;left:-0.5vw;position:absolute;top:3.5vw;font-family:Calibri"></div>
							<label id="eluno" style="position:absolute;left:5.9vw;top:1.7vw;font-family:Calibri;font-size:5vw;font-weight:bold;font-color:black;visibility:hidden">1</label>
							<label id="unidadesCifra1" style="position:absolute;left:8.1vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black" onclick="javascript:setOneAssistance()">&nbsp;</label>
				</div>	
					
				<!--SEGUNDO OPERADOR  -->
				<div style="width:62vw;left:17.5vw;position:absolute;top:13vw">	 
						<label id="decenasCifra2" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
						<label id="unidadesCifra2" style="position:absolute;left:8.1vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
				</div>
				
				<!--RESULTADO SUMA -->
				<div style="width:62vw;position:absolute;top:24vw;left:0.6vw">
						<!--		
						<a id="sumaCentenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:8.1vw;width:6vw;height:7.4vw;top:0.15vw;border:0.3vw solid black;">
								<label id="sumaCentenasCifra" onMouseOver="this.style.cursor='pointer'"	style="position:absolute;bottom:-1.5vw;left:0.8vw;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
						-->
					
						<a id="sumaDecenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)" 
							style="position:absolute;left:16.2vw;width:6vw;height:7.4vw;top:0.15vw;border:0.3vw solid black">
								<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.8vw;position:absolute;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
					
						<a id="sumaUnidades" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:24.3vw;width:6vw;height:7.4vw;top:0.15vw;border:0.3vw solid blue">
								<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"	style="position:absolute;bottom:-1.5vw;left:0.8vw;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
				</div>
			
			</div>
				
			<div onclick="javascript:location.href='seleccionNivelSubtraction.jsp'" onmouseout="this.style.backgroundImage='url(cerrarAspa.png)'" onmouseover="this.style.backgroundImage='url(cerrarAspaSelect.png)'"
			style="position:absolute;background-size:9.5vw 8.5vw;left:66vw;cursor:pointer;background-image:url(cerrarAspa.png);background-repeat:no-repeat;width:9.5vw;height:8.5vw">
			</div>
				
				
				
	<%if(nivel.equalsIgnoreCase("12") || nivel.equalsIgnoreCase("13") || nivel.equalsIgnoreCase("14")){%>	
		   <div style="position:absolute;width:72vw;height:2vw;background-size:71vw 2vw;top:33.25vw;background-image:url(flecha.png);background-repeat:no-repeat">
		   </div>
		   <div style="position:absolute;width:1vw;height:2vw;left:69.6vw;background-size:1vw 2vw;top:33.25vw;background-image:url(flechacabeza.png);background-repeat:no-repeat">
		   </div>
		   
		   
		   <div id="image0" onclick="cambiaImagen(this.id)" style="position:absolute;z-index:2;left:0.5vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image1" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:3.9vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image2" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:7.3vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image3" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:10.7vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image4" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:14.1vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image5" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:17.5vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image6" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:20.9vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image7" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:24.4vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image8" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:27.8vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image9" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:31.2vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image10" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:34.6vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image11" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:38vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image12" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:41.4vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <!-- 39 -->
		   <div id="image13" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:44.8vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image14" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:48.2vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image15" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:51.6vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image16" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:55vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image17" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:58.4vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image18" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:61.8vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image19" onclick="cambiaImagen(this.id)"style="position:absolute;z-index:2;left:65.2vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   <div id="image20" onclick="cambiaImagen(this.id)" style="position:absolute;z-index:2;left:68.6vw;cursor:pointer;width:1.5vw;height:2vw;background-size:1vw 2vw;top:33.25vw;background-image:url(cruz.png);background-repeat:no-repeat">
		   </div>
		   
		   
		   <div id="image0label" onclick="cambiaImagen('image0')" style="position:absolute;z-index:2;left:0.5vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">0
		   </div>
		   <div id="image1label" onclick="cambiaImagen('image1')" style="position:absolute;z-index:2;left:3.9vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">1
		   </div>
		   <div id="image2label" onclick="cambiaImagen('image2')" style="position:absolute;z-index:2;left:7.3vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">2
		   </div>
		   <div id="image3label" onclick="cambiaImagen('image3')" style="position:absolute;z-index:2;left:10.7vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">3
		   </div>
		   <div id="image4label" onclick="cambiaImagen('image4')" style="position:absolute;z-index:2;left:14.1vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">4
		   </div>
		   <div id="image5label" onclick="cambiaImagen('image5')" style="position:absolute;z-index:2;left:17.5vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">5
		   </div>
		   <div id="image6label" onclick="cambiaImagen('image6')" style="position:absolute;z-index:2;left:20.9vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">6
		   </div>
		   <div id="image7label" onclick="cambiaImagen('image7')" style="position:absolute;z-index:2;left:24.4vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">7
		   </div>
		   <div id="image8label" onclick="cambiaImagen('image8')" style="position:absolute;z-index:2;left:27.8vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">8
		   </div>
		   <div id=image9label onclick="cambiaImagen('image9')" style="position:absolute;z-index:2;left:31.2vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">9
		   </div>
		   <div id="image10label" onclick="cambiaImagen('image10')" style="position:absolute;z-index:2;left:34.2vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">10
		   </div>
		   <div id="image11label" onclick="cambiaImagen('image11')" style="position:absolute;z-index:2;left:37.8vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">11
		   </div>
		   <div id=image12label onclick="cambiaImagen('image12')" style="position:absolute;z-index:2;left:41.2vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">12
		   </div>
		   <!-- 39 -->
		   <div id="image13label" onclick="cambiaImagen('image13')" style="position:absolute;z-index:2;left:44.6vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">13
		   </div>
		   <div id="image14label"  onclick="cambiaImagen('image14')" style="position:absolute;z-index:2;left:48vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">14
		   </div>
		   <div id="image15label" onclick="cambiaImagen('image15')" style="position:absolute;z-index:2;left:51.4vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">15
		   </div>
		   <div id="image16label" onclick="cambiaImagen('image16')" style="position:absolute;z-index:2;left:54.8vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">16
		   </div>
		   <div id="image17label" onclick="cambiaImagen('image17')" style="position:absolute;z-index:2;left:58.2vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">17
		   </div>
		   <div id="image18label" onclick="cambiaImagen('image18')" style="position:absolute;z-index:2;left:61.6vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">18
		   </div>
		   <div id="image19label" onclick="cambiaImagen('image19')" style="position:absolute;z-index:2;left:64.9vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">19
		   </div>
		   <div id="image20label" onclick="cambiaImagen('image20')" style="position:absolute;z-index:2;left:68.2vw;cursor:pointer;width:1vw;height:2vw;top:34.5vw;font-family:BerlinDemi;font-size:2vw;font-weight: bold;color:rgb(102, 145, 49)">20
		   </div>
		<%}%>
		   
		   
		   
		   
		   
			
			<!-- CAPAS DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<%if(nivel.equalsIgnoreCase("12") || nivel.equalsIgnoreCase("13") || nivel.equalsIgnoreCase("14")){%>
				<div style="position:absolute;width:66vw;height:10vw;background-size:65.5vw 10vw;top:37.25vw;background-image:url(tablaNumeros.png);background-repeat:no-repeat">
			<%} else{ %>
				<div style="position:absolute;width:66vw;height:10vw;background-size:65.5vw 10vw;top:34.25vw;background-image:url(tablaNumeros.png);background-repeat:no-repeat">	
			<%}%>	
				<div id="cero" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:0.46vw;width:6.105vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.6vw;color:black;font-family:Calibri;font-size:9vw">0</a>
				</div>
				<div id="uno" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:6.86vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.7vw;color:black;font-family:Calibri;font-size:9vw">1</a>
				</div>
				<div id="dos" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:13.35vw;width:6.12vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">2</a>
				</div>
				<div id="tres" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:19.85vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">3</a>
				</div>
				<div id="cuatro" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:26.3vw;width:6.12vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">4</a>
				</div>
				<div id="cinco" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:32.85vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">5</a>
				</div>
				<div id="seis" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:39.35vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">6</a>
				</div>
				<div id="siete" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:45.9vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">7</a>
				</div>
				<div id="ocho" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:52.33vw;width:6.19vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">8</a>
				</div>
				<div id="nueve" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:58.85vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">9</a>
				</div>
			</div>
			<div id="capaBotonCheckSuma" onclick="javascript:this.style.backgroundImage='url(checkBotonClick.png)';setTimeout(comprobarSuma, 320)" 
				<%if(nivel.equalsIgnoreCase("12") || nivel.equalsIgnoreCase("13") || nivel.equalsIgnoreCase("14")){%>
					style="background-size:13vw 13vw;width:20vw;height:15vw;position:absolute;top:35.7vw;left:66.25vw;cursor:pointer;background-image:url(checkBoton.png);background-repeat:no-repeat">
				<%} else{ %>
				    style="background-size:13vw 13vw;width:20vw;height:15vw;position:absolute;top:31.7vw;left:66.25vw;cursor:pointer;background-image:url(checkBoton.png);background-repeat:no-repeat">
				<%}%>
			</div>
	</div>
  </body>
</html>