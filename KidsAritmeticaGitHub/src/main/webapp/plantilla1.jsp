<%
String nivel =  (String) session.getAttribute("nivel");
if ( nivel == null)
	session.setAttribute("nivel", "1");
nivel =  (String) session.getAttribute("nivel");
   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
  <title>PlayAddition</title>
  <style>
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
  
 
	var nivelIniciado = true;
	var cronometro = 0;
	var sumasActuales = 0;
	var nivel = <%=nivel%>;
	
	function subirNivel() {
		$.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+nivel, accion:'subirNivel'},
			  success : function(responseText) {
				  	location.href = "inicioPlayAddition.jsp"
				  }
			});
  	}

	function calcularSuma() {
		var centenas1 = Math.floor(Math.random() * 10);
		if (centenas1==0)
			centenas1++
		var centenas2 = Math.floor(Math.random() * 10);
		if (centenas2==0)
			centenas2++
		 
		
		
		 document.getElementById('unidadesCifra1').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('unidadesCifra2').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
	     
	     setSelected ("sumaUnidades");
	}
	
	function asyncCall() {
		if(sumasActuales<10) {
			var innerHtml="";
	  		document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='checkBoton.png' onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 600)\"/>";
	  		calcularSuma();
		}else{
			var innerHtml="<img src='levelUpBoton.png'/>";
	  		document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='levelUpBoton.png'/>";
	  		nivelIniciado = false;
		}
	}

  function ponerDigito (idDigito) {
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
  
  function comprobarSuma(){  
	  var decenas = document.getElementById('sumaDecenasCifra').innerHTML;
	  if(document.getElementById('sumaDecenasCifra').innerHTML=='' ||
			  document.getElementById('sumaDecenasCifra').innerHTML==null)
		  decenas="0";
	  
	  var sumaAlumno = (10*parseInt(decenas, 10)+
		  parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
	  
	  var operador1 = (
		  parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
	  
	  
	  var operador2 = 
		  parseInt(document.getElementById('unidadesCifra2').innerHTML, 10);
	  
	  if (sumaAlumno == operador1+operador2){
		  document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='correctBoton.png'/>";
		  sumasActuales++;
		  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/10";
		  
	  } else {
		  document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='startOverBoton.png'/>";
		  sumasActuales = 0;
		  document.getElementById('indicadorSumas').innerHTML = "0/10";
	  }
	  
  }
  
  var emp;
  var digitoSuma='sumaUnidades';
  
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
  
  	function setSelected (id){
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
  	
  	var navegador;
  	
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
		
		//document.getElementById("contenedor").width=""+window.innerWidth;
		//document.getElementById("contenedor").height=""+window.innerHeight;
		//document.getElementById("contenedor").style.visibility='visible';
  	}
	  
  </script>
</head>

  <body onload="javascript:detectarNavegador();calcularSuma();iniciarCrono()">
	<div id="contenedor" class="unselectable" style="width:1560px;height:765px">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="width:100%;height:73%">
				<div style="width:23%;height:100%;float:left;background-image:url(marcador.png);background-repeat:no-repeat">
					<div style="width:261px;position:relative;bottom:7px;color:white;font-family:Berlin Sans FB Demi;font-size:70px;text-align: center">
							<label style="font-size:50px">LEVEL&nbsp;</label><label id ="nivel">1</label>
					</div>
					
					<div style="width:261px;position:relative;bottom:15px;color:rgb(99, 43, 141);font-family:Times New Roman;font-size:105px;font-weight:bold;text-align:center">
							<label id ="indicadorSumas">0/10</label>
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
							<a id="sumaDecenas" onclick=";makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id)" 
								style="width:96px;height:118px;
								position:relative;float:left;left:5px;border:5px solid black;bottom:10px">
									<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:40px;left:10px;font-family:Calibri;
									font-size:158px;font-weight:bold;font-color:black"></label></a></div>
						<div style="float:left">
							<a id="sumaUnidades" onclick="makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id)"
								style="width:96px;height:118px;
								position:relative;left:28px;float:left;border:5px solid red;bottom:10px">
									<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:40px;left:10px;font-family:Calibri;
									font-size:158px;font-weight:bold;font-color:black"></label></a></div>
					</div>
				
				</div>
				<div style="width:15%;height:100%;float:left;position:relative;right:220px">
					<a href="inicioPlayAddition.jsp"><img src="cerrarAspa.png"/></a>
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
						<a id="dos" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:82px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">2</a>
						<a id="tres" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:114px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">3</a>
						<a id="cuatro" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:146px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">4</a>
						<a id="cinco" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:178px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">5</a>
						<a id="seis" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:210px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">6</a>
						<a id="siete" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:242px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">7</a>
						<a id="ocho" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:274px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">8</a>
						<a id="nueve" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:306px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px;visibility:hidden">9</a>
					</div>
					
					<div style="float:left;width:25%;height:100%;position:relative;bottom:25px;right:110px">
						<a id="capaBotonCheckSuma"><img src="checkBoton.png" onclick="javascript:comprobarSuma();setTimeout(asyncCall, 600)"/></a>
					</div>
			</div>
	</div>
  </body>
</html>