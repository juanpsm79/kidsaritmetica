<%
    String nivel =  (String) session.getAttribute("nivel");
    if ( nivel == null)
    	session.setAttribute("nivel", "1");
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>Kids Aritmetica</title>
  <style>
   
  a {
	    font-family:"Berlin Sans FB Demi";  
	    text-align:center;
	    color:black;
	    text-decoration:none;
	    font-size: 80px;
	    color:red;
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
	  
	
  </script>
</head>

  <body style="background-image:url(fondoKitsAritmetica.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">
	
	
	<div align="center" style="width:600px;height:600px;position:relative;top:100px;left:350px">
		<div style="height:50%">
			<div style="background-image:url(practiceVacio.png);
								  background-repeat:no-repeat;height:50%;position:relative;left:25px">
					<div>
						<a href="principal.jsp">PLAY ++</a>
					</div>
			</div>
		</div>
		<div style="height:50%">
				<label style="color:rgb(0, 112, 192);
							 font-family:Broadway;
							 font-size: 80px;">LEVEL </label>
				<label style="color:rgb(189, 100, 3);
							 font-family:Broadway;
							 font-size: 115px;"><%= (String) session.getAttribute("nivel") %></label>
			
		</div>
	</div> 
  </body>
</html>