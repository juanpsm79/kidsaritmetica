<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDvwi';
 		src: url('BerlinDemi.ttf') format('truetype')
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="./js/jquery.flip.min.js"></script>
  <script>
  $( function() {
	  $("#1").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#2").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#3").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#4").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#5").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#6").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#7").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#8").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#9").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#10").flip({axis: 'y',trigger: 'click', reverse: true});
	  
	  $("#11").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#12").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#13").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#14").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#15").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#16").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#17").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#18").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#19").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#20").flip({axis: 'y',trigger: 'click', reverse: true});
	  
	  $("#21").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#22").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#23").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#24").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#25").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#26").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#27").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#28").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#29").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#30").flip({axis: 'y',trigger: 'click', reverse: true});
	  
	  $("#31").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#32").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#33").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#34").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#35").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#36").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#37").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#38").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#39").flip({axis: 'y',trigger: 'click', reverse: true});
	  $("#40").flip({axis: 'y',trigger: 'click', reverse: true});
  } );
  var nivelAnterior =null;
  
  function irPresentacion(){
		 location.href = "presentacion.jsp"
  }
  
  function irPrincipal(){
	  $.ajax({
		  url: "/hello",
		  method: "post",
		  data:{nivel: ''+nivelAnterior},
		 // dataType: "json",
		  success : function(responseText) {
				location.href = "descripcionNivel.jsp";
		  }
		});
		 
}
  
  function seleccionarNivel(idNivel){
	  if(nivelAnterior!=null){
		  document.getElementById(''+nivelAnterior).style.borderColor="rgb(32, 56, 100)";
		 // $("#"+nivelAnterior).flip({axis: 'y',trigger: 'hover', reverse: true});
		  $("#"+nivelAnterior).flip(false);
	  }
	  document.getElementById(''+idNivel).style.borderColor="red";
	  //$("#"+idNivel).flip(true);
	  //$("#"+idNivel).off(".flip");
	  nivelAnterior = idNivel;
  }
  
  var docLevelsWindow;
	
  function openDoc(){
	  docLevelsWindow = window.open("./selectAllLevels.jsp")
  }
  
  function callback(nivel){
	  nivelAnterior = nivel;
	  docLevelsWindow.close();
	  irPrincipal();
  }
  
  
  </script>
