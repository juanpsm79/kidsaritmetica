<%@ page import="java.io.*,
                 java.net.*,
                 java.util.*" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>PlayAddition</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
			  	innerhtml += "<div style=\"float:left;margin-left:20px\"><p style='text-align:right'>("+responseText.sumas[i].nivel+")<br>" +responseText.sumas[i].operador1+ "<br>"+responseText.sumas[i].operador2+"<br>____<br>"+responseText.sumas[i].resultado+"</p></div>";
			  }	
			  document.getElementById("targetElement").innerHTML = ""+innerhtml;
			  }
			});
  	}
	  
	
  </script>
</head>

  <body style="background-image:url(fondoKitsAritmetica.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">

	
	
	
			<div>
				  <h1>PlayAddition Adds Generator</h1>
				  <fieldset>
				    <legend>Level chooser</legend>
				    <div>
				      
				      <input type="radio" name="nivel" id="nivel1" value="1"/>
				      <label for="nivel1">Level 1 (0,1)</label>
				      
				      <input type="radio" name="nivel" id="nivel2" value="2"/>
				      <label for="nivel2">Nivel 2 (0,1,2)</label>
				      
				      <input type="radio" name="nivel" id="nivel3" value="3"/>
				      <label for="nivel3">Level 3 (1,2,3)</label>
				    
				       
				      <input type="radio" name="nivel" id="nivel4" value="4"/>
				      <label for="nivel4">Level 4 (2,3,4)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel5" value="5"/>
				      <label for="nivel5">Level 5 (Levels 4)</label>
				      
				      <input type="radio" name="nivel" id="nivel6" value="6"/>
				      <label for="nivel6">Level 6 (2,3,4,5)</label>
				      
				      <input type="radio" name="nivel" id="nivel7" value="7"/>
				      <label for="nivel7">Level 7 (2,3,4,5,6)</label>
				      
				      <input type="radio" name="nivel" id="nivel8" value="8"/>
				      <label for="nivel8">Level 8 (1,2,3,4,5,6,7)</label>
				      
				      <input type="radio" name="nivel" id="nivel9" value="9"/>
				      <label for="nivel9">Level 9 (0,8)</label>
				      
				      <input type="radio" name="nivel" id="nivel10" value="10"/>
				      <label for="nivel10">Level 10 (0,9)</label>
				      
				      <input type="radio" name="nivel" id="nivel11" value="11"/>
				      <label for="nivel11">Level 11 (Level 10)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel12" value="12"/>
				      <label for="nivel12">Level 12</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel13" value="13"/>
				      <label for="nivel13">Level 13 (Levels 10-12)</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel14" value="14"/>
				      <label for="nivel14">Level 14</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel15" value="15"/>
				      <label for="nivel15">Level 15</label>
				      
				      
				      
				      <input type="radio" name="nivel" id="nivel16" value="16"/>
				      <label for="nivel16">Level 16</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel17" value="17"/>
				      <label for="nivel17">Level 17 (Levels 14-16)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel18" value="18"/>
				      <label for="nivel18">Level 18</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel19" value="19">
				      <label for="nivel19">Level 19</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel20" value="20"/>
				      <label for="nivel20">Level 20</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel21" value="21"/>
				      <label for="nivel21">Level 21</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel22" value="22"/>
				      <label for="nivel22">Level 22 (Levels 18-21)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel23" value="23"/>
				      <label for="nivel23">Level 23</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel24" value="24"/>
				      <label for="nivel24">Level 24</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel25" value="25"/>
				      <label for="nivel25">Level 25 (Levels 23-24)</label>
				      
				      
				      <input type="radio" name="nivel" id="nivel26" value="26"/>
				      <label for="nivel26">Level 26</label>
				      
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
				      <label for="nivel32">Level 32 (Levels 26-31)</label>
				      
				      
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
				      
				    
				      <input type="button" id="calcularSuma" onclick="javascript:enviarSuma();" value="Generar Suma"/>
				    </div>
				    <div id="targetElement">
				    	<div id = "leyenda"></div>
					    <div id = "operador1"></div>
					    <div id = "operador2"></div>
				    </div>
				    
				  </fieldset>
		</div>
		<p><%= getGreeting(request) %></p>
  </body>
</html>
<%!
   // ===========================================
   //    Helper method to get the language specific greeting
   // ===========================================

   /**
   * Gets the greeting message appropriate for
   * this locale
   */
   private String getGreeting
      (HttpServletRequest request)
   {
      Locale locale = null;
      String lang = request.getParameter("lang");
      
      if (lang != null) {
        locale = new Locale(lang);
      } else {
        locale = request.getLocale();
      }
      ResourceBundle RB = ResourceBundle.getBundle("Messages", locale);
      String greeting = RB.getString("greeting");
      return greeting;
   }
%>