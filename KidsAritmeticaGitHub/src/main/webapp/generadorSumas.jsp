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
			  var innerhtml =""+responseText.leyenda+ "<br>";
			  for(var i=0 ; i<responseText.sumas.length; i++){
			  	innerhtml += "<div style=\"float:left;margin-left:20px\"><p>" +responseText.sumas[i].operador1+ "<br>"+responseText.sumas[i].operador2+"</p></div>";
				}	
				document.getElementById("targetElement").innerHTML = ""+innerhtml;
				
			  }
			});
  	}
	  
	
  </script>
</head>

  <body style="background-image:url(fondoKitsAritmetica.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">

	
	
	
			<div>
				  <h1>Generador de Sumas kidsaritmetica</h1>
				  <fieldset>
				    <legend>Selector de nivel</legend>
				    <div>
				      
				      <input type="radio" name="nivel" id="nivel1" value="1"/>
				      <label for="nivel1">Nivel 1 (0,1)</label>
				      
				      <input type="radio" name="nivel" id="nivel2" value="2"/>
				      <label for="nivel2">Nivel 2 (0,1,2)</label>
				      
				      <input type="radio" name="nivel" id="nivel3" value="3"/>
				      <label for="nivel3">Nivel 3 (0,1,2,3)</label>
				    
				       
				      <input type="radio" name="nivel" id="nivel4" value="4"/>
				      <label for="nivel4">Nivel 4 (0,1,2,3,4)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel5" value="5"/>
				      <label for="nivel5">Nivel 5 (Niveles 1-4)</label>
				      
				      <input type="radio" name="nivel" id="nivel6" value="6"/>
				      <label for="nivel6">Nivel 6 (0,5)</label>
				      
				      <input type="radio" name="nivel" id="nivel7" value="7"/>
				      <label for="nivel7">Nivel 7 (0,6)</label>
				      
				      <input type="radio" name="nivel" id="nivel8" value="8"/>
				      <label for="nivel8">Nivel 8 (0,7)</label>
				      
				      <input type="radio" name="nivel" id="nivel9" value="9"/>
				      <label for="nivel9">Nivel 9 (0,8)</label>
				      
				      <input type="radio" name="nivel" id="nivel10" value="10"/>
				      <label for="nivel10">Nivel 10 (0,9)</label>
				      
				      <input type="radio" name="nivel" id="nivel11" value="11"/>
				      <label for="nivel11">Nivel 11 (Niveles 6-10)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel12" value="12"/>
				      <label for="nivel12">Nivel 12</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel13" value="13"/>
				      <label for="nivel13">Nivel 13</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel14" value="14"/>
				      <label for="nivel14">Nivel 14</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel15" value="15"/>
				      <label for="nivel15">Nivel 15</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel16" value="16"/>
				      <label for="nivel16">Nivel 16</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel17" value="17"/>
				      <label for="nivel17">Nivel 17 (Niveles 14-16)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel18" value="18"/>
				      <label for="nivel18">Nivel 18</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel19" value="19">
				      <label for="nivel19">Nivel 19</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel20" value="20"/>
				      <label for="nivel20">Nivel 20</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel21" value="21"/>
				      <label for="nivel21">Nivel 21</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel22" value="22"/>
				      <label for="nivel22">Nivel 22 (Niveles 18-21)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel23" value="23"/>
				      <label for="nivel23">Nivel 23</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel24" value="24"/>
				      <label for="nivel24">Nivel 24</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel25" value="25"/>
				      <label for="nivel25">Nivel 25</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel26" value="26"/>
				      <label for="nivel26">Nivel 26</label>
				    
				      <input type="button" id="calcularSuma" onclick="javascript:enviarSuma();" value="Generar Suma"/>
				    </div>
				    <div id="targetElement">
				    	<div id = "leyenda"></div>
					    <div id = "operador1"></div>
					    <div id = "operador2"></div>
				    </div>
				    
				  </fieldset>
		</div>
		
		

   
  </body>
</html>