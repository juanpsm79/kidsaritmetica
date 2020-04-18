<%@page import="playaddition.model.Suma"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
if(nivel==null){
	response.sendRedirect(request.getContextPath() + "/presentacion.jsp");
	return;
}
String nombreImagen = "GoToLevel"+nivel+".png";
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>PlayAddition</title>
  <style type="text/css">
  	#preload-01 { background: url(http://test.playaddition.com/playBottonSelected.png) no-repeat -9999px -9999px; }
	#preload-02 { background: url(http://test.playaddition.com/playBotonSS.png) no-repeat -9999px -9999px; }
	#preload-03 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevel.png) no-repeat -9999px -9999px; }
	#preload-04 { background: url(http://test.playaddition.com/aspaCerrarSelectYourLevelSelect.png) no-repeat -9999px -9999px; }
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/jquery/jquery-ui.min.js"></script>
  <script src="./js/screenfull.js"></script>
  <script src="./js/current-device.min.js"></script>
  <script>

  var dominio = "playaddition.com";
  var nivel = <%=nivel%>;
  
  $( function() {
	     window.addEventListener("orientationchange", resizePage);
	   
});
  function irNivel(obj){
	  obj.style.backgroundImage="url(playBotonSS.png)";
	  setTimeout(function(){
		  if(nivel<=11)
				location.href = "plantilla111.jsp";
		  else if(nivel==12 || nivel==13)
				location.href = "plantilla1.jsp";
		  else if(nivel<=22)
				location.href = "plantilla2.jsp";
		  else
				location.href = "plantilla3.jsp";
		  },500);
  }
  
  function irPrincipal(){
		 location.href = "seleccionNivel.jsp"
  }
  
  function resizePage(){
	 /*if(device.type=='tablet' || device.type=='mobile'){
		 document.getElementById("pantallaCompleta").style.visibility="visible";
	 }
	 if(device.iphone()){
		 document.getElementById("pantallaCompleta").ontouchstart=function(){fullscreen(document.getElementById("pantallaCompleta"))};
	 }*/
  }
  
  function fullscreen(obj){
		if(obj.style.backgroundImage=="url(\"maximize-512.png\")"){
			obj.style.backgroundImage="url(minimize-512.png)"
			if(device.iphone())
				document.body.webkitRequestFullscreen();
			else
				screenfull.request();
		} else {
			obj.style.backgroundImage="url(maximize-512.png)"
			if(device.iphone())
				document.body.webkitExitFullscreen();
			else
				screenfull.exit();
		}
	}
  
  function abrirVideo(nivel){
	  var url;
	  if(nivel==40)url="https://www.youtube.com/watch?v=cxsGjXvZvDM&list=UU5OuhbCUu5kWILEqYdZV-JA&index=1";
	  else if(nivel==39)url="https://www.youtube.com/watch?v=1rUU2v0HRII&list=UU5OuhbCUu5kWILEqYdZV-JA&index=2";
	  else if(nivel==38)url="https://www.youtube.com/watch?v=1zWdVQNDYMg&list=UU5OuhbCUu5kWILEqYdZV-JA&index=3";
	  else if(nivel==37)url="https://www.youtube.com/watch?v=YOkPnBMGygs&list=UU5OuhbCUu5kWILEqYdZV-JA&index=4";
	  else if(nivel==36)url="https://www.youtube.com/watch?v=i8M5mevF_BE&list=UU5OuhbCUu5kWILEqYdZV-JA&index=5";		  
	  else if(nivel==35)url="https://www.youtube.com/watch?v=_5vO_NMf3X4&list=UU5OuhbCUu5kWILEqYdZV-JA&index=6";		
	  else if(nivel==34)url="https://www.youtube.com/watch?v=rofEzsfb_NI&list=UU5OuhbCUu5kWILEqYdZV-JA&index=7";		
	  else if(nivel==33)url="https://www.youtube.com/watch?v=1s9l7Gvpfp4&list=UU5OuhbCUu5kWILEqYdZV-JA&index=8";		
	  else if(nivel==32)url="https://www.youtube.com/watch?v=G9utzhmP-hk&list=UU5OuhbCUu5kWILEqYdZV-JA&index=9";		
	  else if(nivel==31)url="https://www.youtube.com/watch?v=j7zRkq5gpqU&list=UU5OuhbCUu5kWILEqYdZV-JA&index=10";		
	  else if(nivel==30)url="https://www.youtube.com/watch?v=gkiAYLOUIBc&list=UU5OuhbCUu5kWILEqYdZV-JA&index=11";		
	  else if(nivel==29)url="https://www.youtube.com/watch?v=1wj8S1qt_ac&list=UU5OuhbCUu5kWILEqYdZV-JA&index=12";		
	  else if(nivel==28)url="https://www.youtube.com/watch?v=HuDmVlFSpyw&list=UU5OuhbCUu5kWILEqYdZV-JA&index=13";		
	  else if(nivel==27)url="https://www.youtube.com/watch?v=9S_323wfMgA&list=UU5OuhbCUu5kWILEqYdZV-JA&index=14";		
	  else if(nivel==26)url="https://www.youtube.com/watch?v=BTWpQvE8ur4&list=UU5OuhbCUu5kWILEqYdZV-JA&index=15";		
	  else if(nivel==25)url="https://www.youtube.com/watch?v=t3poulvmuN8&list=UU5OuhbCUu5kWILEqYdZV-JA&index=16";		
	  else if(nivel==24)url="https://www.youtube.com/watch?v=d3lHIEypTz4&list=UU5OuhbCUu5kWILEqYdZV-JA&index=17";		
	  else if(nivel==23)url="https://www.youtube.com/watch?v=4IIUOKLea3Y&list=UU5OuhbCUu5kWILEqYdZV-JA&index=18";		
	  else if(nivel==22)url="https://www.youtube.com/watch?v=gtvkc_7oIGQ&list=UU5OuhbCUu5kWILEqYdZV-JA&index=19";		
	  else if(nivel==21)url="https://www.youtube.com/watch?v=RH5h_MyCjJA&list=UU5OuhbCUu5kWILEqYdZV-JA&index=20";	
	  else if(nivel==20)url="https://www.youtube.com/watch?v=MqMtWJvvv-o&list=UU5OuhbCUu5kWILEqYdZV-JA&index=21";		
	  else if(nivel==19)url="https://www.youtube.com/watch?v=4C6V_ekWxcg&list=UU5OuhbCUu5kWILEqYdZV-JA&index=22";		
	  else if(nivel==18)url="https://www.youtube.com/watch?v=46bEf_PL3ho&list=UU5OuhbCUu5kWILEqYdZV-JA&index=23";		
	  else if(nivel==17)url="https://www.youtube.com/watch?v=vudVe6UsJcE&list=UU5OuhbCUu5kWILEqYdZV-JA&index=24";		
	  else if(nivel==16)url="https://www.youtube.com/watch?v=sthM9oQ4huM&list=UU5OuhbCUu5kWILEqYdZV-JA&index=25";		
	  else if(nivel==15)url="https://www.youtube.com/watch?v=SxaBtev-4gg&list=UU5OuhbCUu5kWILEqYdZV-JA&index=27";		
	  else if(nivel==14)url="https://www.youtube.com/watch?v=hAwSqqtYHe0&list=UU5OuhbCUu5kWILEqYdZV-JA&index=26";		
	  else if(nivel==13)url="https://www.youtube.com/watch?v=rIZwBmTCqnU&list=UU5OuhbCUu5kWILEqYdZV-JA&index=28";		
	  else if(nivel==12)url="https://www.youtube.com/watch?v=QQFvk4nmKZs&list=UU5OuhbCUu5kWILEqYdZV-JA&index=29";		
	  else if(nivel==11)url="https://www.youtube.com/watch?v=ojPYruytOjQ&list=UU5OuhbCUu5kWILEqYdZV-JA&index=30";		
	  else if(nivel==10)url="https://www.youtube.com/watch?v=3v0mEmqCNiA&list=UU5OuhbCUu5kWILEqYdZV-JA&index=31";		
	  else if(nivel==9)url="https://www.youtube.com/watch?v=JR6UHMvUtAk&list=UU5OuhbCUu5kWILEqYdZV-JA&index=32";		
	  else if(nivel==8)url="https://www.youtube.com/watch?v=K8hzyM5q9yI&list=UU5OuhbCUu5kWILEqYdZV-JA&index=33";
	  else if(nivel==7)url="https://www.youtube.com/watch?v=MJHiLAMWAUQ&list=UU5OuhbCUu5kWILEqYdZV-JA&index=37";		
	  else if(nivel==6)url="https://www.youtube.com/watch?v=gibzTh5TYMU&list=UU5OuhbCUu5kWILEqYdZV-JA&index=38";		
	  else if(nivel==5)url="https://www.youtube.com/watch?v=UmDzd74D1Jg&list=UU5OuhbCUu5kWILEqYdZV-JA&index=34";		
	  else if(nivel==4)url="https://www.youtube.com/watch?v=wRM3FBVFjIQ&list=UU5OuhbCUu5kWILEqYdZV-JA&index=35";		
	  else if(nivel==3)url="https://www.youtube.com/watch?v=efGLs4IlfBc&list=UU5OuhbCUu5kWILEqYdZV-JA&index=39";		
	  else if(nivel==2)url="https://www.youtube.com/watch?v=fbobqGO3-D8&list=UU5OuhbCUu5kWILEqYdZV-JA&index=36";
	  else if(nivel==1)url="https://www.youtube.com/watch?v=C3gkIl6-i9U&list=UU5OuhbCUu5kWILEqYdZV-JA&index=40";	
	  var params = [
		    'height='+screen.availHeight,
		    'width='+screen.availWidth,
		    'fullscreen=yes',
		    'resizable=yes',
		    'scrollbars=yes'
		    // only works in IE, but here for completeness
		].join(',');	
	  window.open(url, "_blank", params);
	  popup.moveTo(0,0);
	  //popup.resizeTo(screen.availWidth,screen.availHeight);
  }
