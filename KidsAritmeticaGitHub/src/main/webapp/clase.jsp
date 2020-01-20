<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,
                 java.net.*,
                 java.util.*" %>
<%
Locale locale = request.getLocale();
ResourceBundle RB = ResourceBundle.getBundle("Messages", locale);
String crearCuenta=RB.getString("crearCuenta");
String usuario=RB.getString("usuario");
String password=RB.getString("password");
String rpassword=RB.getString("rpassword");
String terminosServicio=RB.getString("terminosServicio");
String enviarInfo=RB.getString("enviarInfo");

String unAvailableUserNameError=RB.getString("unAvailableUserNameError");
String assignedUserNameError=RB.getString("assignedUserNameError");
String usernameCortoError=RB.getString("usernameCortoError");
String passordsInvalidas=RB.getString("passordsInvalidas");
String usernameObligatorio=RB.getString("usernameObligatorio");
String loginIncorrecto=RB.getString("loginIncorrecto");
String verificarRecaptcha=RB.getString("verificarRecaptcha");
String crearCuentaBoton=RB.getString("crearCuentaBoton");
String cancelarBoton=RB.getString("cancelarBoton");
String crearClase=RB.getString("crearClase");
String mismoUsuPass=RB.getString("mismoUsuPass");
String alumno=RB.getString("alumno");
%>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>PlayAddition | Login</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">

<script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/jquery/jquery-ui.min.js"></script>
<script src="./js/current-device.min.js"></script>
<script src="./js/screenfull.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
<!-- Add Firebase products that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-database.js"></script>
<script type="text/javascript">

var igualUsuarioPassword = false;
var unAvailableUserNameError="<%= unAvailableUserNameError %>"
var usernameCortoError="<%= usernameCortoError %>"
var passordsInvalidas="<%= passordsInvalidas %>"
var usernameObligatorio="<%= usernameObligatorio %>"
var loginIncorrecto="<%= loginIncorrecto %>"
var verificarRecaptcha="<%= verificarRecaptcha %>"
var assignedUserNameError ="<%=assignedUserNameError%>"
var unAvailableUserNames = [];
var assignedUserNames = [];

$( function() {
	     window.addEventListener("orientationchange", resizePageHandler);
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
	    	if (user!=null){
	    		alert(user);
	    	}
	    });
	   
});
 
