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
		<div id="izquierda" style="float:left;width:27vw">
			<div>
				<div style="float:left;cursor:pointer">
					<img src="appstoreBoton.png" style="cursor:pointer;width:13vw">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="googlePlayBoton.png" style="cursor:pointer;width:13vw">
				</div>
			</div>
			
			<div style="float:left;position:relative;top:7vw">
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
	 		
 			<div style="float:left;position:relative;top:21vw">
				<img src="contactSupport.png" style="float:left;cursor:pointer;width:20vw">
			</div>
	 	</div>

		<div id="derecha" style="float:left;width:69vw">	
				<img src="logoPlayAddition.png" style="float:left;width:51vw">
				<img src="espaniol.png" style="position:relative;right:9vw;float:left;width:9vw">
				<img src="loginBoton.png" style="position:relative;right:9vw;float:left;width:9vw">
				<img src="playBoton.png" onclick="javascript:irPrincipal()" 
				     style="position:relative;right:20vw;top:25vw;cursor:pointer;width:13vw">
 		</div>
 		
  </body>
</html>