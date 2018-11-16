<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>PlayAddition</title>
  <script>
  function irPrincipal(){
		 location.href = "inicioPlayAddition.jsp"
  }
  </script>
</head>

  <body>
		<div style="position:relative;top:50px;left:20px">
			<div style="float:left;cursor:pointer">
				<img src="selectYourLevel.png" style="cursor:pointer">
			</div>
			<div style="float:left;cursor:pointer">
				<img src="aspaCerrarSelectYourLevel.png" style="cursor:pointer">
			</div>
		</div>
			
		<div style="width:750px;height:300px">
			
			<div style="width:500px;height:250px;float:left;cursor:pointer;position:relative;top:100px">
	  			<div style="width:99px;height:95px;float:left;background-image:url(fondoNivelNormal.png);background-repeat:no-repeat;text-align: center;border: 5px solid;border-color:rgb(32, 56, 100)">
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">1</label>
					</div>
				</div>
				
				<div style="width:99px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 5px solid;border-color:rgb(32, 56, 100);
				position:relative;right:2px">
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">2</label>
					</div>
				</div>
				
				<div style="width:99px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 5px solid;border-color:rgb(32, 56, 100);
				position:relative;right:2px">
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">3</label>
					</div>
				</div>
				
				<div style="width:99px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 5px solid;border-color:rgb(32, 56, 100);
				position:relative;right:2px">
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label style="position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">4</label>
					</div>
				</div>
 			</div>
 			
 			<div style="float:left;cursor:pointer;top:100px" onclick="irPrincipal()">
	  			<img src="goToLevel.png">
 			</div>
 		</div>
  </body>
</html>