</head>

  <body onload="seleccionarNivel('1')">
  
		<div style="position:absolute;width:85vw;min-height:35vh">
			<div>
				<img src="selectYourLevel.png" style="width:74vw">
			</div>
			<div style="width:74vw">
					<a onclick="openDoc()"><label style="text-decoration: underline;font-family:BerlinDvwi;font-size:4.75vw;color:rgb(46, 117, 182);cursor:pointer">See all levels</label></a>
			 </div>
		</div>

		<div style="position:absolute;width:85vw;top:26vw">
			
			<div style="position:absolute;top:0vw;width:85vw;height:7vw">
	  			<div id="1" onclick="seleccionarNivel('1')" style="position:absolute;width:7vw;height:7vw;cursor:pointer;cursor:pointer;float:left;text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
	  				<div class="front" style="position:absolute;position:absolute;width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
						<label onclick="seleccionarNivel('1')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
						<label onclick="seleccionarNivel('1')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">1</label>
					</div>
					<div class="back" style="position:absolute;background:url(1c.png);background-repeat:no-repeat;background-size:7vw 7vw;background-size:7vw 7vw">
  					</div>
				</div>
				
				<div id="2" onclick="seleccionarNivel('2')"  style="width:7vw;height:7vw;cursor:pointer;cursor:pointer;float:left;
				text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('2')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('2')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">2</label>
					</div>
				</div>	
				<div class="back" style="background:url(2c.png);background-repeat:no-repeat;background-size:7vw 7vw;background-size:7vw 7vw">
    					
  					</div>
				</div>
				
				<div id="3" onclick="seleccionarNivel('3')" style="width:7vw;height:7vw;cursor:pointer;cursor:pointer;float:left;
				text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('3')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('3')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">3</label>
					</div>
					</div>	
					<div class="back" style="background:url(3c.png);background-repeat:no-repeat;background-size:7vw 7vw;background-size:7vw 7vw">	
  					</div>
				</div>

				
				<div id="4" onclick="seleccionarNivel('4')" style="width:7vw;height:7vw;cursor:pointer;float:left;
				text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('4')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('4')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">4</label>
					</div>
					</div>	
				<div class="back" style="background:url(4c.png);background-repeat:no-repeat;background-size:7vw 7vw;background-size:7vw 7vw">
  				</div>
				</div>

				
				<div id="5" onclick="seleccionarNivel('5')" style="cursor:pointer;width:7vw;height:7vw;float:left;
				text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('5')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('5')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">5</label>
					</div>
					</div>	
				<div class="back" style="background:url(5c.png);background-repeat:no-repeat;background-size:7vw 7vw;background-size:7vw 7vw">
  				</div>
				</div>
				
				
				<div id="6" onclick="seleccionarNivel('6')"  style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('6')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('6')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">6</label>
					</div>
					</div>	
				<div class="back" style="background:url(6c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>
				</div>
				
				
				<div id="7" onclick="seleccionarNivel('7')"  style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('7')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('7')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">7</label>
					</div>
					</div>	
				<div class="back" style="background:url(7c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="8" onclick="seleccionarNivel('8')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('8')" style="color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('8')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">8</label>
					</div>
					</div>	
				<div class="back" style="background:url(8c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="9" onclick="seleccionarNivel('9')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.4vw 0.2vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('9')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('9')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">9</label>
					</div>
					</div>	
				<div class="back" style="background:url(9c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	

				</div>
				
				<div id="10" onclick="seleccionarNivel('10')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.4vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('10')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('10')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">10</label>
					</div>
					</div>	
				<div class="back" style="background:url(10c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

 			</div>
 			
 			
 			
 			
 			
 			<div style="position:absolute;top:7vw;width:85vw;height:7vw">
	  			<div id="11" onclick="seleccionarNivel('11')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
	  			<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('11')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('11')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">11</label>
					</div>
					</div>	
				<div class="back" style="background:url(11c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="12" onclick="seleccionarNivel('12')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('12')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('12')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">12</label>
					</div>
					</div>	
				<div class="back" style="background:url(12c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="13" onclick="seleccionarNivel('13')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('13')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('13')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">13</label>
					</div>
					</div>	
				<div class="back" style="background:url(13c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="14" onclick="seleccionarNivel('14')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('14')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('14')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">14</label>
					</div>
					</div>	
				<div class="back" style="background:url(14c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="15" onclick="seleccionarNivel('15')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('15')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('15')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">15</label>
					</div>
					</div>	
				<div class="back" style="background:url(15c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="16" onclick="seleccionarNivel('16')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('16')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('16')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">16</label>
					</div>
					</div>	
				<div class="back" style="background:url(16c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="17" onclick="seleccionarNivel('17')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('17')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('17')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">17</label>
					</div>
					</div>	
				<div class="back" style="background:url(17c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="18" onclick="seleccionarNivel('18')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('18')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('18')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">18</label>
					</div>
					</div>	
				<div class="back" style="background:url(18c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="19" onclick="seleccionarNivel('19')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('19')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('19')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">19</label>
					</div>
					</div>	
				<div class="back" style="background:url(19c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	

				</div>
				
				<div id="20" onclick="seleccionarNivel('20')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('20')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('20')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">20</label>
					</div>
					</div>	
				<div class="back" style="background:url(20c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
			</div> 			

 			
 			
  			<div style="position:absolute;top:14vw;width:85vw;height:7vw">
	  			<div id="21" onclick="seleccionarNivel('21')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.2vw 0.4vw;border-color:rgb(32, 56, 100)">
	  			<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('21')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('21')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">21</label>
					</div>
					</div>	
				<div class="back" style="background:url(21c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="22" onclick="seleccionarNivel('22')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('22')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('22')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">22</label>
					</div>
					</div>	
				<div class="back" style="background:url(22c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	

				</div>
				
				<div id="23" onclick="seleccionarNivel('23')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('23')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('23')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">23</label>
					</div>
					</div>	
				<div class="back" style="background:url(23c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="24" onclick="seleccionarNivel('24')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('24')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('24')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">24</label>
					</div>
					</div>	
				<div class="back" style="background:url(24c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="25" onclick="seleccionarNivel('25')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('25')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('25')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">25</label>
					</div>
					</div>	
				<div class="back" style="background:url(25c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="26" onclick="seleccionarNivel('26')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('26')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('26')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">26</label>
					</div>
					</div>	
				<div class="back" style="background:url(26c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="27" onclick="seleccionarNivel('27')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('27')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('27')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">27</label>
					</div>
					</div>	
				<div class="back" style="background:url(27c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="28" onclick="seleccionarNivel('28')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('28')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('28')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">28</label>
					</div>
					</div>	
				<div class="back" style="background:url(28c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="29" onclick="seleccionarNivel('29')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: 0.2vw solid;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('29')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('29')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">29</label>
					</div>
					</div>	
				<div class="back" style="background:url(29c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="30" onclick="seleccionarNivel('30')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.4vw 0.2vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('30')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('30')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">30</label>
					</div>
					</div>	
				<div class="back" style="background:url(30c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
 			</div>			
 			
 			
 			<div style="position:absolute;top:21vw;width:85vw;height:7vw">
	  			<div id="31" onclick="seleccionarNivel('31')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.4vw;border-color:rgb(32, 56, 100)">
	  			<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('31')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('31')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">31</label>
					</div>
					</div>	
				<div class="back" style="background:url(31c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="32" onclick="seleccionarNivel('32')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('32')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('32')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">32</label>
					</div>
					</div>	
				<div class="back" style="background:url(32c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="33" onclick="seleccionarNivel('33')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('33')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('33')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">33</label>
					</div>
					</div>	
				<div class="back" style="background:url(33c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="34" onclick="seleccionarNivel('34')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('34')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('34')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">34</label>
					</div>
					</div>	
				<div class="back" style="background:url(34c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>

				
				<div id="35" onclick="seleccionarNivel('35')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('35')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('35')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">35</label>
					</div>
					</div>	
					<div class="back" style="background:url(35c.png);background-repeat:no-repeat;background-size:7vw 7vw">
  					</div>	
				</div>
				
				<div id="36" onclick="seleccionarNivel('36')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('36')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('36')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">36</label>
					</div>
				</div>
				<div class="back" style="background:url(36c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>
  				</div>
				
				<div id="37" onclick="seleccionarNivel('37')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('37')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('37')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">37</label>
					</div>
					</div>	
				<div class="back" style="background:url(37c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="38" onclick="seleccionarNivel('38')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('38')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('38')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">38</label>
					</div>
					</div>	
				<div class="back" style="background:url(38c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="39" onclick="seleccionarNivel('39')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.2vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('39')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('39')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">39</label>
					</div>
					</div>	
				<div class="back" style="background:url(39c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
				
				<div id="40" onclick="seleccionarNivel('40')" style="cursor:pointer;width:7vw;height:7vw;float:left;text-align: center;border: solid;border-width: 0.2vw 0.4vw 0.4vw 0.2vw;border-color:rgb(32, 56, 100);
				">
				<div class="front" style="width:7vw;height:7vw;background-image:url(fondoNivelNormal.png)">
					<div style="text-align:center">
							<label onclick="seleccionarNivel('40')" style="cursor:pointer;color:white;font-family:Calibri;font-size:1.125vw;font-weight:bold">LEVEL</label>
					</div>
					
					<div style="text-align:center">
							<label onclick="seleccionarNivel('40')" style="cursor:pointer;color:white;font-family:Calibri;font-size:2.75vw;font-weight:bold">40</label>
					</div>
					</div>	
					<div class="back" style="background:url(40c.png);background-repeat:no-repeat;background-size:7vw 7vw">
    					
  					</div>	
				</div>
 			</div>
 		</div>
 		
 		<div style="position:absolute;width:14vw;top:1vw;left:85vw">
 			<img onclick="irPresentacion()" src="aspaCerrarSelectYourLevel.png" style="position:absolute;width:7vw;height:7vw;cursor:pointer;right:10vw">
 			<img onclick="irPrincipal()" src="playSelectAllLevel.png"  style="position:absolute;width:12vw;height:9vw;right:10vw;cursor:pointer;top:44.5vw">
 		</div>
  </body>
</html>