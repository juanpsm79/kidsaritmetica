<%@page import="playaddition.model.Resta"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
List<Resta>  restas = (List<Resta>) session.getAttribute("restas");   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
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
//var dominio = "test.playaddition.com";
  var dominio = "playaddition.com";
  $( function() {
  	
  } );

  var sumas = [];
  var indexSuma = -1;
 <%
   int sumasNecesarias = 10;
   if(nivel.equalsIgnoreCase("5") || nivel.equalsIgnoreCase("11") || nivel.equalsIgnoreCase("13") || nivel.equalsIgnoreCase("17") || 
		  nivel.equalsIgnoreCase("22") || nivel.equalsIgnoreCase("25") || nivel.equalsIgnoreCase("32") || nivel.equalsIgnoreCase("40"))
	  			sumasNecesarias = 15;
   Iterator<Resta> iter = restas.iterator();
   int i = 0;
   while(iter.hasNext()){
 	  Resta suma = iter.next();%>
 	 sumas[<%=i%>] = {operador1:"<%=suma.getOperando1()%>", operador2:"<%=suma.getOperando2()%>", resultado:"<%=suma.getResultadoResta()%>"};
  <%i++;}%>
  
  function subirNivel() {
		nivel++;
		$.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+nivel, accion:'subirNivel'},
			  success : function(responseText) {
				  location.href = "descripcionNivel.jsp";
			  }
			});
	}
  	

	function calcularSuma() {
		indexSuma++;
		 if (parseInt(sumas[indexSuma].operador1, 10)<10){
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1;
			 document.getElementById('decenasCifra1').innerHTML = "";
			 document.getElementById('centenasCifra1').innerHTML = "";
			
		 }else if(parseInt(sumas[indexSuma].operador1, 10)<100){
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(1);
			 document.getElementById('decenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(0);
			 document.getElementById('centenasCifra1').innerHTML = "";
			 
		 } else {
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(2);
			 document.getElementById('decenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(1);
			 document.getElementById('centenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(0);
		 }
		 
		 if (parseInt(sumas[indexSuma].operador2, 10)<10){
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2;
			 document.getElementById('decenasCifra2').innerHTML = "";
			 document.getElementById('centenasCifra2').innerHTML = "";
			 
		 }else if(parseInt(sumas[indexSuma].operador2, 10)<100){
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(1);
			 document.getElementById('decenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(0);
			 document.getElementById('centenasCifra2').innerHTML = "";
		 } else {
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(2);
			 document.getElementById('decenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(1);
			 document.getElementById('centenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(0);
		 }
		
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
		 document.getElementById('sumaCentenasCifra').innerHTML ="";
	     document.getElementById('sumaMillaresCifra').innerHTML ="";
	     document.getElementById('sumaUnidadesCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaDecenasCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaCentenasCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaMillaresCifra').style.color="rgb(0,110,188)";
	     document.getElementById('coma').style.visibility='hidden';
	     document.getElementById('llevadaCentenas').innerHTML="<img src='casillaLlevada.png' style=\"position:absolute;cursor:pointer;width:2vw;height:3vw\" onclick=\"javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}\"/>";
		 document.getElementById('llevadaDecenas').innerHTML= "<img src='casillaLlevada.png' style=\"position:absolute;cursor:pointer;width:2vw;height:3vw\" onclick=\"javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}\"/>";
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
	  if( 
	      document.getElementById('sumaCentenasCifra').innerHTML=='' || document.getElementById('sumaCentenasCifra').innerHTML==null ||	
	      document.getElementById('sumaDecenasCifra').innerHTML==''  || document.getElementById('sumaDecenasCifra').innerHTML==null ||
	      document.getElementById('sumaUnidadesCifra').innerHTML=='' || document.getElementById('sumaUnidadesCifra').innerHTML==null ) {
		  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBoton.png)';
		  	return;
	  } else {
		  if (!bloquearInteracciones) {
			  bloquearInteracciones = true;
			  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBotonClick.png)';
			  var millares = document.getElementById('sumaMillaresCifra').innerHTML;
			  if(document.getElementById('sumaMillaresCifra').innerHTML=='' ||
					  document.getElementById('sumaMillaresCifra').innerHTML==null)
				  millares="0";
			  var sumaAlumno = (1000*parseInt(millares, 10)+
					  100*parseInt(document.getElementById('sumaCentenasCifra').innerHTML, 10)+
					  10*parseInt(document.getElementById('sumaDecenasCifra').innerHTML, 10) +
				  parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
			  
			  var operador1 = (100*parseInt(document.getElementById('centenasCifra1').innerHTML, 10)+
					  10*parseInt(document.getElementById('decenasCifra1').innerHTML, 10) +
				  parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
			  
			  var decenas = document.getElementById('decenasCifra2').innerHTML;
			  if(document.getElementById('decenasCifra2').innerHTML=='' ||
					  document.getElementById('decenasCifra2').innerHTML==null)
				  decenas="0";
			  var centenas = document.getElementById('centenasCifra2').innerHTML;
			  if(document.getElementById('centenasCifra2').innerHTML=='' ||
					  document.getElementById('centenasCifra2').innerHTML==null)
				  centenas="0";
			  var operador2 = (100*parseInt(centenas, 10)+
					  10*parseInt(decenas, 10) +
				  parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
			  
			  if (sumaAlumno == operador1+operador2){
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(correctBoton.png)";
				  sumasActuales++;
				  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/<%=sumasNecesarias%>";
				  setTimeout(asyncCall, 600);
			  } else {
				  if(sumas[indexSuma].resultado.length == 4) {
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaMillaresCifra').innerHTML)
						  document.getElementById('sumaMillaresCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaCentenasCifra').innerHTML)
						  document.getElementById('sumaCentenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(2)!=document.getElementById('sumaDecenasCifra').innerHTML)
						  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(3)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
				  } else if(sumas[indexSuma].resultado.length == 3) {
					  if(document.getElementById('sumaMillaresCifra').innerHTML!="0")  
			  			  document.getElementById('sumaMillaresCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaCentenasCifra').innerHTML)
						  document.getElementById('sumaCentenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaDecenasCifra').innerHTML)
						  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(2)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
					  
				  }
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(startOverBoton.png)";
				  document.getElementById('capaBotonCheckSuma').onclick = function(){
					  	sumasActuales = 0;
					  	document.getElementById('indicadorSumas').innerHTML = "0/<%=sumasNecesarias%>";
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
  		  if(digitoSuma=='sumaMillares') {
  			  document.getElementById(''+digitoSuma).nextElementSibling.style.visibility='visible';
  			  return;
  		  }
  		  document.getElementById(''+digitoSuma).style.borderColor="black";
  		  var divCifra = document.getElementById(''+digitoSuma).previousElementSibling;
  		  if(divCifra.id=='coma')
  			  divCifra = divCifra.previousElementSibling;
  		  divCifra.style.borderColor="red";
		  digitoSuma=''+divCifra.id;
  	  }
    }
  	
  	function setSelected (id) {
  		digitoSuma = id;
  		if (id=='sumaMillares') {
  			document.getElementById("sumaMillares").style.borderColor="red";
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  		} else if (id=='sumaCentenas') {
  			document.getElementById("sumaMillares").style.borderColor="black";
  			document.getElementById("sumaCentenas").style.borderColor="red";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  		} else if (id=='sumaDecenas') {
  			document.getElementById("sumaMillares").style.borderColor="black";
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="red";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  		} else if (id=='sumaUnidades') {
  			document.getElementById("sumaMillares").style.borderColor="black";
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="red";
  		}
  	}
  	
  	function makeUnselectable() {
 		 if (window.getSelection) {window.getSelection().removeAllRanges();}
 		 else if (document.selection) {document.selection.empty();}
 	}
  	
  	var emp;
  	var digitoSuma='sumaUnidades';
  	var nivelIniciado = true;
  	var sumasActuales = 0;
  	var nivel = <%=nivel%>;
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
  
  	<div class="hidden">
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
			if (document.images) {
				var img1 = new Image();
				var img2 = new Image();
				var img3 = new Image();
				var img4 = new Image();
				var img5 = new Image();
				img1.src = "https://"+dominio+"/cerrarAspaSelect.png";
				img2.src = "https://"+dominio+"/startOverBoton.png";
				img3.src = "https://"+dominio+"/correctBoton.png";
				img4.src = "https://"+dominio+"/levelUpBoton.png";
				img5.src = "https://"+dominio+"/checkBotonClick.png";
			}

		//--><!]]>
		</script>
	</div>
  
	<div id="contenedor" class="unselectable" style="position:absolute;width:99vw">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOT�N DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
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
				
			<div style="position:absolute;left:22.45vw;width:41.8vw;height:34.5vw;background-size:41.8vw 33.5vw;background-image:url(cuadroSuma3.png);background-repeat:no-repeat">
			<!--CASILLAS LLEVADA -->
				<div style="width:62vw;left:18.5vw;position:absolute;top:1vw">
					<a id="llevadaCentenas" style="position:absolute">
							<img src="casillaLlevada.png" style="position:absolute;cursor:pointer;width:2vw;height:3vw" onclick="javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}">
						</a>
						<a id="llevadaDecenas" style="position:absolute;left:7.9vw">
							<img src="casillaLlevada.png" style="position:absolute;cursor:pointer;width:2vw;height:3vw" onclick="javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}">	
						</a>
				</div>
				
				<!--PRIMER OPERADOR  -->
				<div style="width:62vw;left:17vw;position:absolute;bottom:31.5vw">	
					<label id="centenasCifra1" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">1</label>
					<label id="decenasCifra1" style="position:absolute;left:8.1vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">2</label>
					<label id="unidadesCifra1" style="position:absolute;left:16.2vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">3</label>
				</div>	
					
				<!--SEGUNDO OPERADOR  -->
				<div style="width:62vw;left:17vw;position:absolute;top:13vw"> 
					<label id="centenasCifra2" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">1</label>
					<label id="decenasCifra2" style="position:absolute;left:8.1vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">2</label>
					<label id="unidadesCifra2" style="position:absolute;left:16.2vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">3</label>
				</div>
				
				
				<!--RESULTADO SUMA -->
				<div style="width:62vw;position:absolute;top:24vw">
						<a id="sumaMillares" style="position:absolute;left:8.1vw;width:6vw;height:7.4vw;border:0.3vw solid black" 
							onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this);javascript:{if(!bloquearInteracciones){document.getElementById('coma').style.visibility='hidden'}}">
								<label id="sumaMillaresCifra"onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.8vw;position:absolute;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
						
						<div id="coma" style="position:absolute;top:1.25vw;left:14.5vw;top:3,3vw"><label style="font-family:Calibri;font-size:7vw">,</label></div>
					
						<a id="sumaCentenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)" 
							style="position:absolute;left:16.3vw;width:6vw;height:7.4vw;border:0.3vw solid black">
								<label id="sumaCentenasCifra" onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.8vw;position:absolute;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
					
						<a id="sumaDecenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)" 
							style="position:absolute;left:24.3vw;width:6vw;height:7.4vw;border:0.3vw solid black">
								<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.8vw;position:absolute;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
					
						<a id="sumaUnidades" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:32.3vw;width:6vw;height:7.4vw;border:0.3vw solid red">
								<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.8vw;position:absolute;font-family:Calibri;font-size:9vw;font-weight:bold;font-color:black"></label>
						</a>
				</div>
			
			</div>
		   
		   
		   <div onclick="javascript:location.href='seleccionNivel.jsp'" onmouseout="this.style.backgroundImage='url(cerrarAspa.png)'" onmouseover="this.style.backgroundImage='url(cerrarAspaSelect.png)'" 
		   		style="position:absolute;background-size:9.5vw 8.5vw;left:66vw;cursor:pointer;background-image:url(cerrarAspa.png);background-repeat:no-repeat;width:9.5vw;height:8.5vw">
			</div>
			
			<!-- CAPAS DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
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
			</div>
	</div>
  </body>
</html>