function handleSignUp() {
    var user = document.getElementById('username1').value;
    var password = document.getElementById('password1').value;
    firebase.auth().createUserWithEmailAndPassword(user+"@playaddition.com", password)
   	.catch(function(error) {
   		document.getElementById("loginAjax1").style.visibility="visible";
   		document.getElementById("createAccountLabel").onclick=function(){crearCuenta()}
	    var errorCode = error.code;
	    var errorMessage = error.message;
	    alert(errorCode+" "+errorMessage);
	    console.log(error);
   	});
}

	//Username
	function checkUserName(i){
		if (document.getElementById("username"+i).value.length<1){
			displayerrorUsername(usernameObligatorio,i);
		}
		if (document.getElementById("username"+i).value.length<6){
			displayerrorUsername(usernameCortoError,i);
		}
	}
	function displayerrorUsername(error,i){
		$("#username"+i+"-glyphicon").remove();
		$("#username"+i+"-error").remove();
		$("<span id='username"+i+"-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#username"+i+".form-control"));
		$("<em id='username"+i+"-error' class='error help-block'>"+error+".</em>").insertAfter($("#username"+i+"-glyphicon"));
		$("input#username"+i+".form-control").parents(".col-md-3").addClass("has-error").removeClass("has-success");
	}
	
	function displayOkeyUserName(i){
		$("input#username"+i+".form-control").parents(".col-md-3").addClass("has-success").removeClass("has-error");
		$("#username"+i+"-glyphicon").remove();
		$("#username"+i+"-error").remove();
		$("<span id='username"+i+"-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#username"+i+".form-control"));
	}
	
	//Password
	function checkPassword(i){
		if (document.getElementById("password"+i).value.length<1){
			displayerrorPassword(usernameObligatorio,i);
			return false;
		}
		if (document.getElementById("password"+i).value.length<6){
			displayerrorPassword(usernameCortoError,i);
			return false;
		}
		else {
			displayOkeyPassword(i);
			return true;
		}
	}
	function displayerrorPassword(error,i){
		$("#password"+i+"-glyphicon").remove();
		$("#password"+i+"-error").remove();
		$("<span id='password"+i+"-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#password"+i+".form-control"));
		$("<em id='password"+i+"-error' class='error help-block'>"+error+".</em>").insertAfter($("#password"+i+"-glyphicon"));
		$("input#password"+i+".form-control").parents(".col-md-3").addClass("has-error").removeClass("has-success");
	}
	
	function displayNormalPassword(i){
		$("input#password"+i+".form-control").parents(".col-md-3").removeClass("has-error").removeClass("has-success");
		$("#password"+i+"-glyphicon").remove();
		$("#password"+i+"-error").remove();
	}
	
	function displayOkeyPassword(i){
		$("input#password"+i+".form-control").parents(".col-md-3").addClass("has-success").removeClass("has-error");
		$("#password"+i+"-glyphicon").remove();
		$("#password"+i+"-error").remove();
		$("<span id='password"+i+"-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#password"+i+".form-control"));
	}
	
	function crearCuenta(){
		var vformularioCorrecto = validarDatos();
		if(vformularioCorrecto && vRecaptcha){
			document.getElementById("loginAjax1").style.visibility="visible";
			document.getElementById("createAccountLabel").onclick=function(){;}
			handleSignUp();
		}
		if(vformularioCorrecto && !vRecaptcha)
			alert (verificarRecaptcha)
	}
	
	function resizePageHandler(){
		  resizePage();
	}
	
	function usarMismaUsuarioPassword (checkbox){
		if(checkbox.checked) {
			igualUsuarioPassword=true;
			for(i=1;i<=30;i++){
				displayNormalPassword(i);
				document.getElementById("password"+i).value = "";
				document.getElementById("password"+i).disabled = true;
			}
		} else {
			igualUsuarioPassword=false;
			for(i=1;i<=30;i++) {
				document.getElementById("password"+i).disabled = false;
				if(document.getElementById("username"+i).value!=null && document.getElementById("username"+i).value!="")
					checkPassword(i);
			}
		}
	}
	  
  function resizePage(){
	  
	 if(device.type=='mobile'){
		 document.getElementById('createAccountLabel').style.width="30vw";
		 document.getElementById('createAccountLabel').style.height="6vw";
		 document.getElementById('createAccountLabel').style.fontSize="3.75vw";
		 document.getElementById('createAccountLabel').style.left="14vw"
	     document.getElementById('createAccountLabel').style.backgroundSize="30vw 6vw";
		 
		 document.getElementById('cancelAccountLabel').style.width="20vw";
		 document.getElementById('cancelAccountLabel').style.height="6vw";
		 document.getElementById('cancelAccountLabel').style.fontSize="3.75vw";
		 document.getElementById('cancelAccountLabel').style.right="14vw"
	     document.getElementById('cancelAccountLabel').style.backgroundSize="20vw 6vw";
		 
		 document.getElementById('capabotonescreacion').style.marginTop="4vw"
		 
		 document.getElementById("loginLabel").style.width="20vw";
		 document.getElementById("loginLabel").style.height="6vw";
		 document.getElementById('loginLabel').style.backgroundSize="20vw 6vw";
		 document.getElementById("loginLabel").style.fontSize="3.75vw";
		 
		 document.getElementById('loginlogo').style.width="27vw";
		 document.getElementById('loginlogo').style.height="9vw";
	     document.getElementById('loginlogo').style.backgroundSize="27vw 9vw";
	     screenfull.request();
	 }
	 else if(device.type=='tablet'){
		 document.getElementById('cancelAccountLabel').style.right="7.5vw"
			 document.getElementById('createAccountLabel').style.left="7.5vw"
	 }
  }
  
  function crearClase(){
	  document.getElementById("credit").disabled = true;
	  document.getElementById('createClass').onclick=function(){;}
	  document.getElementById("loginAjax1").style.visibility="visible";
	  document.getElementById("loginAjax2").style.visibility="visible";
	  for(i=1;i<=30;i++) {
			document.getElementById("username"+i).disabled = true;
			document.getElementById("password"+i).disabled = true;
	  }
  }
	
</script>
<!-- 
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer>
</script>
<script type="text/javascript">
      var onloadCallback = function() {
    	  grecaptcha.render('html_element', {
          'sitekey' : '6LdtBsMUAAAAALnCsHUaDL6jAdyyi5YVwRvXCXrP',
          'callback' : verifyCallback,
          'expired-callback':expiredCallback,
          'error-callback':expiredCallback
        });
      };
