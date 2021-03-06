<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>PlayAddition</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="./css/inputRange.css">
  <link rel="stylesheet" href="./css/rSlider.min.css">
  
  
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
  <script src="./js/rSlider.min.js"></script>
  <script>
  $( function() {
	  
	  var mySlider = new rSlider({
	        target: '#sampleSlider',
	        values: [0, 1, 2, 3, 4, 5, 6, 7,8,9,10,11,12,13,14,15,16,17,18,19,20],
	        range: false,
	        tooltip: false,
	        scale: true,
	        labels: true
	    });

  	
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
			  url: "/restas",
			  method: "post",
			  data:{nivel: ''+value},
			  dataType: "json",
			  success : function(responseText) {
			  var innerhtml =""+responseText.leyenda+ "<br>";
			  for(var i=0 ; i<responseText.restas.length; i++){
			  	innerhtml += "<div style=\"float:left;margin-left:20px\"><p style='text-align:right'>("+responseText.restas[i].nivel+")<br>" +responseText.restas[i].operador1+ "<br>"+responseText.restas[i].operador2+"<br>____<br>"+responseText.restas[i].resultado+"</p></div>";
			  }	
			  document.getElementById("targetElement").innerHTML = ""+innerhtml;
			  }
			});
  	}
	  
	
  </script>
</head>

  <body style="background-image:url(fondoKitsAritmetica.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">
			<div>
				  <h1>PlaySubstractions Generator</h1>
				  <fieldset>
				    <legend>Level chooser</legend>
				    <div>
				      
				      <input type="radio" name="nivel" id="nivel1" value="1"/>
				      <label for="nivel1">Level 1</label>
				      
				      <input type="radio" name="nivel" id="nivel2" value="2"/>
				      <label for="nivel2">Nivel 2</label>
				      
				      <input type="radio" name="nivel" id="nivel3" value="3"/>
				      <label for="nivel3">Level 3</label>
				    
				       
				      <input type="radio" name="nivel" id="nivel4" value="4"/>
				      <label for="nivel4">Level 4</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel5" value="5"/>
				      <label for="nivel5">Level 5 (1,4)</label>
				      
				      <input type="radio" name="nivel" id="nivel6" value="6"/>
				      <label for="nivel6">Level 6 (0,5)</label>
				      
				      <input type="radio" name="nivel" id="nivel7" value="7"/>
				      <label for="nivel7">Level 7 (0,6)</label>
				      
				      <input type="radio" name="nivel" id="nivel8" value="8"/>
				      <label for="nivel8">Level 8 (0,7)</label>
				      
				      <input type="radio" name="nivel" id="nivel9" value="9"/>
				      <label for="nivel9">Level 9 (0,8)</label>
				      
				      <input type="radio" name="nivel" id="nivel10" value="10"/>
				      <label for="nivel10">Level 10 (0,9)</label>
				      
				      <input type="radio" name="nivel" id="nivel11" value="11"/>
				      <label for="nivel11">Level 11</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel12" value="12"/>
				      <label for="nivel12">Level 12</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel13" value="13"/>
				      <label for="nivel13">Level 13</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel14" value="14"/>
				      <label for="nivel14">Level 14 (Levels 12-13)</label>
				      
				       
				      
				      <input type="radio" name="nivel" id="nivel15" value="15"/>
				      <label for="nivel15">Level 15</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel16" value="16"/>
				      <label for="nivel16">Level 16</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel17" value="17"/>
				      <label for="nivel17">Level 17</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel18" value="18"/>
				      <label for="nivel18">Level 18 (Levels 15-17)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel19" value="19">
				      <label for="nivel19">Level 19</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel20" value="20"/>
				      <label for="nivel20">Level 20</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel21" value="21"/>
				      <label for="nivel21">Level 21</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel22" value="22"/>
				      <label for="nivel22">Level 22 (Levels 19-21)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel23" value="23"/>
				      <label for="nivel23">Level 23</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel24" value="24"/>
				      <label for="nivel24">Level 24</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel25" value="25"/>
				      <label for="nivel25">Level 25</label>
				      
				     
				      
				      <input type="radio" name="nivel" id="nivel26" value="26"/>
				      <label for="nivel26">Level 26 (Levels 23-25)</label>
				      
				        
				      
				      <input type="radio" name="nivel" id="nivel26" value="27"/>
				      <label for="nivel27">Level 27</label>
				      
				      <input type="radio" name="nivel" id="nivel28" value="28"/>
				      <label for="nivel28">Level 28</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel29" value="29"/>
				      <label for="nivel29">Level 29</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel29" value="30"/>
				      <label for="nivel30">Level 30</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel31" value="31"/>
				      <label for="nivel31">Level 31</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel32" value="32"/>
				      <label for="nivel32">Level 32 (Levels 27-31)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel33" value="33"/>
				      <label for="nivel33">Level 33</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel34" value="34"/>
				      <label for="nivel34">Level 34</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel35" value="35"/>
				      <label for="nivel35">Level 35</label>
				      
				      <input type="radio" name="nivel" id="nivel36" value="36"/>
				      <label for="nivel36">Level 36</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel37" value="37"/>
				      <label for="nivel37">Level 37</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel38" value="38"/>
				      <label for="nivel38">Level 38</label>
				      
				      <input type="radio" name="nivel" id="nivel39" value="39"/>
				      <label for="nivel39">Level 39</label>
				      
				     
				      <input type="radio" name="nivel" id="nivel40" value="40"/>
				      <label for="nivel40">Level 40 (Levels 33-39)</label>
				     
				      
				      <input type="radio" name="nivel" id="nivel41" value="41"/>
				      <label for="nivel41">Level 41</label>
				      
				       <input type="radio" name="nivel" id="nivel42" value="42"/>
				      <label for="nivel42">Level 42</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel43" value="43"/>
				      <label for="nivel41">Level 43</label>
				      
				       <input type="radio" name="nivel" id="nivel44" value="44"/>
				      <label for="nivel42">Level 44</label>
				      
				       <input type="radio" name="nivel" id="nivel46" value="46"/>
				      <label for="nivel46">Level 46</label>
				      
				      <input type="radio" name="nivel" id="nivel47" value="47"/>
				      <label for="nivel47">Level 47</label>
				      
				      <input type="radio" name="nivel" id="nivel48" value="48"/>
				      <label for="nivel48">Level 48</label>
				      
				      <input type="radio" name="nivel" id="nivel49" value="49"/>
				      <label for="nivel49">Level 49</label>
				      
				      <input type="radio" name="nivel" id="nivel50" value="50"/>
				      <label for="nivel50">Level 50</label>
				      
				      <input type="radio" name="nivel" id="nivel51" value="51"/>
				      <label for="nivel49">Level 51</label>
				      
				      <input type="radio" name="nivel" id="nivel52" value="52"/>
				      <label for="nivel50">Level 52</label>
				      
				      
				      <input type="button" id="calcularSuma" onclick="javascript:enviarSuma();" value="Generar Restas"/>
				    </div>
				    <div id="targetElement">
				    	<div id = "leyenda"></div>
					    <div id = "operador1"></div>
					    <div id = "operador2"></div>
				    </div>
				    
				  </fieldset>
		</div>
		<div class="inputDiv">
			<input type="text" id="sampleSlider" />

		</div>
  </body>
</html>