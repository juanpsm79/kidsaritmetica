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
String usernameCortoError=RB.getString("usernameCortoError");
String passordsInvalidas=RB.getString("passordsInvalidas");
String usernameObligatorio=RB.getString("usernameObligatorio");
String loginIncorrecto=RB.getString("loginIncorrecto");
String verificarRecaptcha=RB.getString("verificarRecaptcha");
String crearCuentaBoton=RB.getString("crearCuentaBoton");
String crearClase=RB.getString("crearClase");
String cancelarBoton=RB.getString("cancelarBoton");
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
var comprobandoLogin = false;
var userNameDisponible = false;
var action="crearCuenta";
var vRecaptcha=true
var unAvailableUserNameError="<%= unAvailableUserNameError %>"
var usernameCortoError="<%= usernameCortoError %>"
var passordsInvalidas="<%= passordsInvalidas %>"
var usernameObligatorio="<%= usernameObligatorio %>"
var loginIncorrecto="<%= loginIncorrecto %>"
var verificarRecaptcha="<%= verificarRecaptcha %>"
var unAvailableUserNames = [];
var md
$( function() {
	     window.addEventListener("orientationchange", resizePage);
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
	    		location.href='presentacion.jsp'
	    	}
	    });
});
 
function handleSignUp() {
    var user = document.getElementById('username1').value;
    var password = document.getElementById('password1').value;
    firebase.auth().createUserWithEmailAndPassword(user+"@playaddition.com", password)
   	.catch(function(error) {
   		document.getElementById("loginAjax").style.visibility="visible";
   		document.getElementById("createAccountLabel").onclick=function(){crearCuenta()}
	    var errorCode = error.code;
	    var errorMessage = error.message;
	    alert(errorCode+" "+errorMessage);
	    console.log(error);
   	});
}

	//Username
	function checkUserName(){
		if (document.getElementById("username1").value.length<1){
			displayerrorUsername(usernameObligatorio);
			return false;
		}
		if (document.getElementById("username1").value.length<6){
			displayerrorUsername(usernameCortoError);
			return false;
		}
		else
			return userNameDisponible;
	}
	function displayerrorUsername(error){
		$("#username1-glyphicon").remove();
		$("#username1-error").remove();
		$("<span id='username1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#username1.form-control"));
		$("<em id='username1-error' class='error help-block'>"+error+".</em>").insertAfter($("#username1-glyphicon"));
		$("input#username1.form-control").parents(".col-sm-5").addClass("has-error").removeClass("has-success");
	}
	function displayNormalUsername(){
		$("input#username1.form-control").parents(".col-sm-5").removeClass("has-error").removeClass("has-success");
		$("#username1-glyphicon").remove();
		$("#username1-error").remove();
	}
	function displayOkeyUserName(){
		$("input#username1.form-control").parents(".col-sm-5").addClass("has-success").removeClass("has-error");
		$("#username1-glyphicon").remove();
		$("#username1-error").remove();
		$("<span id='username1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#username1.form-control"));
	}
	
	//Password
	function checkPassword(){
		if (document.getElementById("password1").value.length<1){
			displayerrorPassword(usernameObligatorio);
			return false;
		}
		if (document.getElementById("password1").value.length<6){
			displayerrorPassword(usernameCortoError);
			return false;
		}
		else {
			if(document.getElementById("confirm_password1").value==document.getElementById("password1").value){
				displayOkeyRePassword();
				displayOkeyPassword();
				return true;
			}
			else {
				if(document.getElementById("confirm_password1").value.length>0)
					displayerrorPassword(passordsInvalidas)
				else
					displayOkeyPassword();	
				return false;
			}
		}
	}
	function displayerrorPassword(error){
		$("#password1-glyphicon").remove();
		$("#password1-error").remove();
		$("<span id='password1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#password1.form-control"));
		$("<em id='password1-error' class='error help-block'>"+error+".</em>").insertAfter($("#password1-glyphicon"));
		$("input#password1.form-control").parents(".col-sm-5").addClass("has-error").removeClass("has-success");
	}
	function displayNormalPassword(){
		$("input#password1.form-control").parents(".col-sm-5").removeClass("has-error").removeClass("has-success");
		$("#password1-glyphicon").remove();
		$("#password1-error").remove();
	}
	function displayOkeyPassword(){
		$("input#password1.form-control").parents(".col-sm-5").addClass("has-success").removeClass("has-error");
		$("#password1-glyphicon").remove();
		$("#password1-error").remove();
		$("<span id='password1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#password1.form-control"));
	}
	
	
	//rePassword
	function checkRePassword(){
		if (document.getElementById("confirm_password1").value.length<1){
			displayerrorRePassword(usernameObligatorio);
			return false;
		}
		if (document.getElementById("confirm_password1").value.length<6){
			displayerrorRePassword(usernameCortoError);
			return false;
		}
		else {
			if(document.getElementById("confirm_password1").value==document.getElementById("password1").value){
				displayOkeyRePassword();
				displayOkeyPassword();
				return true;
			}
			else {
				if(document.getElementById("password1").value.length>0)
					displayerrorRePassword(passordsInvalidas)
				else
					displayOkeyPassword();
				return false;
			}
		}
	}
	function displayerrorRePassword(error){
		$("#confirm_password1-glyphicon").remove();
		$("#confirm_password1-error").remove();
		$("<span id='confirm_password1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#confirm_password1.form-control"));
		$("<em id='confirm_password1-error' class='error help-block'>"+error+".</em>").insertAfter($("#confirm_password1-glyphicon"));
		$("input#confirm_password1.form-control").parents(".col-sm-5").addClass("has-error").removeClass("has-success");
	}
	function displayNormalRePassword(){
		$("input#confirm_password1.form-control").parents(".col-sm-5").removeClass("has-error").removeClass("has-success");
		$("#confirm_password1-glyphicon").remove();
		$("#confirm_password1-error").remove();
	}
	function displayOkeyRePassword(){
		$("input#confirm_password1.form-control").parents(".col-sm-5").addClass("has-success").removeClass("has-error");
		$("#confirm_password1-glyphicon").remove();
		$("#confirm_password1-error").remove();
		$("<span id='confirm_password1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#confirm_password1.form-control"));
	}
	
	function validarDatos(){
		var bUsername = checkUserName();
		var bPassword = checkPassword();
		var bRePassword = checkRePassword();
		return bUsername && bPassword && bRePassword;
	}
	
	function crearCuenta(){
		var vformularioCorrecto = validarDatos();
		if(vformularioCorrecto){
			document.getElementById("loginAjax").style.visibility="visible";
			document.getElementById("createAccountLabel").onclick=function(){;}
			handleSignUp();
		}
		if(vformularioCorrecto && !vRecaptcha)
			alert (verificarRecaptcha)
	}
	
	function verifyCallback() {
		vRecaptcha = true;
    }
	
	function expiredCallback() {
		vRecaptcha = false;
    }
	
	function resizePageHandler(){
		  resizePage();
	}
	  
  function resizePage(){
	  
	 if(device.type=='mobile'){
		 document.getElementById('loginlogo').style.width="30vw";
		 document.getElementById('loginlogo').style.height="12vw";
	     document.getElementById('loginlogo').style.backgroundSize="30vw 12vw";
	     
	     document.getElementById('crearClaseLink').style.left="35vw";
	     
		 document.getElementById('cancelAccountLabel').style.width="20vw";
		 document.getElementById('cancelAccountLabel').style.height="6vw";
		 document.getElementById('cancelAccountLabel').style.fontSize="3.75vw";
		 document.getElementById('cancelAccountLabel').style.left="51vw"
	     document.getElementById('cancelAccountLabel').style.backgroundSize="20vw 6vw";
		 
		 document.getElementById('createAccountLabel').style.width="30vw";
		 document.getElementById('createAccountLabel').style.height="6vw";
		 document.getElementById('createAccountLabel').style.fontSize="3.75vw";
		 document.getElementById('createAccountLabel').style.left="16vw"
	     document.getElementById('createAccountLabel').style.backgroundSize="30vw 6vw";
		 document.getElementById('linkCreacionClase').style.fontSize="4vw";
		 document.getElementById('terms1').className="col-sm-5 col-sm-offset-4";
		 document.getElementById('loginAjax').style.width="6vw";
		 document.getElementById('loginAjax').style.height="6vw";
		 document.getElementById('loginAjax').style.backgroundSize="6vw 6vw";
		 
		 if(device.landscape()) {
	         document.getElementById('loginlogo').style.width="28vw";
			 document.getElementById('loginlogo').style.height="10vw";
		     document.getElementById('loginlogo').style.backgroundSize="28vw 10vw";
		     
		     document.getElementById('crearClaseLink').style.left="42vw";
		     
			 document.getElementById('cancelAccountLabel').style.width="18vw";
			 document.getElementById('cancelAccountLabel').style.height="5vw";
			 document.getElementById('cancelAccountLabel').style.fontSize="3.5vw";
			 document.getElementById('cancelAccountLabel').style.left="53vw"
		     document.getElementById('cancelAccountLabel').style.backgroundSize="18vw 5vw";
			 
			 document.getElementById('createAccountLabel').style.width="28vw";
			 document.getElementById('createAccountLabel').style.height="5vw";
			 document.getElementById('createAccountLabel').style.fontSize="3.5vw";
			 document.getElementById('createAccountLabel').style.left="18vw"
		     document.getElementById('createAccountLabel').style.backgroundSize="28vw 5vw";
         }
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
<body onload="resizePage()">
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-sm-offset-2">
				<div class="panel panel-default" align="center">
					<div class="panel-heading">
						<div id="loginlogo" style="position:relative;left:2vw;width:12.5vw;height:5vw;background-size:12.5vw 5vw;background-image:url(newaccount.png);background-repeat:no-repeat"></div>
					</div>
					<div class="panel-body">
						<form id="signupForm1" class="form-horizontal" action="" method="post">
							<div class="form-group">
								<label class="col-sm-4 control-label" for="username1" style="padding-left: 0px"><%= usuario %>:</label>
								<div class="col-sm-5" style="padding-left: 0px">
									<input type="text" class="form-control" id="username1" 
										name="username1" placeholder="<%= usuario %>" style="width:90%">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label" for="password1" style="padding-left: 0px"><%= password %>:</label>
								<div class="col-sm-5" style="padding-left: 0px">
									<input type="password" class="form-control" id="password1"
										name="password1" placeholder="<%= password %>" style="width:90%">
								</div>
							</div>
							<div id="repassword" class="form-group">
								<label class="col-sm-4 control-label" for="confirm_password1" style="padding-left: 0px"><%= rpassword %>:</label>
								<div class="col-sm-5" style="padding-left: 0px">
									<input type="password" class="form-control"
										id="confirm_password1" name="confirm_password1" style="width:90%"
										placeholder="<%= password %>">
								</div>
							</div>
							<div id="terms" class="form-group">
								<div id="terms1" class="col-sm-5 col-sm-offset-4">
									<div class="checkbox">
										<label> <input type="checkbox" id="agree1"
											name="agree1" value="agree"><%= terminosServicio %>
										</label>
									</div>
								</div>
							</div>
							
							<div id="loginBoton" class="form-group" style="cursor:default">
								<div class="col-sm-9 col-sm-offset-2" style="cursor:default;padding-left: 0px"> 
									<div id="createAccountLabel" style="position:absolute;left:12vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:9vw;height:2.5vw;background-size:9vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat" id="signup1"
										onclick="crearCuenta()" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label style="cursor:pointer;margin-top:0.3vw"><%= crearCuentaBoton %></label></div>
									<div id="cancelAccountLabel" style="position:absolute;left:22vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:7vw;height:2.5vw;background-size:7vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="location.href='presentacion.jsp'" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label style="cursor:pointer;margin-top:0.3vw"><%= cancelarBoton %></label></div>		
								</div>
							</div>
							
							<div id="cocoa" class="form-group">
								<div class="col-sm-9 col-sm-offset-2" style="margin-top:2vw;cursor:default;padding-left: 0px"> 	
									  <div id="loginAjax" style="visibility:hidden;width:2vw;height:2vw;background-size:2vw 2vw;background-image:url(loading.gif);background-repeat:no-repeat"></div>	
								</div>
							</div>
							 
							<div id="crearCuenta" class="form-group">
								<div class="col-sm-9 col-sm-offset-2" style="cursor:default;padding-left: 0px">
									<div id="crearClaseLink" style="left:17.5vw">
										<a id="linkCreacionClase" style=" text-decoration: underline;font-size:1.5vw;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;color:blue;cursor:pointer" onclick="location.href='clase.jsp'"><%= crearClase %></a>
									</div>
								</div>
							</div>
						</form>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
</body>
<script type="text/javascript">
$('#confirm_password1').on({
    "keyup": function(e) {
        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
        	checkRePassword();
        }
    }
});
$('#password1').on({
    "keyup": function(e) {
        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
        	checkPassword();
        }
    }
});
$('#username1').on({
    "keyup": function(e) {
        if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
        	checkUserName();
        }
    }
});	
$( "#username1" ).autocomplete({
    source: function (request, response) {
    	if(action=="crearCuenta"){
    		userNameDisponible = false;
    		var fLen = unAvailableUserNames.length;
    		var user = document.getElementById("username1").value;
    		var encontrado = false;
			if(fLen>0){
	    		for (i = 0; i < fLen; i++) {
	  				if(user==unAvailableUserNames[i]){
	  					encontrado=true;
	  					break;
	  				}
				}
	    		if(encontrado) {
	    			displayerrorUsername(unAvailableUserNameError);
	    			return
	    		} else {
	    			firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
	    		      .then(function(firebaseUser) {
	    		    }).catch(function(error) {
	    				var errorCode = error.code;
	    			  	if (errorCode == 'auth/wrong-password') {
	    			  		unAvailableUserNames.push(user);
	    			  		displayerrorUsername(unAvailableUserNameError)
	    			  	} else if (errorCode=='auth/user-not-found'){
	    			  		displayOkeyUserName();
	    			  		userNameDisponible = true;
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
    			  		displayerrorUsername(unAvailableUserNameError)
    			  	} else if (errorCode=='auth/user-not-found'){
    			  		displayOkeyUserName();
    			  		userNameDisponible = true;
    			  	}
    			  	console.log(error);
    			});
    		}
   		 }
    },
    minLength: 6
});
</script>
</html>