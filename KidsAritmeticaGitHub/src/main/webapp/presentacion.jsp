<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
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
		
		
		<div id="derecha" style="float:left;width:328px;height:600px">	
			<div style="float:right;cursor:pointer;position:relative;top:100px;right:90px">
	  			<img src="loginBoton.png">
 			</div>
 			<div style="float:right;cursor:pointer;position:relative;top:360px;right:80px">
	  			<img src="playBoton.png">
 			</div>
 		</div>
 		
  </body>
</html>