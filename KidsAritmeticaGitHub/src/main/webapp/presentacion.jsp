<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script>
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
  }
  </script>
  <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-131500537-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-1');
</script>
  
</head>

  <body>
		<div id="izquierda" style="float:left;width:25vw">
			<div style="width:25vw">
				<div style="float:left;cursor:pointer">
					<img src="appstoreBoton.png" style="cursor:pointer;width:12vw">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="googlePlayBoton.png" style="cursor:pointer;width:12vw">
				</div>
			</div>
			
			<div style="position:relative;top:7vw;width:25vw">
				<div>	
					<img src="followUs.png" style="cursor:pointer;width:25vw">
				</div>
				<div style="float:left">
					<img src="twitter.png" style="cursor:pointer;width:5vw">
				</div>
				<div style="float:left">
					<img src="facebook.png" style="cursor:pointer;width:5vw">
				</div>
				<div style="float:left">
					<img src="instagram.png" style="cursor:pointer;width:5vw">
				</div>
			</div>
	 		
 			
	 	</div>

		<div id="derecha" style="position:absolute;left:25vw;width:74vw">	
				<img src="logoPlayAddition.png" style="width:74vw">
 		</div>
 		
 		  
 		<div style="position:absolute;right:0vw">
 				<img src="loginBoton.png" style="float:right;width:9vw;height:6vw">
 				<img src="espaniol.png" style="float:right;width:9vw;height:6vw">
				<img src="playBoton.png" onclick="javascript:irPrincipal()" style="float:right;position:absolute;right:14vw;top:45vw;cursor:pointer;width:15vw;height:10vw">
		</div>
		<div style="position:absolute;top:49vw;left:5vw">
				<img src="contactSupport.png" style="cursor:pointer;width:20vw">
		</div>
		
 		
  </body>
</html>