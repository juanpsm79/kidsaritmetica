<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
if(nivel==null){
	response.sendRedirect(request.getContextPath() + "/presentacion.jsp");
	return;
}
String nombreImagen = "GoToLevel"+nivel+"S.png";
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
				location.href = "plantilla1resta.jsp";
		  else if(nivel<=26)
				location.href = "plantilla2resta.jsp";
		  else
				location.href = "plantilla3resta.jsp";
		  },500);
  }
  
  function irPrincipal() {
	 location.href = "seleccionNivelSubtraction.jsp"
  }
  
  function resizePage() {
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
	      if(nivel==40) url="https://www.youtube.com/watch?v=-F6PRdHeNcc";
	      else if(nivel==39)url="https://www.youtube.com/watch?v=AoxrjQwFHVA";
	      else if(nivel==38)url="https://www.youtube.com/watch?v=CC4JbVUFZas";
	      else if(nivel==37)url="https://www.youtube.com/watch?v=_QQBkVnyNPs";
	      else if(nivel==36)url="https://www.youtube.com/watch?v=G1sKDiNQudQ";
	      else if(nivel==35)url="https://www.youtube.com/watch?v=r7PE3mxJ_g8";
	      else if(nivel==34)url="https://www.youtube.com/watch?v=LkUy1KcPghg";
	      else if(nivel==33)url="https://www.youtube.com/watch?v=X0LdoJNP42k";
	      else if(nivel==32)url="https://www.youtube.com/watch?v=lUf1ADt6CFg";
	      else if(nivel==31)url="https://www.youtube.com/watch?v=PfHLWN5n8XI";
	      else if(nivel==30)url="https://www.youtube.com/watch?v=mMsO5rM6j5w";
	      else if(nivel==29)url="https://www.youtube.com/watch?v=NuYbTyHu58U";
	      else if(nivel==28)url="https://www.youtube.com/watch?v=Ab1zGEm0Vuo";
	      else if(nivel==27)url="https://www.youtube.com/watch?v=dbGAxIdkMYw";
	      else if(nivel==26)url="https://www.youtube.com/watch?v=k9d5YUpxn78";
	      else if(nivel==25)url="https://www.youtube.com/watch?v=FS2i1sWcp-k";
	      else if(nivel==24)url="https://www.youtube.com/watch?v=0xaHci-BBqs";
	      else if(nivel==23)url="https://www.youtube.com/watch?v=3EXipn-nPQg";
	      else if(nivel==22)url="https://www.youtube.com/watch?v=cVE5qhziHsE";
	      else if(nivel==21)url="https://www.youtube.com/watch?v=O3DGg6dWvOU";
	      else if(nivel==20)url="https://www.youtube.com/watch?v=bFqynShAfwI";
	      else if(nivel==19)url="https://www.youtube.com/watch?v=Ryo-Ewowmmo";
	      else if(nivel==18)url="https://www.youtube.com/watch?v=xGWNml2ObDw";
	      else if(nivel==17)url="https://www.youtube.com/watch?v=FCZJBCp4IU0";
	      else if(nivel==16)url="https://www.youtube.com/watch?v=VfVcgwQ2Dko";
	      else if(nivel==15)url="https://www.youtube.com/watch?v=YChtcCWajow";
	      else if(nivel==14)url="https://www.youtube.com/watch?v=uy_9IFrpIJk";
	      else if(nivel==13)url="https://www.youtube.com/watch?v=TE8gaYLKlhU";
	      else if(nivel==12)url="https://www.youtube.com/watch?v=yo8VgXtHD_M";
	      else if(nivel==11)url="https://www.youtube.com/watch?v=G1K9WaPtY0k";
	      else if(nivel==10)url="https://www.youtube.com/watch?v=-PhsqkySfNU";
	      else if(nivel==9) url="https://www.youtube.com/watch?v=XF_TIq11QO8";
	      else if(nivel==8) url="https://www.youtube.com/watch?v=lKOo2J49PiY";
	      else if(nivel==7) url="https://www.youtube.com/watch?v=65bpfc8aLaA";
	      else if(nivel==6) url="https://www.youtube.com/watch?v=q90Shzq7T-Y";
	      else if(nivel==5) url="https://www.youtube.com/watch?v=FGbWZfTu0Ag";
	      else if(nivel==4) url="https://www.youtube.com/watch?v=n9Tk3U6wOfs";
	      else if(nivel==3) url="https://www.youtube.com/watch?v=nLlHBy1-JDU";
	      else if(nivel==2) url="https://www.youtube.com/watch?v=Yk_WVMNh95A";
	      else if(nivel==1) url="https://www.youtube.com/watch?v=EGY_Dkc6L9w";

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
			<div onclick="irPrincipal()" onmouseout="this.style.backgroundImage='url(aspaCerrarSelectYourLevel.png)'" onmouseover="this.style.backgroundImage='url(aspaCerrarSelectYourLevelSelect.png)'" 
				style="top:2vw;width:9vw;height:8vw;position:absolute;left:10vw;background-size:8vw 7vw;
					background-image:url(aspaCerrarSelectYourLevel.png);background-repeat:no-repeat;cursor:pointer">
 			</div>
 			<!--  div id="pantallaCompleta" onclick="fullscreen(this)" style="visibility:hidden;position:absolute;left:26vw;cursor:pointer;width:5vw;height:4vw;background-color:white;background-size:5vw 4vw;background-repeat:no-repeat;background-image:url(maximize-512.png)">	
		    </div-->	
			<div style="top:9.5vw;width:20vw;height:30vw;position:absolute;background-size:18vw 28vw;background-image:url(instrucciones.png);background-repeat:no-repeat">
 			</div>
 			<div onclick="abrirVideo(<%=nivel%>)" style="width:8.5vw;height:6.5vw;position:absolute;left:0.5vw;cursor:pointer;background-size:8.5vw 6.5vw;top:38.25vw;
 			background-image:url(HOW_TO_PLAY.png);background-repeat:no-repeat" onmouseout="this.style.backgroundImage='url(HOW_TO_PLAY.png)'" onmouseover="this.style.backgroundImage='url(HOW_TO_PLAY_top.png)'"></div>
 			<div id= "playSelectAllLevel" onclick="javascript:irNivel(this)" style="width:10vw;height:8vw;position:absolute;left:10vw;cursor:pointer;background-size:9vw 7vw;top:38vw;background-image:url(playBoton.png);background-repeat:no-repeat" onmouseout="this.style.backgroundImage='url(playBoton.png)'" onmouseover="this.style.backgroundImage='url(playBottonSelected.png)'"></div>
 		</div>
 		
  </body>
</html>