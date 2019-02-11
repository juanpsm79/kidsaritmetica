<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDvwi';
 		src: url('BerlinDemi.ttf') format('truetype')
	}
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
<script src="./js/jquery/jquery-3.3.1.js"></script>



<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-3');
</script>



<!-- Global site tag (gtag.js) - Google Analytics 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-1');
</script>

-->


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
  $( function() {
		
  } );
  
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
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
		    	  	document.getElementById('twitter').style.top="7vw";
					document.getElementById('facebook').style.top="7vw";
					document.getElementById('instagram').style.top="7vw";
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
						  'ids': 'ga:189296074', // <-- playAddition.
						  //'ids': 'ga:185994770',   // <-- testPlayAddition.
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

  <body onload="resizePage()">
		<div id="izquierda" style="position:absolute;width:25vw">
		
			<!--  
		
			<div style="width:25vw">
				<div style="float:left;cursor:pointer">
					<img src="appstoreBoton.png" style="cursor:pointer;width:12vw">
				</div>
				<div style="float:left;cursor:pointer">
					<img src="googlePlayBoton.png" style="cursor:pointer;width:12vw">
				</div>
			</div>
			-->
			
			<div style="position:absolute;top:1vw;width:25vw">
			
				<div style="position:absolute">	
					<img src="followUs.png" style="cursor:pointer;width:24vw">
				</div>
				
				<div id="twitter" style="position:absolute;top:3vw;left:2vw">
					<img src="twitter.png" style="cursor:pointer;width:5vw"  onclick="javascritp:irTwitter()">
				</div>
				
				<div id="facebook" style="position:absolute;top:3vw;left:8.5vw">
					<img src="facebook.png" style="cursor:pointer;width:5.25vw"  onclick="javascritp:irFaceBook()">
				</div>
				
				<div id="instagram" style="position:absolute;top:3vw;left:15.25vw">
					<img src="instagram.png" style="cursor:pointer;width:5vw"  onclick="javascritp:irInstagram()">
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
				<img id= "playBoton" src="playBoton.png" onclick="javascript:irPrincipal()" style="float:right;position:absolute;right:1vw;top:34vw;cursor:pointer;width:16vw;height:11vw">
		</div>
		<div id="contactSupport" style="position:absolute;top:40vw;left:2vw">
				<img src="contactSupport.png" style="cursor:pointer;width:20vw">
		</div>
		
 		
  </body>
</html>