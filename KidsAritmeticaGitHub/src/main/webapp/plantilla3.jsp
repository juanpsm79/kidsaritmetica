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
  
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script>
  $( function() {
  	
  } );
  
 
	var nivelIniciado = false;
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
		var aux = Math.floor(Math.random() * 10);
		var aux1 = Math.floor(Math.random() * 10);
		if(aux+aux1<=9) {
		  document.getElementById('unidades2').innerHTML = ""+aux1;
		  document.getElementById('unidades1').innerHTML = ""+aux;
		  return;
		} else {
			calcularSuma();
		}
	}
	
	function asyncCall() {
		if(sumasActuales<10) {
			var innerHtml="<a onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 1000);\"><img src=\"checkButton.png\"/>";
			innerHtml+="<label style=\"font-size: 40px;color:rgb(0, 176, 80);position:relative;bottom:120px;left:55px;text-decoration-line:none\">CHECK</label></a>";
	  		document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
	  		document.getElementById('sumaUnidades').innerHTML ="&nbsp;";
	  		calcularSuma();
		}else{
			var innerHtml="<a onclick=\"javascript:subirNivel();\" style=\"position:relative;bottom:40px\"><img src=\"checkPasoNivel.png\"/>";
	  		innerHtml+="<label href=\"\" style=\"font-family:Berlin Sans FB Demi;font-size:40px;color:rgb(204, 51, 153);position:relative;bottom:160px;left:60px;text-decoration-line: none;\">CONGRATULATIONS,</label><br>";
	  		innerHtml+="<label href=\"\" style=\"font-family:Berlin Sans FB Demi;font-size:40px;color:rgb(204, 51, 153);position:relative;bottom:160px;left:60px;text-decoration-line: none;\">YOU&nbsp;LEVELED&nbsp;UP!</label></a>";
	  		document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
	  		nivelIniciado = false;
	  		
		}
	}

  function ponerDigito (idDigito) {
	  var digito = document.getElementById(idDigito).innerHTML;
	  document.getElementById('sumaUnidades').innerHTML = digito;
	  nivelIniciado = true;
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
	  var innerHtml="<a onclick=\"javascript:comprobarSuma();setTimeout(asyncCall, 1000);\"><img src=\"correctBoton.png\"/></a>";
	  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
  }
  
  var emp;
  function iniciarCrono() {
        emp=new Date();
        elcrono=setInterval(tiempo,10);
   }
  			
  function tiempo() { 
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
      // document.getElementById('secundero').innerHTML =""+sg;
    }
	  
  </script>
</head>

  <body onload="javascript:iniciarCrono()">
	<div style="height:765px">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="width:100%;height:73%">
				<div style="width:23%;height:100%;float:left;background-image:url(marcador.png);background-repeat:no-repeat">
					<div style="width:261px;position:relative;bottom:7px;color:white;font-family:Berlin Sans FB Demi;font-size:70px;text-align: center">
							<label style="font-size:50px">LEVEL&nbsp;</label><label id ="nivel">40</label>
					</div>
					
					<div style="width:261px;position:relative;bottom:15px;color:rgb(99, 43, 141);font-family:Times New Roman;font-size:105px;font-weight:bold;text-align:center">
							<label id ="indicadorSumas">7/10</label>
					</div>
					<div style="width:261px;position:relative;top:15px;color:black;font-family:Times New Roman;font-size:70px;text-align:center">
							<label id ="minutero" style="font-family:digital7mono">00:00</label>
							
					</div>
				</div>	
				
				<div style="width:62%;height:100%;float:left;background-image:url(cuadroSuma3.png);background-repeat:no-repeat">
						<div id="llevadaDecenas" style="width:32px;height:49px;position:relative;top:23px;left:303px;float:left;background-image:url(casillaLlevada.png);background-repeat:no-repeat">
						</div>
						<div id="llevadaCentenas" style="width:32px;height:50px;position:relative;top:23px;left:395px;float:left;background-image:url(casillaLlevada.png);background-repeat:no-repeat">
						</div>
				</div>
				
				<div style="width:15%;height:100%;float:left;position:relative;right:220px">
					<a onclick="javascript:comprobarSuma()"><img src="cerrarAspa.png"/></a>
				</div>
				
		   </div>
			
			<!-- CAPA DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<div style="width:100%;height:27%">
					<div style="float:left;width:75%;height:100%;background-image:url(tablaNumeros.png);background-repeat:no-repeat">
						<a id="cero" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">0</a>
						<a id="uno" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:50px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">1</a>
						<a id="dos" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:82px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">2</a>
						<a id="tres" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:114px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">3</a>
						<a id="cuatro" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:146px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">4</a>
						<a id="cinco" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:178px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">5</a>
						<a id="seis" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:210px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">6</a>
						<a id="siete" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:242px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">7</a>
						<a id="ocho" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:274px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">8</a>
						<a id="nueve" onclick="javascript:ponerDigito(this.id)" style="float:left;position:relative;left:306px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 145px">9</a>
					</div>
					
					<div id="capaBotonCheckSuma" style="float:left;width:25%;height:100%;position:relative;bottom:25px;right:110px">
						<a onclick="javascript:comprobarSuma()"><img src="checkBoton.png"/></a>
					</div>
			</div>
	</div>
  </body>
</html>