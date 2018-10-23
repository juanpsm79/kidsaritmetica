<%
    String nivel =  (String) session.getAttribute("nivel");
   
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>Kids Aritmetica</title>
  <style>
   
  a {
	    font-family:"Berlin Sans FB Demi";  
	    color:rgb(0, 112, 192);
	    font-size: 28px;
	    cursor: pointer;
	}
  
  </style>
  <script>
  
 
  

	function asyncCall() {
		
	
	  
	  innerHtml="<a onclick=\"javascript:comprobarSuma();\" style=\"font-size: 40px;color:rgb(0, 176, 80);position:relative;top:75px;left:55px;text-decoration-line: none;\">CHECK</a>";
	  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
	  var sumasActuales = parseInt(document.getElementById('indicadorSumas').innerHTML, 10);
	  sumasActuales++;
	  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales;
	  document.getElementById('sumaUnidades').innerHTML ="&nbsp;";
	  
	  var aux = Math.floor(Math.random() * 10);
	  document.getElementById('unidades1').innerHTML = ""+aux
	  var aux1 = Math.floor(Math.random() * 10);
	  document.getElementById('unidades2').innerHTML = ""+aux1
	}

	

  
 /* function enviarSuma() {
  		var radios = document.getElementsByName('nivel');
  		var value="";
		for (var i = 0, length = radios.length; i < length; i++){
			if (radios[i].checked) {
				value =radios[i].value;
				break;
			}
		}
		$.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+value},
			  dataType: "json",
			  success : function(responseText) {
			  document.getElementById("leyenda").innerHTML = ""+responseText.leyenda+ " " +responseText.colisiones+ " tablas "+responseText.tablas;
				document.getElementById("operador1").innerHTML = ""+responseText.operador1;
				document.getElementById("operador2").innerHTML = ""+responseText.operador2;
			  }
			});
  	}*/
  
  function ponerDigito (idDigito) {
	  var digito = document.getElementById(idDigito).innerHTML;
	  document.getElementById('sumaUnidades').innerHTML = digito;
  }
  
  function comprobarSuma(){
	  var sumaAlumno = parseInt(document.getElementById('sumaUnidades').innerHTML, 10);
	  var unidades1 = parseInt(document.getElementById('unidades1').innerHTML, 10);
	  var unidades2 = parseInt(document.getElementById('unidades2').innerHTML, 10);
	  if (sumaAlumno == unidades1+unidades2){
		  var innerHtml="<label style=\"font-size: 40px;font-family:Berlin Sans FB Demi;color:rgb(0, 176, 80);position:relative;top:75px;left:35px\">CORRECT</label>";
		  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
		  
		  
		  
		 
		  
	  } else {
		  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkIncorrect.png)";
		  var innerHtml="<label style=\"font-size: 25px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;top:45px;left:50px\">INCORRECT</label><BR>";
		  innerHtml+="<label style=\"font-size: 42px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;top:45px;left:53px\">START</label><BR>";
		  innerHtml+="<label style=\"font-size: 42px;font-family:Berlin Sans FB Demi;color:yellow;position:relative;top:45px;left:53px\">OVER</label>";
		  document.getElementById('capaBotonCheckSuma').innerHTML =""+innerHtml;
	  }
  }
	  
	
  </script>
</head>

  <body style="background-image:url(fondoPlayAddition.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">
	
	<div style="width:1300px;height:790px;">
			
			<div style="width:100%;height:22%">
				<div style="width:30%;height:100%;float:left;background-image:url(level.png);background-repeat:no-repeat;">
							<label style="position:relative;left:240px;top:10px;color:rgb(0, 51, 204);
										 font-family:Berlin Sans FB Demi;
										 font-size: 105px;"><%=nivel%>0</label>
				</div>	
				
				<div style="width:45%;height:100%;float:left">&nbsp;</div>
				
				<div style="float:right;width:25%;height:100%">
					<div style="background-image:url(scoreboard.png);background-repeat:no-repeat;height:100%">
						<div style="width:50%;float:left; color:rgb(204, 51, 153);
									 font-family:Berlin Sans FB Demi;
									 font-size: 88px;font-weight: bold;position:relative;left:55px;top:60px"><label id="indicadorSumas">1</label></div>
						<div style="width:50%;float:left;color:rgb(204, 51, 153);
									 font-family:Berlin Sans FB Demi;
									 font-size: 88px;font-weight: bold;position:relative;top:60px"><label>10</label></div>
					</div>
				</div>
				
		   </div>
	
			<div style="width:100%;height:58%">
				<div style="width:40%;height:100%;float:left">			
				</div>
				
				<div style="float:left;width:40%;height:100%">
					<div style="float:left;width:50%;height:100%;position:relative;bottom:100px;">	
						<div style="position:relative;left:70px;top:20px"><label id="unidades1" style="color:black;
									 font-family:Calibri;
									 font-size: 135px;">1</label></div>
						<div style="background-image:url(simboloSuma.png);background-repeat:no-repeat;background-size:cover;width:78px;height:78px"><label style="color:black;
									 font-family:Calibri">&nbsp;</label></div>
						<div style="position:relative;left:65px;bottom:30px"><label id="unidades2" style="color:black;
									 font-family:Calibri;
									 font-size: 135px;">0</label></div>
						<div style="position:relative;bottom:140px;"><label style="color:black;
									 font-family:Calibri;
									 font-size: 135px">___</label></div>
						<div style="position:relative;bottom:140px;left:50px;background-image:url(casillaBlancoSuma.png);width:96px;height:117px;background-repeat:no-repeat;border:5px solid red">
							<label id="sumaUnidades"style="position:relative;left:15px;bottom:25px;color:black;
									 font-family:Calibri;
									 font-size: 135px">&nbsp;</label>
						</div>
					</div>
					<div style="float:right;width:50%;height:100%">
						<div id="capaBotonCheckSuma" style="background-image:url(checkButton.png);background-repeat:no-repeat;height:100%;position:relative;top:145px;right:10px">
							<a onclick="javascript:comprobarSuma();setTimeout(asyncCall, 2000);" style="font-size: 40px;color:rgb(0, 176, 80);position:relative;top:75px;left:55px;text-decoration-line: none;">CHECK</a>
							
						</div>
					</div>
					
				</div>
				
				<div style="float:left;width:20%;height:100%">
					&nbsp;
				</div>
			</div>
			
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
	
	</div>
	
  </body>
</html>