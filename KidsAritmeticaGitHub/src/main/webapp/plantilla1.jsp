<%@page import="playaddition.model.Suma"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
List<Suma>  sumas = (List<Suma>) session.getAttribute("sumas");   
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
  <script>
  $( function() {
	  	
  } );
  var sumas = [];
  var indexSuma = 0;
 <%
   int sumasNecesarias = 10;
 if(nivel.equalsIgnoreCase("5") || nivel.equalsIgnoreCase("11") || nivel.equalsIgnoreCase("13") || nivel.equalsIgnoreCase("17") || 
		  nivel.equalsIgnoreCase("22") || nivel.equalsIgnoreCase("25") || nivel.equalsIgnoreCase("32") || nivel.equalsIgnoreCase("40"))
	  			sumasNecesarias = 15;
   Iterator<Suma> iter = sumas.iterator();
   int i = 0;
   while(iter.hasNext()){
 	  Suma suma = iter.next();%>
 	  sumas[<%=i%>] = {operador1:"<%=suma.getOperando1()%>", operador2:"<%=suma.getOperando2()%>"};
  <%i++;}%>
	
	function subirNivel() {
		nivel++;
		$.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+nivel, accion:'subirNivel'},
			  success : function(responseText) {
				  if(nivel<=13)
						location.href = "plantilla1.jsp";
					else if(nivel<=22)
						location.href = "plantilla2.jsp";
					else
						location.href = "plantilla3.jsp";
				  }
			});
  	}

	function calcularSuma() {
		 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1;//unidades1;
		 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2;
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
		 indexSuma++
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
		}
	}

  
  
  function comprobarSuma(){
	  if(
	      (document.getElementById('sumaUnidadesCifra').innerHTML=='' || document.getElementById('sumaUnidadesCifra').innerHTML==null) ) {
		  	return;
	  } else {
		  if (!bloquearInteracciones) {
			  bloquearInteracciones = true;
			  var decenas = document.getElementById('sumaDecenasCifra').innerHTML;
			  if(document.getElementById('sumaDecenasCifra').innerHTML=='' ||
					  document.getElementById('sumaDecenasCifra').innerHTML==null)
				  decenas="0";
			  var sumaAlumno = (10*parseInt(decenas, 10) +
				  parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
			  
			  var operador1 = (parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
			  
			  
			  var operador2 = (parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
			  
			  if (sumaAlumno == operador1+operador2){
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(correctBoton.png)";
				  sumasActuales++;
				  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/<%=sumasNecesarias%>";
				  setTimeout(asyncCall, 600);
			  } else {
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(startOverBoton.png)";
				  document.getElementById('capaBotonCheckSuma').onclick = function(){
					  	calcularSuma();
			  			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
			  			bloquearInteracciones = false;
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){comprobarSuma()}
			  	  };
				  sumasActuales = 0;
				  document.getElementById('indicadorSumas').innerHTML = "0/<%=sumasNecesarias%>";
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
  	
  	function detectarNavegador(){
  		if(navigator.userAgent.indexOf("Chrome")>=0){
  			navegador = "Chrome";
  		}else if(navigator.userAgent.indexOf("Firefox")>=0){
  			navegador = "Firefox";
  		}else if(navigator.userAgent.indexOf("Chrome")==-1 && navigator.userAgent.indexOf("Safari")>=0){
  			document.getElementById("cero").style.left = "22px";
  			document.getElementById("uno").style.left = "53px";
  			document.getElementById("dos").style.left = "86px";
  			document.getElementById("tres").style.left = "118px";
  			document.getElementById("cuatro").style.left = "153px";
  			document.getElementById("cinco").style.left = "187px";
  			document.getElementById("seis").style.left = "219px";
  			document.getElementById("siete").style.left = "252px";
  			document.getElementById("ocho").style.left = "285px";
  			document.getElementById("nueve").style.left = "317px";
  			
  			document.getElementById("cero").style.bottom = "2px";
  			document.getElementById("uno").style.bottom = "2px";
  			document.getElementById("dos").style.bottom = "2px";
  			document.getElementById("tres").style.bottom = "2px";
  			document.getElementById("cuatro").style.bottom = "2px";
  			document.getElementById("cinco").style.bottom = "2px";
  			document.getElementById("seis").style.bottom = "2px";
  			document.getElementById("siete").style.bottom = "2px";
  			document.getElementById("ocho").style.bottom = "2px";
  			document.getElementById("nueve").style.bottom = "2px";
  			
  			
  			
  			document.getElementById("sumaUnidadesCifra").style.bottom = "32px";
  			document.getElementById("sumaDecenasCifra").style.bottom = "32px";
  			
  			
  			navegador = "Safari";
  			
  		}else if(navigator.userAgent.indexOf("Chrome")==-1 && navigator.userAgent.indexOf("Firefox")==-1 && navigator.userAgent.indexOf("Windows")>=0){
  			navegador = "IExplorer";
  		}
  		document.getElementById("cero").style.visibility='visible';
  		document.getElementById("uno").style.visibility='visible';
		document.getElementById("dos").style.visibility='visible';
		document.getElementById("tres").style.visibility='visible';
		document.getElementById("cuatro").style.visibility='visible';
		document.getElementById("cinco").style.visibility='visible';
		document.getElementById("seis").style.visibility='visible';
		document.getElementById("siete").style.visibility='visible';
		document.getElementById("ocho").style.visibility='visible';
		document.getElementById("nueve").style.visibility='visible';
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
  		var digito = document.getElementById(idDigito).innerHTML;
  	 	document.getElementById(''+digitoSuma).firstElementChild.innerHTML = ""+digito;
  	  	if(digitoSuma=='sumaUnidades'){
  		  document.getElementById(''+digitoSuma).style.borderColor="black";
  		  var sigCifra;
  		  var divCifra = document.getElementById(''+digitoSuma).parentElement.previousElementSibling;
  		  sigCifra = divCifra.firstElementChild;
  	      sigCifra.style.borderColor="red";
  		  digitoSuma=''+sigCifra.id;
  	  	}
  	  }
    }
  	
  	function setSelected (id) {
  		digitoSuma = id;
  		if (id=='sumaDecenas') {
  			
  			
  			document.getElementById("sumaDecenas").style.borderColor="red";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  		} else if (id=='sumaUnidades') {
  			
  			
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
	  
  </script>
</head>

  <body onload="javascript:detectarNavegador();calcularSuma();iniciarCrono()">
	<div id="contenedor" class="unselectable" style="width:1560px;height:750px">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="width:100%;height:73%">
				<div style="width:23%;height:100%;float:left;background-image:url(marcador.png);background-repeat:no-repeat">
					<div style="width:261px;position:relative;bottom:7px;color:white;font-family:BerlinDemi;font-size:70px;text-align: center">
							<label style="font-size:50px">LEVEL&nbsp;</label><label id ="nivel"><%=nivel%></label>
					</div>
					
					<div style="width:261px;position:relative;bottom:15px;color:rgb(99, 43, 141);font-family:Times New Roman;font-size:105px;font-weight:bold;text-align:center">
							<label id ="indicadorSumas">0/<%=sumasNecesarias%></label>
					</div>
					<div style="width:261px;position:relative;top:15px;color:black;font-family:Times New Roman;font-size:70px;text-align:center">
							<label id ="minutero" style="font-family:digital7mono">00:00</label>
					</div>
				</div>	
				
				<div style="width:62%;height:100%;float:left;background-image:url(cuadroSuma1.png);background-repeat:no-repeat">
						<!--PRIMER OPERADOR  -->
					<div style="width:100%;height:160px;float:left;position:relative;left:260px;bottom:8px">	
							<div style="position:relative;left:10px;float:left">
								<label id="unidadesCifra1" style="position:relative;font-family:Calibri;
										font-size:160px;font-weight:bold;font-color:black">3</label>
							</div>
					</div>	
						
					<!--SEGUNDO OPERADOR  -->
					<div style="width:100%;height:160px;position:relative;left:260px;float:left;bottom:3px">	 
						<div style="position:relative;left:10px;float:left">
							<label id="unidadesCifra2" style="position:relative;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black">3</label>
						</div>
					</div>
					
					<!--RESULTADO SUMA -->
					<div style="float:left;width:100%;height:160px;position:relative;top:25px;left:125px">
						<div style="float:left;bottom:10px">
							<a id="sumaDecenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
								style="width:96px;height:118px;
								position:relative;float:left;left:5px;border:5px solid black;bottom:10px">
									<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:40px;left:10px;font-family:Calibri;
									font-size:158px;font-weight:bold;font-color:black"></label></a></div>
						<div style="float:left">
							<a id="sumaUnidades" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
								style="width:96px;height:118px;
								position:relative;left:28px;float:left;border:5px solid red;bottom:10px">
									<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:40px;left:10px;font-family:Calibri;
									font-size:158px;font-weight:bold;font-color:black"></label></a></div>
					</div>
				
				</div>
				<div onclick="javascript:location.href='seleccionNivel.jsp'" style="cursor:pointer;background-image:url(cerrarAspa.png);background-repeat:no-repeat;width:160px;height:140px;float:left;position:relative;right:245px">
				</div>
				
		   </div>
			
			<!-- CAPA DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<div style="width:100%;height:27%">
					<div style="float:left;width:75%;height:100%;background-image:url(tablaNumeros.png);background-repeat:no-repeat">
						<a id="cero" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">0</a>
						<a id="uno" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:50px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">1</a>
						<a id="dos" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:81px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">2</a>
						<a id="tres" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:111px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">3</a>
						<a id="cuatro" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:141px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">4</a>
						<a id="cinco" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:167px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">5</a>
						<a id="seis" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:201px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">6</a>
						<a id="siete" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:230px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">7</a>
						<a id="ocho" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:261px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">8</a>
						<a id="nueve" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:291px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">9</a>
					</div>
					
					<div id="capaBotonCheckSuma" onclick="javascript:comprobarSuma()" style="cursor:pointer;float:left;width:221px;height:209px;position:relative;bottom:30px;right:120px;background-image:url(checkBoton.png);background-repeat:no-repeat">
					</div>
			</div>
	</div>
  </body>
</html>