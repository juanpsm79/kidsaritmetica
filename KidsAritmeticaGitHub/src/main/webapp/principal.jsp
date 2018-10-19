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
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script>
  $( function() {
  	
  } );
  
  function enviarSuma() {
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
  	}
  
  function ponerDigito (idDigito) {
	  var digito = document.getElementById(idDigito).innerHTML;
	  document.getElementById('sumaUnidades').innerHTML = digito;
  }
  
  function comprobarSuma(){
	  var sumaAlumno = parseInt(document.getElementById('sumaUnidades').innerHTML, 10);
	  var unidades1 = parseInt(document.getElementById('unidades1').innerHTML, 10);
	  var unidades2 = parseInt(document.getElementById('unidades2').innerHTML, 10);
	  if(sumaAlumno == unidades1+unidades2){
		  alert("suma correcta");
		  
		  var sumasActuales = parseInt(document.getElementById('indicadorSumas').innerHTML, 10);
		  sumasActuales++;
		  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales;
		  document.getElementById('sumaUnidades').innerHTML ="&nbsp;";
		  
		  var aux = Math.floor(Math.random() * 10);
		  document.getElementById('unidades1').innerHTML = ""+aux
		  var aux1 = Math.floor(Math.random() * 10);
		  document.getElementById('unidades2').innerHTML = ""+aux1
		  
	  }
	  else
		  location.href = "sumaIncorrecta.jsp"
  }
	  
	
  </script>
</head>

  <body style="background-image:url(fondoKitsAritmetica.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">
	
	<div style="width:1300px;height:700px;">
			
			<div style="width:100%;height:15%">
						<label style="color:rgb(0, 112, 192);
									 font-family:Broadway;
									 font-size: 36px;">LEVEL </label>
						<label style="color:rgb(189, 100, 3);
									 font-family:Broadway;
									 font-size: 48px;"><%=nivel%></label>
					
		   </div>
	
			<div style="width:100%;height:60%">
				<div style="width:45%;height:100%;float:left">			
				</div>
				
				<div style="float:left;width:35%;height:100%">
					<div style="float:left;width:50%;height:100%">	
						<div style="position:relative;left:60px;top:20px"><label id="unidades1" style="color:black;
									 font-family:Calibri;
									 font-size: 80px;">1</label></div>
						<div><label style="color:black;
									 font-family:Calibri;
									 font-size: 66px;">+</label></div>
						<div style="position:relative;left:60px;bottom:30px"><label id="unidades2" style="color:black;
									 font-family:Calibri;
									 font-size: 80px;">0</label></div>
						<div style="position:relative;bottom:110px;"><label style="color:black;
									 font-family:Calibri;
									 font-size: 80px">___</label></div>
						<div style="position:relative;bottom:110px;left:45px;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat">
							<label id="sumaUnidades"style="position:relative;left:15px;color:black;
									 font-family:Calibri;
									 font-size: 80px">&nbsp;</label>
						</div>
					</div>
					<div style="float:left;width:50%;height:100%">
						<div style="background-image:url(checkSuma.gif);background-repeat:no-repeat;height:100%;position:relative;top:70px;right:35px">
							<a onclick="javascript:comprobarSuma();" style="position:relative;top:75px;left:55px;text-decoration-line: underline;">CHECK</a>
							<a onclick="javascript:comprobarSuma();" style="position:relative;top:95px;right:33px;font-size: 16px;text-decoration-line: underline;">CORRECT</a>
						</div>
					</div>
					
				</div>
				
				<div style="float:left;width:20%;height:100%">
						<label id="indicadorSumas" style="color:black;
									 font-family:Calibri;
									 font-size: 60px;font-weight: bold;position:relative;left:30px;">1</label>
						<label style="color:black;
									 font-family:Calibri;
									 font-size: 60px;font-weight: bold;position:relative;left:30px;">/</label>
						<label style="color:black;
									 font-family:Calibri;
									 font-size: 60px;font-weight: bold;position:relative;left:30px;">10</label>
				</div>
			</div>
			
			<div style="width:100%;height:25%">
				<div style="float:left;width:80%;height:100%;background-image:url(fondoTablaNumeros.gif);background-repeat:no-repeat">
				
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px;margin-left:50px">
							<label id="cero" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">0</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="uno" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px" >1</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="dos" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">2</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="tres" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">3</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="cuatro" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">4</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="cinco" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">5</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="seis" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">6</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="siete" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">7</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="ocho" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">8</label>
						</div>
						<div style="width:9%;float:left;background-image:url(cuadriculaDigito.gif);background-repeat:no-repeat;margin-top:23px">
							<label id="nueve" onclick="javascript:ponerDigito(this.id)" style="position:relative;left:12px;color:black;
									 font-family:Calibri;
									 font-size: 80px">9</label>
						</div>
				
				</div>
				<div style="float:left;width:20%;height:100%;background-image:url(menu.gif);background-repeat:no-repeat;margin-top:50px">
					<a href="index.jsp" style="font-size: 44px;font-family:Calibri;position:relative;left:30px;top:15px">MENU</a>
				</div>
		   </div> 
	
	</div>
	
  </body>
</html>