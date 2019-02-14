<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <title>PlayAddition</title>
  <style type="text/css">
  	#preload-01 { background: url(http://test.playaddition.com/playBottonSelected.png) no-repeat -9999px -9999px; }
	#preload-02 { background: url(http://test.playaddition.com/playBotonSS.png) no-repeat -9999px -9999px; }
	
	
  	@font-face{
	 	font-family:'BerlinDvwi';
 		src: url('BerlinDemi.ttf') format('truetype')
	}
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="./js/current-device.min.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-3');
</script>

-->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-1');
</script>


<script>
(function(w,d,s,g,js,fs){
  g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(f){this.q.push(f);}};
  js=d.createElement(s);fs=d.getElementsByTagName(s)[0];
  js.src='https://apis.google.com/js/platform.js';
  fs.parentNode.insertBefore(js,fs);js.onload=function(){g.load('analytics');};
}(window,document,'script'));
</script>





  <script>
  var token;
  var dominio = "test.playaddition.com";
  //var dominio = "playaddition.com";
  $( function() {
		
  } );
  
  function irPrincipal(obj){
	  	 obj.style.backgroundImage="url(playBotonSS.png)";
	  	 setTimeout(function(){location.href = "seleccionNivel.jsp"},500);
  }
  
  function irPlaySubtraction(){
	  location.href = "seleccionNivelSubtraction.jsp"
  }
  
  function irTwitter(){
	  window.open("https://twitter.com/PlayAddition")
  }
  
  function irFaceBook(){
	  window.open("https://www.facebook.com/PlayAddition-244230309834319");
  }
  
  function irInstagram(){
	  window.open("https://www.instagram.com/playaddition");
  }
  
  function resizePage(){
		 if(device.type=='tablet' || device.type=='mobile'){
		     if (window.orientation == 90 || window.orientation == -90) { //landscape Mode
		      	  	
		     }else { //0 ->Portrait Mode
		    	  	document.getElementById('twitter').style.top="4.5vw";
					document.getElementById('facebook').style.top="4.5vw";
					document.getElementById('instagram').style.top="4.5vw";
		   	 }
		 }
	  }

  </script>
  
<script>

gapi.analytics.ready(function() {
	$.ajax({
		  url: "/getToken",
		  method: "post",
		  data:{accion:'obtenerToken'},
		  success : function(responseText) {
			  token = responseText.token
			  gapi.analytics.auth.authorize({
				    'serverAuth': {
				      'access_token': ''+token
				    }
				  });
				  var report = new gapi.analytics.report.Data({
					  query: {
						 // 'ids': 'ga:189296074', // <-- playAddition.
						  'ids': 'ga:185994770',   // <-- testPlayAddition.
					      'start-date': '2018-11-01',
					      'end-date': 'yesterday',
					      'metrics': 'ga:users'
					  }
					});
				  	report.on('success', function(response) {
					  handleReportingResults(response)
					});
					report.execute();
		  } 
	});	
	
  
	function handleReportingResults(response){
		document.getElementById('contador').innerHTML ="Visitors: "+response.rows[0][0];
	}
	
});
</script>
  
</head>

  <body onload="resizePage();">
  	<div class="hidden">
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
			if (document.images) {
				var img1 = new Image();
				var img2 = new Image();
				var img3 = new Image();
				var img4 = new Image();
				var img5 = new Image();
				var img6 = new Image();
				img1.src = "https://"+dominio+"/playBottonSelected.png";
				img2.src = "https://"+dominio+"/playBotonSS.png";
				img3.src = "https://"+dominio+"/checkBoton.png";
				img4.src = "https://"+dominio+"/checkBotonClick.png";
				img5.src = "https://"+dominio+"/startOverBoton.png";
				img6.src = "https://"+dominio+"/levelUpBoton.png";
			}

		//--><!]]>
		</script>
	</div>
  		
  
		<div id="izquierda" style="position:absolute;width:25vw">
			
			<div style="position:absolute;top:1vw;width:25vw">
			
				<div style="position:absolute">	
					<img src="followUs.png" style="cursor:pointer;width:24vw">
				</div>
				
				<div id="twitter" style="position:absolute;top:3vw;left:2vw">
					<img src="twitter.png" onmouseout="javascript:this.style.border='0px'" onmouseover="javascript:this.style.border='0.2vw solid rgb(46, 117, 182)'" 
					    style="cursor:pointer;width:5vw" onclick="irTwitter()">
				</div>
				
				<div id="facebook" style="position:absolute;top:3vw;left:8.5vw">
					<img src="facebook.png" onmouseout="javascript:this.style.border='0px'" onmouseover="javascript:this.style.border='0.2vw solid rgb(46, 117, 182)'"
						style="cursor:pointer;width:5.25vw"  onclick="javascritp:irFaceBook()">
				</div>
				
				<div id="instagram" style="position:absolute;top:3vw;left:15.25vw">
					<img src="instagram.png" onmouseout="javascript:this.style.border='0px'" onmouseover="javascript:this.style.border='0.2vw solid rgb(46, 117, 182)'"
					style="cursor:pointer;width:5vw"  onclick="javascritp:irInstagram()">
				</div>
				
			</div>
	 		
 			
	 	</div>

		<div id="derecha" style="position:absolute;left:25vw;width:65vw">	
				<img src="logoPlayAddition.png" style="width:57vw">
 		</div>
 		
 		  
 		<div style="position:absolute;right:5vw">
 				<div id="contador" style="position:absolute;top:1vw;width:9vw;height:6vw;right:7vw;font-family:BerlinDvwi;font-size:1.8vw;color:rgb(46, 117, 182)">
 					<img src="loading.gif" style="width:2.5vw">
 				</div>
 				<!--  
 					<img src="loginBoton.png" style="position:absolute;width:9vw;height:6vw;right:6vw">
 					<img src="espaniol.png" style="position:absolute;width:9vw;height:6vw;right:15vw">
 				-->
				<div id= "playBoton" style="background-image:url(playBoton.png);background-repeat:no-repeat;background-size:16vw 11vw;float:right;position:absolute;right:1vw;top:34vw;cursor:pointer;width:16vw;height:11vw" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'" onclick="javascript:irPrincipal(this)" ></div>
		</div>
		<div id="contactSupport" style="position:absolute;top:40vw;left:2vw">
				<img src="contactSupport.png" style="cursor:pointer;width:20vw"><a onclick="irPlaySubtraction()" style="cursor:pointer;font-family:BerlinDvwi;font-size:1.8vw;color:rgb(46, 117, 182)">Ir a PlaySubtraction</a>
		</div>
		
 		
  </body>
</html>