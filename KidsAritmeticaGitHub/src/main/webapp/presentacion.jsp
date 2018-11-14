<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>PlayAddition</title>
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
  
  function irPrincipal(){

		  location.href = "inicioPlayAddition.jsp"
  }
	  
	
  </script>
</head>

  <body>
		<div style="width:1560px;height:765px">
			<div id="izquierda" style="float:left;position:relative;left:50px;z-index:10">
	  			<div>	
	  				<img src="followUs.png">
	  			</div>
	  			<div>
	  				<div style="float:left;cursor:pointer">
	  					<img src="twitter.png" style="cursor:pointer">
	  				</div>
	  				<div style="float:left;cursor:pointer;position:relative;left:3px;bottom:1px">
	  					<img src="facebook.png" style="cursor:pointer">
	  				</div>
	  				<div style="float:left;position:relative;left:3px;bottom:1px">
	  					<img src="instagram.png" style="cursor:pointer">
	  				</div>
	  			</div>
	  		</div>
			<div id="centro" onclick="javascript:irPrincipal()" style="margin-top:100px;float:left;position:relative;right:125px;cursor: pointer">
				<img src="logoPlayAddition.png">
			</div>
			<div id="derecha" style="height:100%">
					<div>
						<div style="float:left;cursor:pointer;position:relative;right:255px">
		  					<img src="signUp.png">
		  				</div>
		  				<div style="float:left;position:relative;right:255px;cursor:pointer">
		  					<img src="loginBoton.png">
		  				</div>
	  				</div>
	  				<div style="cursor:pointer;position:relative;top:550px;right:428px">
						<img src="contactSupport.png">
					</div>
  			</div>
		</div>
  </body>
</html>