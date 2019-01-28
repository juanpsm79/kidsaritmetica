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
 		if(window.opener!=null) {
 			window.opener.callback(nivel);
 			window.close();
 		}else{
 			$.ajax({
 				  url: "/hello",
 				  method: "post",
 				  data:{nivel: ''+nivel},
 				 // dataType: "json",
 				  success : function(responseText) {
 						location.href = "descripcionNivel.jsp";
 				  }
 				});
 		}
 	}
  </script>
</head>

  <body>
  
  	<div style="width:80vw;position:absolute;left:10vw">
  		<img src="seeAllLevels.png" style="width:80vw"/>
  		<a onclick="selectNivel(1)" style="cursor:pointer;position:absolute;top:27.3vw;left:31.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(2)" style="cursor:pointer;position:absolute;top:30.9vw;left:33.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(3)" style="cursor:pointer;position:absolute;top:34.35vw;left:35.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(4)" style="cursor:pointer;position:absolute;top:37.85vw;left:37.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		<a onclick="selectNivel(5)" style="cursor:pointer;position:absolute;top:41.35vw;left:39.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(6)" style="cursor:pointer;position:absolute;top:44.95vw;left:38.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(7)" style="cursor:pointer;position:absolute;top:48.45vw;left:40.3vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(8)" style="cursor:pointer;position:absolute;top:52.05vw;left:42vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(9)" style="cursor:pointer;position:absolute;top:55.54vw;left:44.2vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(10)" style="cursor:pointer;position:absolute;top:59.11vw;left:46.6vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(11)" style="cursor:pointer;position:absolute;top:62.72vw;left:41.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		<a onclick="selectNivel(12)" style="cursor:pointer;position:absolute;top:73.9vw;left:46.1vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(13)" style="cursor:pointer;position:absolute;top:77.47vw;left:44vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		 
		
		<a onclick="selectNivel(14)" style="cursor:pointer;position:absolute;top:99.15vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(15)" style="cursor:pointer;position:absolute;top:102.65vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(16)" style="cursor:pointer;position:absolute;top:106.25vw;left:46vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(17)" style="cursor:pointer;position:absolute;top:109.8vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		
		<a onclick="selectNivel(18)" style="cursor:pointer;position:absolute;top:119.4vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(19)" style="cursor:pointer;position:absolute;top:122.88vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(20)" style="cursor:pointer;position:absolute;top:126.5vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(21)" style="cursor:pointer;position:absolute;top:130.15vw;left:46vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(22)" style="cursor:pointer;position:absolute;top:133.75vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		<a onclick="selectNivel(23)" style="cursor:pointer;position:absolute;top:152vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(24)" style="cursor:pointer;position:absolute;top:155.45vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(25)" style="cursor:pointer;position:absolute;top:159.05vw;left:44.8vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		<a onclick="selectNivel(26)" style="cursor:pointer;position:absolute;top:166.85vw;left:36vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(27)" style="cursor:pointer;position:absolute;top:170.25vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(28)" style="cursor:pointer;position:absolute;top:174vw;left:39.1vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(29)" style="cursor:pointer;position:absolute;top:177.5vw;left:46.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(30)" style="cursor:pointer;position:absolute;top:181vw;left:50.1vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(31)" style="cursor:pointer;position:absolute;top:184.7vw;left:55.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(32)" style="cursor:pointer;position:absolute;top:188.15vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		
		
		
		<a onclick="selectNivel(33)" style="cursor:pointer;position:absolute;top:195.5vw;left:36vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(34)" style="cursor:pointer;position:absolute;top:198.8vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(35)" style="cursor:pointer;position:absolute;top:202.52vw;left:39.1vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(36)" style="cursor:pointer;position:absolute;top:206.03vw;left:46.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(37)" style="cursor:pointer;position:absolute;top:209.41vw;left:50.1vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(38)" style="cursor:pointer;position:absolute;top:212.99vw;left:49.81vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(39)" style="cursor:pointer;position:absolute;top:216.56vw;left:55.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
		<a onclick="selectNivel(40)" style="cursor:pointer;position:absolute;top:219.99vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">
  			<img src="playBoton.png" style="position:absolute;width:3.5vw;height:2.5vw"></a>
  	</div>
  </body>
</html>