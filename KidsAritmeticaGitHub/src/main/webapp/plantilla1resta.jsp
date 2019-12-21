<%@page import="playaddition.model.Resta"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
List<Resta>  restas = (List<Resta>) session.getAttribute("restas");   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta http-equiv="Cache-control" content="public">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>PlayAddition</title>
  <style>
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
<!-- Add Firebase products that you want to use -->
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
 if(nivel.equalsIgnoreCase("5") || nivel.equalsIgnoreCase("11"))
	  			sumasNecesarias = 15;
   Iterator<Resta> iter = restas.iterator();
   int i = 0;
   while(iter.hasNext()){
 	  Resta suma = iter.next();%>
 	  sumas[<%=i%>] = {operador1:"<%=suma.getOperando1()%>", operador2:"<%=suma.getOperando2()%>", resultado:"<%=suma.getResultadoResta()%>"};
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
		 indexSuma++;
		 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1;//unidades1;
		 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2;
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		// document.getElementById('sumaDecenasCifra').innerHTML ="";
		 document.getElementById('sumaUnidadesCifra').style.color="rgb(0,110,188)";
		// document.getElementById('sumaDecenasCifra').style.color="rgb(0,110,188)";
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
	  if((document.getElementById('sumaUnidadesCifra').innerHTML=='' || document.getElementById('sumaUnidadesCifra').innerHTML==null) ) {
		  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBoton.png)';
		  return;
	  } else {
		  if (!bloquearInteracciones) {
			  bloquearInteracciones = true;
			  /*var decenas = document.getElementById('sumaDecenasCifra').innerHTML;
			  if(document.getElementById('sumaDecenasCifra').innerHTML=='' ||
					  document.getElementById('sumaDecenasCifra').innerHTML==null)
				  decenas="0";*/
			  var sumaAlumno = (parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
			  
			  var operador1 = (parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
			  
			  
			  var operador2 = (parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
			  
			  if (sumaAlumno == operador1-operador2){
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(correctBoton.png)";
				  sumasActuales++;
				  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/<%=sumasNecesarias%>";
				  setTimeout(asyncCall, 600);
			  } else {
				  if(sumas[indexSuma].resultado.length == 2) {
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
			  	  } else if(sumas[indexSuma].resultado.length == 1) {
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
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){comprobarSuma()}
			  			document.body.onkeydown = function(evObject){
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
				  		  			document.getElementById(""+digitoSuma).firstElementChild.innerHTML ="";
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
	       cs=cr.getMilliseconds();
	       cs=cs/10;
	       cs=Math.round(cs);
	       sg=cr.getSeconds();
	       mn=cr.getMinutes();
	       ho=cr.getHours()-1;	 
	       if (cs<10) {cs="0"+cs;} 
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
  	 	document.getElementById(''+digitoSuma).firstElementChild.innerHTML = ""+digito;
  	  }
    }
  	
  	function setSelected (id) {
  		digitoSuma = id;
  		document.getElementById("sumaUnidades").style.borderColor="blue";
  	}
  	
  	function makeUnselectable() {
 		 if (window.getSelection) {window.getSelection().removeAllRanges();}
 		 else if (document.selection) {document.selection.empty();}
 	}
  	
  	var emp;
  	var digitoSuma='sumaUnidades';
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
	  
  </script>
</head>

  <body onload="javascript:calcularSuma();iniciarCrono()" onkeypress="javascript:ponerNumero(event)" onkeydown="javascript:borrarNumero(event)">
	<div id="contenedor" class="unselectable" style="position:absolute;width:99vw">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="position:absolute;width:16.17vw;height:20vw;background-image:url(marcador.png);background-repeat:no-repeat;background-size:16.15vw 19.15vw;text-align:center">
				<div style="width:16.15vw;position:absolute">
						<label style="color:white;font-family:BerlinDemi;font-size:3.2vw;">LEVEL&nbsp;</label><label id="nivel" style="color:white;font-family:BerlinDemi;font-size:4.5vw;"><%=nivel%></label>
				</div>
				
				<div style="width:16.15vw;position:absolute;top:4vw">
						<label id="indicadorSumas" style="color:rgb(99, 43, 141);font-family:Times New Roman;font-size:6.3vw;font-weight:bold">0/<%=sumasNecesarias%></label>
				</div>
				<div style="width:16.15vw;position:absolute;top:13.5vw">
						<label id="minutero" style="color:black;font-size:4.4vw;font-family:digital7mono">00:00</label>
				</div>
			</div>	
				
			<div style="position:absolute;left:22.45vw;width:20vw;height:30vw;background-size:20vw 30vw;background-image:url(cuadroResta1.png);background-repeat:no-repeat">

			
				<!--PRIMER OPERADOR  -->
				<div style="width:62vw;left:11vw;position:absolute;bottom:30.3vw">
					<label id="unidadesCifra1" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
				</div>
				
					
				<!--SEGUNDO OPERADOR  -->
				<div style="width:62vw;left:11vw;position:absolute;top:9.65vw">	 
						<label id="unidadesCifra2" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
				</div>
				
				<!--RESULTADO SUMA -->
				<div style="width:62vw;position:absolute;top:20vw">
						<a id="sumaUnidades" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:10.2vw;width:6vw;height:7.4vw;top:0.95vw;border:0.3vw solid blue">
							<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"	style="position:absolute;bottom:-1.5vw;left:0.8vw;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label></a>
				</div>
			
			</div>
			<div onclick="javascript:location.href='seleccionNivelSubtraction.jsp'" onmouseout="this.style.backgroundImage='url(cerrarAspa.png)'" onmouseover="this.style.backgroundImage='url(cerrarAspaSelect.png)'" 
				style="position:absolute;background-size:9.5vw 8.5vw;left:66vw;cursor:pointer;background-image:url(cerrarAspa.png);background-repeat:no-repeat;width:9.5vw;height:8.5vw">
				<img src="cerrarAspaSelect.png" width="1px" height="1px" border="0">
			</div>
				

			
			<!-- CAPA DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<div style="position:absolute;width:66vw;height:10vw;background-size:65.5vw 10vw;top:34.25vw;background-image:url(tablaNumeros.png);background-repeat:no-repeat">
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
			
			<div id="capaBotonCheckSuma" onclick="comprobarSuma()" style="background-size:13vw 13vw;width:20vw;height:15vw;position:absolute;top:32.3vw;left:66.25vw;cursor:pointer;background-image:url(checkBoton.png);background-repeat:no-repeat">
				<img src="checkBoton.png" width="1px" height="1px" border="0">
				<img src="checkBotonClick.png" width="1px" height="1px" border="0">
				<img src="startOverBoton.png" width="1px" height="1px" border="0">
				<img src="levelUpBoton.png" width="1px" height="1px" border="0">
			</div>
	</div>
  </body>
</html>