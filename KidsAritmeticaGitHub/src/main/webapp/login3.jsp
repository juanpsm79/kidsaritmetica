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
%>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252">
<title>PlayAddition | Login</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!--  script type="text/javascript" src="./js/jquery-1.11.1.js"></script-->
<script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="./js/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="./js/jquery.validate.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-database.js"></script>
<script type="text/javascript">
var displayValidations
var comprobandoLogin = false;
var userNameDisponible = false;
var action="login";
var unAvailableUserNameError="Nombre usuario no disponible";
var usernameCortoError="Rellenar con mínimo de 5 caracteres"
var usernameObligatorio ="Obligatorio"
var unAvailableUserNames = [];
$( function() {
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
	    firebase.auth().onAuthStateChanged(function(user) {if (user!=null)location.href='presentacion.jsp'});
});
  
function login(defaultpassword){
	var user = document.getElementById("username1").value;
	var password = document.getElementById("password1").value;
	if(defaultpassword!=null)
		password = defaultpassword
	firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", password)
	   .then(function(firebaseUser) {
	   })
	  .catch(function(error) {
			var errorCode = error.code;
			var errorMessage = error.message;
		  	if (errorCode == 'auth/wrong-password') {
		  		if(defaultpassword==null)
		    		alert('Wrong password.');
		  		else {
		  			userNameDisponible = false
		  			comprobandoLogin = false;
		  		}
		  	} else if (errorCode=='auth/user-not-found'){
		  		if(defaultpassword==null)
		    		alert(errorMessage);
		  		else {
		  			userNameDisponible = true
		  			comprobandoLogin = false;
		  		}
		  	}
		  	console.log(error);
		});
}
 
