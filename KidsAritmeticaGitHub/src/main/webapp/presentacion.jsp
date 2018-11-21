<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PlayAddition</title>
  <script>
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
  }
  </script>
</head>

  <body>
		<div id="izquierda" style="float:left;z-index:10">
			<div style="position:relative;top:100px;width:400px;height:100px;left:20px">
				<div style="float:left;cursor:pointer">
					<img src="appstoreBoton.png" style="cursor:pointer">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="googlePlayBoton.png" style="cursor:pointer">
				</div>
			</div>
			
			<div style="position:relative;top:100px;left:20px;">
				<div>	
					<img src="followUs.png">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="twitter.png" style="cursor:pointer">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="facebook.png" style="cursor:pointer">
				</div>
				<div style="cursor:pointer">
					<img src="instagram.png" style="cursor:pointer">
				</div>
			</div>
	 		
 			<div style="position:relative;top:377px;left:20px;cursor:pointer;width:333px;height:91px">
				<img src="contactSupport.png" style="cursor:pointer">
			</div>
	 		</div>
 		
 		<div id="centro" onclick="javascript:irPrincipal()" style="float:left;margin-top:100px;cursor: pointer">
				<img src="logoPlayAddition.png">
		</div>
		
		
		<div id="derecha" style="position:relative;right:90px;float:left;width:378px;height:600px">	
			<div style="float:right;cursor:pointer;position:relative;top:100px;right:90px">
				<div style="float:left;width:154px;height:95px">
	  				<img src="espaniol.png">
	  			</div>
				<div style="float:left;width:222px;height:115px">
	  				<img src="loginBoton.png">
	  			</div>
 			</div>
 			<div style="float:right;cursor:pointer;position:relative;top:360px;right:80px">
	  			<img src="playBoton.png">
 			</div>
 		</div>
 		
  </body>
</html>