</script>


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
  

  
</head>

  <body onload="resizePage()">
  <div class="hidden">
	<script type="text/javascript">
		<!--//--><![CDATA[//><!--
			if (document.images) {
				var img1 = new Image();
				var img2 = new Image();
				var img3 = new Image();
				img1.src = "https://"+dominio+"/playBottonSelected.png";
				img2.src = "https://"+dominio+"/playBotonSS.png";
				img3.src = "https://"+dominio+"/aspaCerrarSelectYourLevelSelect.png";
			}

		//--><!]]>
		</script>
	</div>
 		<div style="position:absolute;left:10vw;width:40vw;height:46vw;background-size:40vw 45vw;background-image:url(<%=nombreImagen%>);background-repeat:no-repeat">	
		</div>
		
		
		<div style="position:absolute;width:30vw;left:68vw">
			<div id="botonSalir" onclick="irPrincipal()" onmouseout="this.style.backgroundImage='url(aspaCerrarSelectYourLevel.png)'" onmouseover="this.style.backgroundImage='url(aspaCerrarSelectYourLevelSelect.png)'" 
			     style="top:2vw;width:9vw;height:8vw;position:absolute;left:10vw;background-size:8vw 7vw;
					background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;cursor:pointer">
 			</div>
 			<!--  div id="pantallaCompleta" onclick="fullscreen(this)" style="visibility:hidden;position:absolute;left:26vw;cursor:pointer;width:5vw;height:4vw;background-color:white;background-size:5vw 4vw;background-repeat:no-repeat;background-image:url(maximize-512.png)">	
		    </div-->	
			<div style="top:9.5vw;width:20vw;height:30vw;position:absolute;background-size:18vw 28vw;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 			<div onclick="javascript:abrirVideo(<%=nivel%>)" style="width:8.5vw;height:6.5vw;position:absolute;left:0.5vw;cursor:pointer;background-size:8.5vw 6.5vw;top:38.25vw;
 			background-image:url(HOW_TO_PLAY.png);background-repeat:no-repeat" onmouseout="this.style.backgroundImage='url(HOW_TO_PLAY.png)'" onmouseover="this.style.backgroundImage='url(HOW_TO_PLAY_top.png)'"></div>
 			<div id= "playSelectAllLevel" onclick="javascript:irNivel(this)" style="width:10vw;height:8vw;position:absolute;left:10vw;cursor:pointer;background-size:9vw 7vw;top:38vw;background-image:url(playBoton.png);background-repeat:no-repeat" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'"></div>
 		</div>
 		
  </body>
</html>