</script>
 -->
</head>
<body onload="initFormulario()">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<div class="panel panel-default" align="center">
					<div class="panel-heading">
						<div id="loginlogo" style="position:relative;width:12.5vw;height:5vw;background-size:12.5vw 5vw;background-image:url(newaccount.png);background-repeat:no-repeat"></div>
						<div id="loginAjax2" style="position:relative;visibility:hidden;width:2vw;height:2vw;background-size:2vw 2vw;background-image:url(loading.gif);background-repeat:no-repeat"></div>
					</div>
					<div class="panel-body">
						<form id="signupForm1" class="form-horizontal" action="" method="post">
							<div class="d-block my-3">
						          <div class="custom-control custom-radio">
						            <input id="credit" type="checkbox" class="custom-control-input" onclick="usarMismaUsuarioPassword(this)">
						            <label class="custom-control-label" for="credit"><%=mismoUsuPass %></label>
						          </div>
					        </div>
							
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label><%=alumno %> 1:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username1" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password1" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          <!--  
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="repassword1" placeholder="repeat password" required="" style="width:85%">
						          </div>
						          -->
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 2:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username2" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password2" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 3:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username3" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password3" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 4:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username4" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password4" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						         
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 5:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username5" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password5" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						         
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 6:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username6" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password6" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 7:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username7" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password7" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 8:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username8" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password8" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						         
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 9:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username9" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password9" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 10:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username10" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password10" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 11:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username11" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password11" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 12:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username12" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password12" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 13:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username13" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password13" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 14:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username14" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password14" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 15:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username15" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password15" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 16:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username16" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password16" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 17:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username17" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password17" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						         
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 18:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username18" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password18" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 19:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username19" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password19" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 20:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username20" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password20" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 21:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username21" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password21" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 22:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username22" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password22" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 23:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username23" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password23" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 24:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username24" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password24" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						         
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 25:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username25" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password25" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 26:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username26" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password26" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 27:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username27" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password27" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 28:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username28" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password28" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 29:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username29" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password29" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 30:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username30" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password30" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						          
       						</div>
       						<div  class="form-group" style="cursor:default">
								<div class="col-sm-9 col-sm-offset-2" style="cursor:default;padding-left: 0px"> 
									<div id="createClass" style="font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:12vw;height:2.5vw;background-size:12vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="crearClase()" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label style="cursor:pointer;margin-top:0.3vw"><%= crearClase %></label></div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-9 col-sm-offset-2" style="padding-left: 0px">
									<div id="loginAjax1" style="visibility:hidden;width:2vw;height:2vw;background-size:2vw 2vw;background-image:url(loading.gif);background-repeat:no-repeat"></div>
								</div>
							</div>
						</form>
						<!--  div id="html_element" style="position:relative;top:5vw"></div-->
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
</body>
<script type="text/javascript">
function initFormulario() {

		$('#password1').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(1);
		        }
		    }
		});
	
		$('#username1').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(1);
		        }
		    }
		});	
		$('#username1').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var fAsg = assignedUserNames.length;
		    		var user = document.getElementById("username1").value;
		    		var encontrado = false;
		    		if(fAsg>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==assignedUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(assignedUserNameError,1);
			    			return
			    		}
			    	}
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,1);
			    			return
			    		}
			    	} 
	    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
	    		      .then(function(firebaseUser) {
	    		    }).catch(function(error) {
	    				var errorCode = error.code;
	    			  	if (errorCode == 'auth/wrong-password') {
	    			  		unAvailableUserNames.push(user)
	    			  		displayerrorUsername(unAvailableUserNameError,1)
	    			  	} else if (errorCode=='auth/user-not-found'){
	    			  		assignedUserNames.push(user);
	    			  		displayOkeyUserName(1);
	    			  	}
	    			  	console.log(error);
	    			});
		    },
		    minLength: 6
		});
		
		$('#password2').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(2);
		        }
		    }
		});
	
		$('#username2').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(2);
		        }
		    }
		});	
		$('#username2').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var fAsg = assignedUserNames.length;
		    		var user = document.getElementById("username2").value;
		    		var encontrado = false;
		    		if(fAsg>0){
			    		for (j = 0; j < fAsg; j++) {
			  				if(user==assignedUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(assignedUserNameError,2);
			    			return
			    		}
			    	}
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,2);
			    			return
			    		}
			    	} 
	    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
	    		      .then(function(firebaseUser) {
	    		    }).catch(function(error) {
	    				var errorCode = error.code;
	    			  	if (errorCode == 'auth/wrong-password') {
	    			  		unAvailableUserNames.push(user)
	    			  		displayerrorUsername(unAvailableUserNameError,2)
	    			  	} else if (errorCode=='auth/user-not-found'){
	    			  		assignedUserNames.push(user);
	    			  		displayOkeyUserName(2);
	    			  	}
	    			  	console.log(error);
	    			});
		    },
		    minLength: 6
		});
		
		$('#password3').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(3);
		        }
		    }
		});
	
		$('#username3').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(3);
		        }
		    }
		});	
		$('#username3').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var fAsg = assignedUserNames.length;
		    		var user = document.getElementById("username3").value;
		    		var encontrado = false;
		    		if(fAsg>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==assignedUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(assignedUserNameError,3);
			    			return
			    		}
			    	}
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,3);
			    			return
			    		}
			    	} 
	    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
	    		      .then(function(firebaseUser) {
	    		    }).catch(function(error) {
	    				var errorCode = error.code;
	    			  	if (errorCode == 'auth/wrong-password') {
	    			  		unAvailableUserNames.push(user)
	    			  		displayerrorUsername(unAvailableUserNameError,3)
	    			  	} else if (errorCode=='auth/user-not-found'){
	    			  		assignedUserNames.push(user);
	    			  		displayOkeyUserName(3);
	    			  	}
	    			  	console.log(error);
	    			});
		    },
		    minLength: 6
		});
		
		
		$('#password4').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(4);
		        }
		    }
		});
	
		$('#username4').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(4);
		        }
		    }
		});	
		$('#username4').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username4").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,4);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,4)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(4);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user)
		    			  		displayerrorUsername(unAvailableUserNameError,4)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(4);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		   		 
		    },
		    minLength: 6
		});
		
		$('#password5').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(5);
		        }
		    }
		});
	
		$('#username5').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(5);
		        }
		    }
		});	
		$('#username5').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username5").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,5);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,5)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(5);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user)
		    			  		displayerrorUsername(unAvailableUserNameError,5)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(5);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		$('#password6').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(6);
		        }
		    }
		});
	
		$('#username6').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(6);
		        }
		    }
		});	
		$('#username6').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username6").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,6);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,6)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(6);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user)
		    			  		displayerrorUsername(unAvailableUserNameError,6)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(6);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		$('#password7').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(7);
		        }
		    }
		});
	
		$('#username7').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(7);
		        }
		    }
		});	
		$('#username7').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username7").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,7);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,7)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(7);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user)
		    			  		displayerrorUsername(unAvailableUserNameError,7)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(7);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password8').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(8);
		        }
		    }
		});
	
		$('#username8').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(8);
		        }
		    }
		});	
		$('#username8').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username8").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,8);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,8)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(8);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,8)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(8);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		$('#password9').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(9);
		        }
		    }
		});
	
		$('#username9').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(9);
		        }
		    }
		});	
		$('#username9').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username9").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,9);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,9)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(9);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,9)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(9);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		$('#password10').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(10);
		        }
		    }
		});
	
		$('#username10').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(10);
		        }
		    }
		});	
		$('#username10').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username10").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,10);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,10)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(10);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,10)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(10);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password11').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(11);
		        }
		    }
		});
	
		$('#username11').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(11);
		        }
		    }
		});	
		$('#username11').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username11").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,11);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,11)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(11);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,11)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(11);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password12').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(12);
		        }
		    }
		});
	
		$('#username12').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(12);
		        }
		    }
		});	
		$('#username12').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username12").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,12);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,12)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(12);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,12)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(12);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password13').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(13);
		        }
		    }
		});
	
		$('#username13').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(13);
		        }
		    }
		});	
		$('#username13').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username13").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,13);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,13)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(13);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,13)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(13);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password14').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(14);
		        }
		    }
		});
	
		$('#username14').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(14);
		        }
		    }
		});	
		$('#username14').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username14").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,14);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,14)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(14);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,14)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(14);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password15').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(15);
		        }
		    }
		});
	
		$('#username15').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(15);
		        }
		    }
		});	
		$('#username15').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username15").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,15);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,15)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(15);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,15)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(15);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password16').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(16);
		        }
		    }
		});
	
		$('#username16').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(16);
		        }
		    }
		});	
		$('#username16').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username16").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,16);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,16)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(16);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,16)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(16);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password17').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(17);
		        }
		    }
		});
	
		$('#username17').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(17);
		        }
		    }
		});	
		$('#username17').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username17").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,17);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,17)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(17);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,17)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(17);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		
		$('#password18').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(18);
		        }
		    }
		});
	
		$('#username18').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(18);
		        }
		    }
		});	
		$('#username18').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username18").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,18);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,18)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(18);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,18)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(18);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password19').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(19);
		        }
		    }
		});
	
		$('#username19').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(19);
		        }
		    }
		});	
		$('#username19').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username19").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,19);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,19)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(19);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,19)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(19);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password20').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(20);
		        }
		    }
		});
	
		$('#username20').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(20);
		        }
		    }
		});	
		$('#username20').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username20").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,20);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,20)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(20);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,20)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(20);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password21').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(21);
		        }
		    }
		});
	
		$('#username21').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(21);
		        }
		    }
		});	
		$('#username21').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username21").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,21);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,21)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(21);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,21)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(21);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password22').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(22);
		        }
		    }
		});
	
		$('#username22').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(22);
		        }
		    }
		});	
		$('#username22').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username22").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,22);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,22)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(22);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,22)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(22);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password23').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(23);
		        }
		    }
		});
	
		$('#username23').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(23);
		        }
		    }
		});	
		$('#username23').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username23").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,23);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,23)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(23);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,23)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(23);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		$('#password24').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(24);
		        }
		    }
		});
	
		$('#username24').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(24);
		        }
		    }
		});	
		$('#username24').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username24").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,24);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,24)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(24);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,24)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(24);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		
		$('#password25').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(25);
		        }
		    }
		});
	
		$('#username25').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(25);
		        }
		    }
		});	
		$('#username25').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username25").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,25);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,25)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(25);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,25)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(25);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password26').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(26);
		        }
		    }
		});
	
		$('#username26').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(26);
		        }
		    }
		});	
		$('#username26').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username26").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,26);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,26)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(26);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,26)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(26);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password27').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(27);
		        }
		    }
		});
	
		$('#username27').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(27);
		        }
		    }
		});	
		$('#username27').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username27").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,27);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,27)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(27);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,27)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(27);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password28').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(28);
		        }
		    }
		});
	
		$('#username28').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(28);
		        }
		    }
		});	
		$('#username28').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username28").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,28);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,28)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(28);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,28)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(28);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		$('#password29').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(29);
		        }
		    }
		});
	
		$('#username29').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(29);
		        }
		    }
		});	
		$('#username29').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username29").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,29);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,29)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(29);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,29)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(29);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
		
		
		
		$('#password30').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkPassword(30);
		        }
		    }
		});
	
		$('#username30').on({
		    "keyup": function(e) {
		        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
		        	checkUserName(30);
		        }
		    }
		});	
		$('#username30').autocomplete({
		    source: function (request, response) {
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username30").value;
		    		var encontrado = false;
					if(fLen>0){
			    		for (j = 0; j < fLen; j++) {
			  				if(user==unAvailableUserNames[j]){
			  					encontrado=true;
			  					break;
			  				}
						}
			    		if(encontrado) {
			    			displayerrorUsername(unAvailableUserNameError,30);
			    			return
			    		} else {
			    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
			    		      .then(function(firebaseUser) {
			    		    }).catch(function(error) {
			    				var errorCode = error.code;
			    			  	if (errorCode == 'auth/wrong-password') {
			    			  		unAvailableUserNames.push(user);
			    			  		displayerrorUsername(unAvailableUserNameError,30)
			    			  	} else if (errorCode=='auth/user-not-found'){
			    			  		displayOkeyUserName(30);
			    			  	}
			    			  	console.log(error);
			    			});
			    		}
			    	} else {
		    		    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
		    		      .then(function(firebaseUser) {
		    		    }).catch(function(error) {
		    				var errorCode = error.code;
		    			  	if (errorCode == 'auth/wrong-password') {
		    			  		unAvailableUserNames.push(user);
		    			  		displayerrorUsername(unAvailableUserNameError,30)
		    			  	} else if (errorCode=='auth/user-not-found'){
		    			  		displayOkeyUserName(30);
		    			  	}
		    			  	console.log(error);
		    			});
		    		}
		    },
		    minLength: 6
		});
}
/*$('#repassword1').on({
    "keyup": function(e) {
        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
        	checkRePassword();
        }
    }
});*/

	
</script>
</html>