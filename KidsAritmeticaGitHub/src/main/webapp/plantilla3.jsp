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
	 	font-family:'digital-clock-font';
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
	
	var x = setInterval(function() {
					if(nivelIniciado)
						document.getElementById('posAbsoluta').innerHTML =""+cronometro++;
			}, 1000);

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
  
  
  
  function mueveReloj(){ 
	   	momentoActual = new Date() 
	   	hora = momentoActual.getHours() 
	   	minuto = momentoActual.getMinutes() 
	   	segundo = momentoActual.getSeconds() 

	   	horaImprimible = hora + " : " + minuto + " : " + segundo 

	   	document.form_reloj.reloj.value = horaImprimible 

	   	setTimeout("mueveReloj()",1000) 
	}
  
//Botón 1: Estado empezar: Poner en marcha el crono
  function empezar() {
        emp=new Date() //fecha inicial (en el momento de pulsar)
        elcrono=setInterval(tiempo,10); //función del temporizador.
        marcha=1 //indicamos que se ha puesto en marcha.
        document.cron.boton1.value="Reiniciar"; //Cambiar estado del botón
        document.cron.boton2.disabled=false; //activar botón de pausa
        }
  //función del temporizador			
 /* function tiempo() { 
       actual=new Date(); //fecha a cada instante
          //tiempo del crono (cro) = fecha instante (actual) - fecha inicial (emp)
       cro=actual-emp; //milisegundos transcurridos.
       cr=new Date(); //pasamos el num. de milisegundos a objeto fecha.
       cr.setTime(cro); 
          //obtener los distintos formatos de la fecha:
       cs=cr.getMilliseconds(); //milisegundos 
       cs=cs/10; //paso a 
       cs=Math.round(cs); //redondear las centésimas
       sg=cr.getSeconds(); //segundos 
       mn=cr.getMinutes(); //minutos 
       ho=cr.getHours()-1; //horas 
          //poner siempre 2 cifras en los números		 
       if (cs<10) {cs="0"+cs;} 
       if (sg<10) {sg="0"+sg;} 
       if (mn<10) {mn="0"+mn;} 
          //llevar resultado al visor.		 
       visor.innerHTML=ho+" "+mn+" "+sg+" "+cs; 
       }*/
	  
	
  </script>
</head>

  <body onload="javascript:calcularSuma()">
	<div style="height:765px">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="width:100%;height:73%">
				<div style="width:23%;height:100%;float:left;background-image:url(marcador.png);background-repeat:no-repeat">
				</div>	
				
				<div style="width:62%;height:100%;float:left;background-image:url(cuadroSuma3.png);background-repeat:no-repeat">
				</div>
				
				<div style="width:15%;height:100%;float:left;background-image:url(cerrarAspa.png);background-repeat:no-repeat;position:relative;right:220px">
				</div>
				
		   </div>
			
			<!-- CAPA DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<div style="width:100%;height:27%">
					<div style="float:left;width:75%;height:100%;background-image:url(tablaNumeros.png);background-repeat:no-repeat">	
					</div>
					
					<div id="capaBotonCheckSuma" style="float:left;width:25%;height:100%;position:relative;bottom:25px;right:110px">
						<a onclick="javascript:comprobarSuma()"><img src="checkBoton.png"/></a>
					</div>
			</div>
			
			<!-- 
			
			<div style="width:100%;height:20%">
				<div style="float:left;width:80%;height:100%">
				
						<div style="width:88px;height:118px;float:left;background-image:url(capaDigitoCero.png);background-repeat:no-repeat;margin-top:10px;margin-left:135px">
							<label id="cero" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">0</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="uno" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px" >1</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="dos" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">2</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="tres" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">3</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="cuatro" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">4</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="cinco" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">5</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="seis" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">6</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="siete" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">7</label>
						</div>
						<div style="width:86px;height:118px;float:left;background-image:url(cuadriculaDigito.png);background-repeat:no-repeat;margin-top:10px">
							<label id="ocho" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">8</label>
						</div>
						<div style="width:92px;height:118px;float:left;background-image:url(capaDigitoNueve.png);background-repeat:no-repeat;margin-top:10px;">
							<label id="nueve" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:18px;bottom:5px;color:black;
									 font-family:Calibri;
									 font-size: 105px">9</label>
						</div>
				
				</div>
				<div style="float:right;width:20%;height:100%;background-image:url(menuButton.png);background-repeat:no-repeat;;margin-top:25px">
						<a href="index.jsp" style="color:red;font-size: 48px;font-family:Berlin Sans FB Demi;position:relative;left:45px;top:25px;text-decoration-line: none;">MENU</a>
				</div>
		   </div> 
	
			 -->
	
	
	
	</div>
	
  </body>
</html>