<%@ page import="java.io.*,
                 java.net.*,
                 java.util.*" %>
<%
Locale locale = request.getLocale();
ResourceBundle RB = ResourceBundle.getBundle("Messages", locale);
String visitantes = RB.getString("visitantes");  
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta http-equiv="Cache-control" content="public">
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

<script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/current-device.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
<!-- Add Firebase products that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-database.js"></script>
  
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
var usuario;
  $( function() {
	// Initialize Firebase

  });
  
  function login(){
		location.href='login.jsp';
  }
  
  function logout(){
		firebase.auth().signOut().then(function() {
		}).catch(function(error) {
			alert("Error deslogue")
		});
  }
  
  function irPlayAddition(){
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
  
  function loadImages(){
	  document.getElementById("inicial").innerHTML ="";
	  document.getElementById("contador").style.display="none";
      document.getElementById("loginboton").style.backgroundImage="url(loading.gif)";
      document.getElementById("loginboton").style.width="3vw";
      document.getElementById("loginboton").style.height="3vw"
      document.getElementById("loginboton").style.backgroundSize="3vw 3vw";
	  var firebaseConfig = {
			    apiKey: "AIzaSyDxPBEOIlqaXki7LVRLLVunVrwWmLXiyBQ",
			    authDomain: "fbplayaddition.firebaseapp.com",
			    databaseURL: "https://fbplayaddition.firebaseio.com",
			    projectId: "fbplayaddition",
			    storageBucket: "fbplayaddition.appspot.com",
			    messagingSenderId: "945530212708",
			    appId: "1:945530212708:web:38ba814515a7a3c0376a71",
			    measurementId: "G-LLPNBP9S9B"
	  };
	  firebase.initializeApp(firebaseConfig);
	  firebase.auth().onAuthStateChanged(function(user) {
		if (user!=null) {
		  firebase.database().ref('/users/' + user.uid).once('value').then (
			function(snapshot) {
			  if(snapshot==null || snapshot.val()==null)
					 firebase.database().ref('users/' + user.uid).set({"nivelActualSuma": 1,"nivelActualResta": 1,"puntos": 0});
	          document.getElementById("contador").style.display="none";
	          document.getElementById("loginboton").style.backgroundImage="url(logadoInicialFondo.png)";
	          document.getElementById("loginboton").style.width="3vw";
	          document.getElementById("loginboton").style.height="3vw"
	          document.getElementById("loginboton").style.backgroundSize="3vw 3vw";
	          document.getElementById("inicial").innerHTML = user.email.substring(0, 1).toUpperCase();
	          document.getElementById("logoutDiv").style.display="inline";
	          usuario = user;
			})
		}else {
			document.getElementById("inicial").innerHTML ="";
			document.getElementById("logoutDiv").innerHTML ="";
			document.getElementById("contador").style.display="inline";
	        document.getElementById("loginboton").style.backgroundImage="url(login.png)";
	        document.getElementById("loginboton").style.width="8vw";
	        document.getElementById("loginboton").style.height="4vw"
	        document.getElementById("loginboton").style.backgroundSize="8vw 4vw";
	        document.getElementById("loginboton").onclick=function(){login()}
		}
	});
	  	var dominio = "test.playaddition.com";
	  	//var dominio = "playaddition.com";
	 	var img1 = new Image();
		var img2 = new Image();
		var img3 = new Image();
		var img4 = new Image();
		var img5 = new Image();
		var img6 = new Image();
		var img7 = new Image();
		img1.src = "https://"+dominio+"/playBottonSelected.png";
		img2.src = "https://"+dominio+"/playBotonSS.png";
		img3.src = "https://"+dominio+"/checkBoton.png";
		img4.src = "https://"+dominio+"/checkBotonClick.png";
		img5.src = "https://"+dominio+"/startOverBoton.png";
		img6.src = "https://"+dominio+"/levelUpBoton.png";
		img7.src = "https://"+dominio+"/cerrarAspaSelect.png";
  }
</script>
 
<script>
var token;
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
						  //'ids': 'ga:189296074', // <-- playAddition.
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
});

function handleReportingResults(response){
	document.getElementById('contador').innerHTML ="<%= visitantes %> "+response.rows[0][0];
}
</script>
  
</head>

  <body onload="resizePage();loadImages()">
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

		<div id="derecha" style="position:absolute;left:20vw;width:65vw;top:13vw">	
				<div style="cursor:pointer;background-image:url(playadditionLogo.png);background-repeat:no-repeat;background-size:34vw 24vw;position:absolute;width:34vw;height:24vw"  onclick="javascript:irPlayAddition()"></div>
				<div style="cursor:pointer;background-image:url(playSubtractionlogo.png);background-repeat:no-repeat;background-size:34vw 24vw;position:absolute;left:35vw;width:34vw;height:24vw"  onclick="javascript:irPlaySubtraction()"></div>
 		</div>
 			
		<div id="logoutDiv" style="cursor:pointer;width:6vw;height:2vw;display:none;position:absolute;top:1.35vw;right:7.5vw;font-family:Arial;font-size:1.3vw;color:orange" 
	  	onmouseover="this.style.textDecoration ='underline';this.style.fontWeight='bold'" onmouseout="this.style.textDecoration ='none';this.style.fontWeight='normal'" onclick="logout()">Log&nbsp;Out</div>  
		
 		<div id="loginboton" style="position:absolute;right:5vw;cursor:pointer;width:8vw;height:4vw;background-size:8vw 4vw;background-repeat:no-repeat">
 				<label id="inicial" style="cursor:pointer;position:absolute;right:0.8vw;top:0.15vw;font-family:Arial;font-size:2.3vw;color:white;z-index:5"></label>	
		</div>
			
		<div id="contactSupport" style="position:absolute;top:40vw;left:2vw">
				<img src="contactSupport.png" style="cursor:pointer;width:20vw">
		</div>
 		<div style="position:absolute;float:right;top:41.5vw;right:3vw;cursor:pointer">
 			<div id="contador" style="display:none;position:absolute;top:1vw;width:13vw;right:0.1vw;height:6vw;font-family:BerlinDvwi;font-size:1.8vw;color:rgb(46, 117, 182)">
 					<img src="loading.gif" style="width:2.5vw">
 			</div>
 		</div>
  </body>
</html>