<%
String nivel =  (String) session.getAttribute("nivel");
if ( nivel == null)
	session.setAttribute("nivel", "1");
nivel =  (String) session.getAttribute("nivel");
   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
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
		 document.getElementById('centenasCifra1').innerHTML = ""+centenas1;
		 document.getElementById('centenasCifra2').innerHTML = ""+centenas2;
		 document.getElementById('decenasCifra1').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('decenasCifra2').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('unidadesCifra1').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('unidadesCifra2').innerHTML = ""+Math.floor(Math.random() * 10);
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
		 document.getElementById('sumaCentenasCifra').innerHTML ="";
	     document.getElementById('sumaMillaresCifra').innerHTML ="";
	     setSelected ("sumaUnidades");
	}
	
	function asyncCall() {
		if(sumasActuales<10) {
			//var innerHtml="<a onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 1000);\"><img src=\"checkButton.png\"/>";
			var innerHtml="";
	  		document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='checkBoton.png' onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 600)\"/>";
	  		calcularSuma();
		}else{
			var innerHtml="<img src='levelUpBoton.png'/>";
	  		document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='levelUpBoton.png'/>";
	  		nivelIniciado = false;
		}
		document.getElementById('llevadaCentenas').innerHTML="<img src='casillaLlevada.png' onclick=\"javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}\"/>";
		document.getElementById('llevadaDecenas').innerHTML="<img src='casillaLlevada.png' onclick=\"javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}\"/>";
	}

  function ponerDigito (idDigito) {
	  var digito = document.getElementById(idDigito).innerHTML;
	  document.getElementById(''+digitoSuma).firstElementChild.innerHTML = ""+digito;
	  if(digitoSuma=='sumaMillares'){
		  document.getElementById(''+digitoSuma).parentElement.nextElementSibling.style.visibility='visible';
		  return;
	  }
	  document.getElementById(''+digitoSuma).style.borderColor="black";
	  var sigCifra;
	  var divCifra = document.getElementById(''+digitoSuma).parentElement.previousElementSibling;
	  if(divCifra.id=='coma'){
		  
		  divCifra = divCifra.previousElementSibling;
	  }
	  sigCifra = divCifra.firstElementChild;
      sigCifra.style.borderColor="red";
	  digitoSuma=''+sigCifra.id;
	  
  }
  
  /*function comprobarSuma(){
	  var sumaAlumno = parseInt(document.getElementById('sumaUnidades').innerHTML, 10);
	  var unidades1 = parseInt(document.getElementById('unidades1').innerHTML, 10);
	  var unidades2 = parseInt(document.getElementById('unidades2').innerHTML, 10);
	  if (sumaAlumno == unidades1+unidades2){
		  var innerHtml="<a onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 1000);\"><img src=\"checkButton.png\"/></a>";
		  //innerHtml+="<label style=\"font-size: 40px;font-family:Berlin Sans FB Demi;color:rgb(0, 176, 80);position:relative;bottom:120px;left:35px\">CORRECT</label>";
		  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
		  
		  
		  sumasActuales++;
		  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales;
		  if(sumasActuales>9)
			  document.getElementById("indicadorSumasDiv").style.left = "30px";
	  } else {
		  sumasActuales = 0;
		  var innerHtml="<a onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 1000);\"><img src=\"checkIncorrect.png\"/></a>"; 
		  //innerHtml+="<label style=\"font-size: 25px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;bottom:160px;left:53px\">INCORRECT</label><BR>";
		  //innerHtml+="<label style=\"font-size: 42px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;bottom:160px;left:56px\">START</label><BR>";
		  //innerHtml+="<label style=\"font-size: 42px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;bottom:160px;left:56px\">OVER</label>";
		  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
		  //document.getElementById('indicadorSumas').innerHTML = "0";
	  }
  }*/
  
  
  
  function comprobarSuma(){
	  
	  
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
	  
	  
	  var operador2 = (100*parseInt(document.getElementById('centenasCifra2').innerHTML, 10)+
			  10*parseInt(document.getElementById('decenasCifra2').innerHTML, 10) +
		  parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
	  
	  if (sumaAlumno == operador1+operador2){
		  document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='correctBoton.png'/>";
		  sumasActuales++;
		  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/10";
		  
	  } else {
		  document.getElementById('capaBotonCheckSuma').innerHTML ="<img src='startOverBoton.png'/>";
		  sumasActuales = 0;
		  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"0/10";
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
	  
  </script>
</head>

  <body onload="javascript:calcularSuma();iniciarCrono()">
	<div id="contenedor" class="unselectable" style="width:1560px;height:765px">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="width:100%;height:73%">
				<div style="width:23%;height:100%;float:left;background-image:url(marcador.png);background-repeat:no-repeat">
					<div style="width:261px;position:relative;bottom:7px;color:white;font-family:Berlin Sans FB Demi;font-size:70px;text-align: center">
							<label style="font-size:50px">LEVEL&nbsp;</label><label id ="nivel">40</label>
					</div>
					
					<div style="width:261px;position:relative;bottom:15px;color:rgb(99, 43, 141);font-family:Times New Roman;font-size:105px;font-weight:bold;text-align:center">
							<label id ="indicadorSumas">0/10</label>
					</div>
					<div style="width:261px;position:relative;top:15px;color:black;font-family:Times New Roman;font-size:70px;text-align:center">
							<label id ="minutero" style="font-family:digital7mono">00:00</label>
					</div>
				</div>	
				
				<div style="width:62%;height:100%;float:left;background-image:url(cuadroSuma3.png);background-repeat:no-repeat">
						<div onMouseOver="this.style.cursor='pointer'" style="z-index:10;width:32px;height:49px;position:relative;top:23px;left:303px;float:left">
							<a id="llevadaCentenas" style="width:32px;height:50px">
								<img src="casillaLlevada.png" onclick="javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}"/>
							</a>
						</div>
						<div onMouseOver="this.style.cursor='pointer'" style="z-index:10;width:32px;height:50px;position:relative;top:23px;left:395px;float:left">
							<a id="llevadaDecenas" style="width:32px;height:50px">
								<img src="casillaLlevada.png" onclick="javascript:{if(this.src.indexOf('casillaLlevada.png')<0){this.src='casillaLlevada.png'}else{this.src='casillaLlevada1.png'}}"/>	
							</a>
						</div>
						
						<!--PRIMER OPERADOR  -->
					<div style="width:100%;height:160px;float:left;position:relative;left:280px">	
						<div style="position:relative;float:left"> 
								<label id="centenasCifra1" style="position:relative;font-family:Calibri;
										font-size:160px;font-weight:bold;font-color:black">1</label>
							</div>
							<div style="position:relative;left:45px;float:left">
								<label id="decenasCifra1" style="position:relative;font-family:Calibri;
										font-size:160px;font-weight:bold;font-color:black">2</label>
							</div>
							<div style="position:relative;left:90px;float:left">
								<label id="unidadesCifra1" style="position:relative;font-family:Calibri;
										font-size:160px;font-weight:bold;font-color:black">3</label>
							</div>
					</div>	
						
					<!--SEGUNDO OPERADOR  -->
					<div style="width:100%;height:160px;position:relative;top:8px;left:280px;float:left">	 
						<div style="position:relative;float:left">
							<label id="centenasCifra2" style="position:relative;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black">1</label>
						</div>
						<div style="position:relative;left:45px;float:left">
							<label id="decenasCifra2" style="position:relative;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black">2</label>
						</div>
						<div style="position:relative;left:90px;float:left">
							<label id="unidadesCifra2" style="position:relative;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black">3</label>
						</div>
					</div>
					
					<!--RESULTADO SUMA -->
					<div style="float:left;width:100%;height:160px;position:relative;top:25px;left:125px">
						<div style="float:left">
							<a id="sumaMillares" 
								style="width:96px;height:118px;position:relative;float:left;border:5px solid black" 
								onclick="makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id);document.getElementById('coma').style.visibility='hidden'">
									<label id="sumaMillaresCifra"onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:42px;left:10px;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black"></label></a></div>
						<div id="coma" style="visibility:hidden;font-family:Calibri;font-size:107px;position:relative;top:25px;left:3px;float:left">,</div>
						<div style="float:left">
							<a id="sumaCentenas" onclick="makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id)" 
								style="width:96px;height:118px;
								position:relative;left:13px;float:left;border:5px solid black">
									<label id="sumaCentenasCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:42px;left:10px;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black"></label></a></div>
						<div style="float:left">
							<a id="sumaDecenas" onclick=";makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id)" 
								style="width:96px;height:118px;
								position:relative;left:35px;float:left;border:5px solid black">
									<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:42px;left:10px;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black"></label></a></div>
						<div style="float:left">
							<a id="sumaUnidades" onclick="makeUnselectable();setSelected(this.id)" ondblclick="this.firstElementChild.innerHTML ='';setSelected(this.id)"
								style="width:96px;height:118px;
								position:relative;left:55px;float:left;border:5px solid red">
									<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"
									style="position:relative;bottom:42px;left:10px;font-family:Calibri;
									font-size:160px;font-weight:bold;font-color:black"></label></a></div>
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
									 font-size: 145px">0</a>
						<a id="uno" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:50px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">1</a>
						<a id="dos" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:82px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">2</a>
						<a id="tres" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:114px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">3</a>
						<a id="cuatro" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:146px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">4</a>
						<a id="cinco" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:178px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">5</a>
						<a id="seis" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:210px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">6</a>
						<a id="siete" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:242px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">7</a>
						<a id="ocho" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:274px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">8</a>
						<a id="nueve" onclick="makeUnselectable();ponerDigito(this.id)" style="float:left;position:relative;left:306px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">9</a>
					</div>
					
					<div style="float:left;width:25%;height:100%;position:relative;bottom:25px;right:110px">
						<a id="capaBotonCheckSuma"><img src="checkBoton.png" onclick="javascript:comprobarSuma();setTimeout(asyncCall, 600)"/></a>
					</div>
			</div>
	</div>
  </body>
</html>