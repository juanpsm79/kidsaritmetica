<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="./js/jquery.flip.min.js"></script>
  <script>
 	var nivel
 	
 	function selectNivel(nivel){
 		window.opener.callback(nivel);
 		window.close();
 	}
  </script>
</head>

  <body style="height:100%">
		<div style="position:relative;top:20px;left:98px;width:1206px;height:694px;background-image:url(sal1.png);background-repeat:no-repeat">
			<div style="position:relative;top:356px;left:495px">
				<a onclick="selectNivel(1)" style="cursor:pointer;position:relative;top:100px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 1</a>
				<a onclick="selectNivel(2)" style="cursor:pointer;position:relative;top:163px;right:195px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 2</a>
				<a onclick="selectNivel(3)" style="cursor:pointer;position:relative;top:224px;right:380px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 3</a>
				<a onclick="selectNivel(4)" style="cursor:pointer;position:relative;top:286px;right:565px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 4</a>
			</div>
 		</div>
		<div style="position:relative;top:53px;left:100px;width:1196px;height:692px;background-image:url(sal2.png);background-repeat:no-repeat">
		</div>
		<div style="position:relative;top:70px;left:100px;width:1201px;height:477px;background-image:url(sal3.png);background-repeat:no-repeat">
		</div>
		<div style="position:relative;top:20px;left:100px;width:1212px;height:393px;background-image:url(sal4.png);background-repeat:no-repeat">
		</div>
		<div style="position:relative;top:20px;left:98px;width:1218px;height:437px;background-image:url(sal5.png);background-repeat:no-repeat">
		</div>
		<div style="position:relative;top:20px;left:98px;width:1206px;height:489px;background-image:url(sal6.png);background-repeat:no-repeat">
		</div>
		<div style="position:relative;top:20px;left:98px;width:1201px;height:556px;background-image:url(sal7.png);background-repeat:no-repeat">
		</div>
  </body>
</html>