function handleSignUp() {
    var user = document.getElementById('username1').value;
    var password = document.getElementById('password1').value;
    var repassword = document.getElementById('confirm_password1').value;
    if (user.length < 4) {
      alert('User name too short.');
      return;
    }
    if(repassword!=password){
    	alert("Password provided don\'t match");
        return;
    }
    firebase.auth().createUserWithEmailAndPassword(user+"@playaddition.com", password)
   	.catch(function(error) {
			      var errorCode = error.code;
			      var errorMessage = error.message;
			      
			      if (errorCode == 'auth/weak-password') {
			        alert('The password is too weak.');
			      } else {
			        alert(errorMessage);
			      }
			      console.log(error);
   	});
    
    /*firebase.auth().currentUser.sendEmailVerification().then(function() {
        // Email Verification sent!
        // [START_EXCLUDE]
        alert('Email Verification Sent!');
        // [END_EXCLUDE]
      });*/
  }
	
	function displaycreateAccount(){
		document.getElementById("repassword").style.display="block";
		//document.getElementById("repassword").style.position="relative";
		
		//document.getElementById("terms").style.top="2vw";
		document.getElementById("terms").style.display="inline";
		//document.getElementById("terms").style.top="4vw";
		//document.getElementById("terms").style.left="2vw";
		document.getElementById("terms1").style.width="44.66666667%";
		//document.getElementById("terms").style.height="5vw";
		//document.getElementById("terms").style.position="relative";
		document.getElementById("info").style.display="block";
		document.getElementById("crearBotonones").style.display="block";
		document.getElementById("crearCuenta").style.display="none";
		document.getElementById("loginBoton").style.display="none";
		//document.getElementById("displaycreateAccountAction").style.display="inline";
		//document.getElementById("displaycreateAccountAction").style.top="6vw";
		////document.getElementById("displaycreateAccountAction").style.width="29vw";
		//document.getElementById("displaycreateAccountAction").style.height="4vw";
		//document.getElementById("displaycreateAccountAction").style.position="relative";
		document.getElementById("loginlogo").style.backgroundImage="url(newaccount.png)";
		document.getElementById("loginlogo").style.backgroundSize="12.5vw 5vw";
		document.getElementById("loginlogo").style.width="12.5vw";
		document.getElementById("loginlogo").style.height="5vw";
		action="crearCuenta";
		
		//$("<span class='glyphicon glyphicon-ok form-control-feedback' style='right:15px'></span>").insertAfter($("input#username1.form-control"));
		
		//$("input#username1.form-control").next("span").addClass("glyphicon-ok").removeClass("glyphicon-remove");
		//$("<span class='glyphicon form-control-feedback' style='background: url(lock.png) 4px no-repeat;right:15px'></span>").insertAfter($("input#username1.form-control"));
		//$("<span class='glyphicon' style='background: url(lock.png) 4px no-repeat'></span>").insertBefore($("input#username1.form-control"));
		
		//element= input#confirm_password1.form-control
		//$("em#username1-error.error.help-block").insertAfter($("input#username1.form-control"));
		//$("input#username1.form-control").parents(".col-sm-5").addClass("has-feedback");

	}
	//Username
	function checkUserName(){
		if (document.getElementById("username1").value.length<1){
			displayerrorUsername(usernameObligatorio);
			return;
		}
		if (document.getElementById("username1").value.length<5)
			displayerrorUsername(usernameCortoError);
	}
	function displayerrorUsername(error){
		$("#username1-glyphicon").remove();
		$("#username1-error").remove();
		$("<span id='username1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback' style='right:15px'></span>").insertAfter($("input#username1.form-control"));
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
		$("<span id='username1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback' style='right:15px'></span>").insertAfter($("input#username1.form-control"));
	}
	
	//Password
	function checkPassword(){
		if (document.getElementById("password1").value.length<1){
			displayerrorPassword(usernameObligatorio);
			return;
		}
		if (document.getElementById("password1").value.length<5)
			displayerrorPassword(usernameCortoError);
		else
			displayOkeyPassword();	
	}
	function displayerrorPassword(error){
		$("#password1-glyphicon").remove();
		$("#password1-error").remove();
		$("<span id='password1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback' style='right:15px'></span>").insertAfter($("input#password1.form-control"));
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
		$("<span id='password1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback' style='right:15px'></span>").insertAfter($("input#password1.form-control"));
	}
	
	
	//rePassword
	function checkRePassword(){
		if (document.getElementById("confirm_password1").value.length<1){
			displayerrorRePassword(usernameObligatorio);
			return;
		}
		if (document.getElementById("confirm_password1").value.length<5)
			displayerrorRePassword(usernameCortoError);
		else {
			if(document.getElementById("confirm_password1").value==document.getElementById("password1").value)
				displayOkeyRePassword();
			else
				displayerrorRePassword("Passwords don't match")
		}
	}
	function displayerrorRePassword(error){
		$("#confirm_password1-glyphicon").remove();
		$("#confirm_password1-error").remove();
		$("<span id='confirm_password1-glyphicon' class='glyphicon glyphicon-remove form-control-feedback' style='right:15px'></span>").insertAfter($("input#confirm_password1.form-control"));
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
		$("<span id='confirm_password1-glyphicon' class='glyphicon glyphicon-ok form-control-feedback' style='right:15px'></span>").insertAfter($("input#confirm_password1.form-control"));
	}
	
	function validarDatos(){
		checkUserName();
		checkPassword();
		checkRePassword();
	}
	
	function displayLogin(){
		displayValidations = false;
		document.getElementById("repassword").style.display="none";
		document.getElementById("terms").style.display="none";
		document.getElementById("info").style.display="none";
		document.getElementById("crearBotonones").style.display="none";
		
		document.getElementById("crearCuenta").style.display="block";
		document.getElementById("loginBoton").style.display="block";
		
		document.getElementById("loginlogo").style.backgroundImage="url(login.png)";
		document.getElementById("loginlogo").style.backgroundSize="10vw 5vw";
		document.getElementById("loginlogo").style.width="10vw";
		document.getElementById("loginlogo").style.height="5vw";
		action="login";
	}
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<div class="panel panel-default" align="center">
					<div class="panel-heading">
						<div id="loginlogo" style="position:relative;width:10vw;height:5vw;background-size:8vw 4vw;background-image:url(login.png);background-repeat:no-repeat"></div>
					</div>
					<div class="panel-body">
						<form id="signupForm1" class="form-horizontal" novalidate="novalidate" action="" method="post">
							<!--div class="form-group">
								<label class="col-sm-4 control-label" for="firstname1">First
									name</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="firstname1"
										name="firstname1" placeholder="First name">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label" for="lastname1">Last
									name</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="lastname1"
										name="lastname1" placeholder="Last name">
								</div>
							</div-->
							<div class="form-group">
								<label class="col-sm-4 control-label" for="username1"><%= usuario %>:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="username1" 
										name="username1" placeholder="Username" onfocusout="checkUserName()" onkeypress="checkUserName()">
								</div>
							</div>
							<!--  div class="form-group">
								<label class="col-sm-4 control-label" for="email1">Email</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="email1"
										name="email1" placeholder="Email">
								</div>
							</div-->
							<div class="form-group">
								<label class="col-sm-4 control-label" for="password1"><%= password %>:</label>
								<div class="col-sm-5">
									<input type="password" class="form-control" id="password1"
										name="password1" placeholder=" Password" onfocusout="checkPassword()" onkeypress="checkPassword()">
								</div>
							</div>
							<div id="repassword" class="form-group" style="display:none;background: url(lock.png) 4px no-repeat;">
								<label class="col-sm-4 control-label" for="confirm_password1"><%= rpassword %>:</label>
								<div class="col-sm-5">
									<input type="password" class="form-control"
										id="confirm_password1" name="confirm_password1"
										placeholder="Confirm password" onfocusout="checkRePassword()" onkeypress="checkRePassword()">
								</div>
							</div>
							<div id="terms" class="form-group"  style="display:none">
								<div id="terms1" class="col-sm-5 col-sm-offset-4">
									<div class="checkbox">
										<label> <input type="checkbox" id="agree1"
											name="agree1" value="agree"><%= terminosServicio %>
										</label>
									</div>
								</div>
							</div>
							<div id="info" class="form-group" style="display:none">
								<div class="col-sm-5 col-sm-offset-4" style="margin-left:30%">
									<div class="checkbox">
										<label> <input type="checkbox" id="agree2"
											name="agree2" value="agree2"><%= enviarInfo %>
										</label>
									</div>
								</div>
							</div>
							<div id="loginBoton" class="form-group">
								<div class="col-sm-9 col-sm-offset-2">
									<button type="submit" class="btn btn-primary" name="signup1"
										value="Sign up">Login</button>
								</div>
							</div>
							<div id="crearCuenta" class="form-group">
								<div class="col-sm-5 col-sm-offset-4">
									<a style="color:blue;cursor:pointer" onclick="javascript:displaycreateAccount()"><u><%= crearCuenta %></u></a>
								</div>
							</div>
							
							<div id="crearBotonones" class="form-group" style="display:none">
								<div class="col-sm-9 col-sm-offset-2">
									<button class="btn btn-primary" name="crear"
										value="crear" onclick="javascript:validarDatos()">Crear cuenta</button>
									<button class="btn btn-primary" name="cancel"
										value="cancel" onclick="javascript:displayNormal()">Cancelar</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$.validator.setDefaults({
			onfocusin: function( element ) {
			},
			onfocusout: function( element ) {
			},
			onkeyup: function( element, event ) {
			},
			onclick: function( element ) {
			},
			highlight: function( element, errorClass, validClass ) {
			},
			unhighlight: function( element, errorClass, validClass ) {
			},
			submitHandler : function() {
				validarDatos();
			}
		});
		$( "#username1" ).autocomplete({
		    source: function (request, response) {
		    	if(action=="crearCuenta"){
		    		var fLen = unAvailableUserNames.length;
		    		var user = document.getElementById("username1").value;
		    		var encontrado = false;
		    		alert(unAvailableUserNames);
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
		    			  	}
		    			  	console.log(error);
		    			});
		    	}
		    }
		    },
		    minLength: 5
		});

		$(document)
				.ready(
						function() {
							$("#signupForm1").validate();
						});
	</script>


</body>
</html>