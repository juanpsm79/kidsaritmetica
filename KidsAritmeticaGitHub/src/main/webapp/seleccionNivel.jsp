<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <title>PlayAddition</title>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="./js/jquery.flip.min.js"></script>
  <script>
  $( function() {
  } );
  var nivelAnterior =null;
  
  function irPrincipal(){
		 location.href = "inicioPlayAddition.jsp"
  }
  
  function seleccionarNivel(idNivel){
	  if(nivelAnterior!=null){
		  document.getElementById(''+nivelAnterior).style.borderColor="rgb(32, 56, 100)";
	  }
	  document.getElementById(''+idNivel).style.borderColor="red";
	  nivelAnterior = idNivel;
  }
	
  function flip (idNivel) {
	  $("#"+idNivel).flip({
		  axis: 'y',
		  trigger: 'hover',
		  reverse: true
	  });
  }
  </script>
</head>

  <body onload="seleccionarNivel('1')">
		<div style="width:100%;height:350px;position:relative;top:50px;left:20px">
			<div style="float:left">
				<img src="selectYourLevel.png" style="cursor:pointer">
			</div>
			<div style="float:left;cursor:pointer">
				<img src="aspaCerrarSelectYourLevel.png" style="cursor:pointer">
			</div>
		</div>
			
		<div style="width:1140px;height:750px">
			
			<div style="width:1140px;height:95px">
	  			<div id="1" onclick="seleccionarNivel('1')" onmouseover="flip('1')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
	  			background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 4px;border-color:rgb(32, 56, 100)">
	  				<div class="front">
						<div style="text-align:center">
								<label onclick="seleccionarNivel('1')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
						</div>
						
						<div style="text-align:center">
								<label onclick="seleccionarNivel('1')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">1</label>
						</div>
					</div>
					<div class="back" style="background-image:url(1c.png)">
  					</div>
				</div>
				
				<div id="2" onclick="seleccionarNivel('2')" onmouseover="flip('2')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
				<div class="front">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('2')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('2')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">2</label>
					</div>
				</div>	
				<div class="back" style="background-image:url(2c.png)">
    					
  					</div>	
				</div>
				
				<div id="3" onclick="seleccionarNivel('3')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('3')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('3')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">3</label>
					</div>
				</div>
				
				<div id="4" onclick="seleccionarNivel('4')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('4')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('4')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">4</label>
					</div>
				</div>
				
				<div id="5" onclick="seleccionarNivel('5')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('5')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('5')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">5</label>
					</div>
				</div>
				
				<div id="6" onclick="seleccionarNivel('6')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('6')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('6')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">6</label>
					</div>
				</div>
				
				<div id="7" onclick="seleccionarNivel('7')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('7')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('7')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">7</label>
					</div>
				</div>
				
				<div id="8" onclick="seleccionarNivel('8')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('8')" style="position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('8')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">8</label>
					</div>
				</div>
				
				<div id="9" onclick="seleccionarNivel('9')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 2px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('9')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('9')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">9</label>
					</div>
				</div>
				
				<div id="10" onclick="seleccionarNivel('10')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 4px 4px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('10')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('10')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">10</label>
					</div>
				</div>
 			</div>
 			
 			
 			
 			
 			
 			<div style="width:1140px;height:95px">
	  			<div id="11" onclick="seleccionarNivel('11')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
	  			background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 2px 4px;border-color:rgb(32, 56, 100)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('11')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('11')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">11</label>
					</div>
				</div>
				
				<div id="12" onclick="seleccionarNivel('12')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('12')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('12')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">12</label>
					</div>
				</div>
				
				<div id="13" onclick="seleccionarNivel('13')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('13')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('13')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">13</label>
					</div>
				</div>
				
				<div id="14" onclick="seleccionarNivel('14')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('14')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('14')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">14</label>
					</div>
				</div>
				
				<div id="15" onclick="seleccionarNivel('15')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('15')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('15')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">15</label>
					</div>
				</div>
				
				<div id="16" onclick="seleccionarNivel('16')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('16')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('16')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">16</label>
					</div>
				</div>
				
				<div id="17" onclick="seleccionarNivel('17')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('17')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('17')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">17</label>
					</div>
				</div>
				
				<div id="18" onclick="seleccionarNivel('18')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('18')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('18')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">18</label>
					</div>
				</div>
				
				<div id="19" onclick="seleccionarNivel('19')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('19')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('19')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">19</label>
					</div>
				</div>
				
				<div id="20" onclick="seleccionarNivel('20')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 4px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('20')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('20')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">20</label>
					</div>
				</div>
 			</div>
 			
 			
  			<div style="width:1140px;height:95px">
	  			<div id="21" onclick="seleccionarNivel('21')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
	  			background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 2px 4px;border-color:rgb(32, 56, 100)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('21')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('21')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">21</label>
					</div>
				</div>
				
				<div id="22" onclick="seleccionarNivel('22')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('22')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('22')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">22</label>
					</div>
				</div>
				
				<div id="23" onclick="seleccionarNivel('23')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('23')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('23')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">23</label>
					</div>
				</div>
				
				<div id="24" onclick="seleccionarNivel('24')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('24')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('24')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">24</label>
					</div>
				</div>
				
				<div id="25" onclick="seleccionarNivel('25')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('25')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('25')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">25</label>
					</div>
				</div>
				
				<div id="26" onclick="seleccionarNivel('26')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('26')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('26')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">26</label>
					</div>
				</div>
				
				<div id="27" onclick="seleccionarNivel('27')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('27')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('27')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">27</label>
					</div>
				</div>
				
				<div id="28" onclick="seleccionarNivel('28')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('28')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('28')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">28</label>
					</div>
				</div>
				
				<div id="29" onclick="seleccionarNivel('29')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: 2px solid;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('29')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('29')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">29</label>
					</div>
				</div>
				
				<div id="30" onclick="seleccionarNivel('30')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 4px 2px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('30')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('30')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">30</label>
					</div>
				</div>
 			</div>			
 			
 			
 			<div style="width:1140px;height:95px">
	  			<div id="31" onclick="seleccionarNivel('31')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
	  			background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 4px;border-color:rgb(32, 56, 100)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('31')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('31')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">31</label>
					</div>
				</div>
				
				<div id="32" onclick="seleccionarNivel('32')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('32')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('32')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">32</label>
					</div>
				</div>
				
				<div id="33" onclick="seleccionarNivel('33')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('33')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('33')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">33</label>
					</div>
				</div>
				
				<div id="34" onclick="seleccionarNivel('34')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('34')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('34')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">34</label>
					</div>
				</div>
				
				<div id="35" onclick="seleccionarNivel('35')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('35')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('35')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">35</label>
					</div>
				</div>
				
				<div id="36" onclick="seleccionarNivel('36')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('36')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('36')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">36</label>
					</div>
				</div>
				
				<div id="37" onclick="seleccionarNivel('37')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('37')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('37')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">37</label>
					</div>
				</div>
				
				<div id="38" onclick="seleccionarNivel('38')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('38')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('38')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">38</label>
					</div>
				</div>
				
				<div id="39" onclick="seleccionarNivel('39')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 2px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('39')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('39')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">39</label>
					</div>
				</div>
				
				<div id="40" onclick="seleccionarNivel('40')" style="cursor:pointer;width:100px;height:95px;float:left;background-image:url(fondoNivelNormal.png);
				background-repeat:no-repeat;text-align: center;border: solid;border-width: 2px 4px 4px 2px;border-color:rgb(32, 56, 100);
				">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('40')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:18px;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('40')" style="cursor:pointer;position:relative;color:white;font-family:Calibri;font-size:44px;font-weight:bold">40</label>
					</div>
				</div>
 			</div>
 			
 			
 			<div style="float:left;cursor:pointer;top:100px" onclick="irPrincipal()">
	  			<img src="goToLevel.png">
 			</div>
 		</div>
  </body>
</html>