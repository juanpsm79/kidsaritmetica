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
}
function displayLogin(){
	displayNormalPassword();
	displayNormalRePassword();
	displayNormalUsername();
	document.getElementById("username1").value="";
	document.getElementById("password1").value="";
	document.getElementById("confirm_password1").value="";
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
	
function displaycreateAccount(){
	displayNormalPassword();
	displayNormalRePassword();
	displayNormalUsername();
	document.getElementById("username1").value="";
	document.getElementById("password1").value="";
	document.getElementById("confirm_password1").value="";
	document.getElementById("repassword").style.display="block";
	document.getElementById("terms").style.display="inline";
	document.getElementById("terms1").style.width="44.66666667%";
	document.getElementById("info").style.display="block";
	document.getElementById("crearBotonones").style.display="block";
	document.getElementById("crearCuenta").style.display="none";
	document.getElementById("loginBoton").style.display="none";
	document.getElementById("loginlogo").style.backgroundImage="url(newaccount.png)";
	document.getElementById("loginlogo").style.backgroundSize="12.5vw 5vw";
	document.getElementById("loginlogo").style.width="12.5vw";
	document.getElementById("loginlogo").style.height="5vw";
	action="crearCuenta";
}
	//Username
	function checkUserName(){
		if (document.getElementById("username1").value.length<1){
			displayerrorUsername(usernameObligatorio);
			return false;
		}
		if (document.getElementById("username1").value.length<5){
			displayerrorUsername(usernameCortoError);
			return false;
		}
		else{
			if(action=="login") {
				displayOkeyUserName();
				return true;
			} else if(action=="crearCuenta"){
				return userNameDisponible;
			}
		}
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
			return false;
		}
		if (document.getElementById("password1").value.length<5){
			displayerrorPassword(usernameCortoError);
			return false;
		}
		else {
			displayOkeyPassword();
			return true;
		}
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
			return false;
		}
		if (document.getElementById("confirm_password1").value.length<5){
			displayerrorRePassword(usernameCortoError);
			return false;
		}
		else {
			if(document.getElementById("confirm_password1").value==document.getElementById("password1").value){
				displayOkeyRePassword();
				return true;
			}
			else {
				displayerrorRePassword("Passwords don't match")
				return false;
			}
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
		var bUsername = checkUserName();
		var bPassword = checkPassword();
		var bRePassword = checkRePassword();
		return bUsername && bPassword && bRePassword;
	}
	
	function validarLogin(){
		var bUsername = checkUserName();
		var bPassword = checkPassword();
		return bUsername && bPassword;
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
						<form id="signupForm1" class="form-horizontal" action="" method="post">
							<div class="form-group">
								<label class="col-sm-4 control-label" for="username1"><%= usuario %>:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="username1" 
										name="username1" placeholder="Username">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label" for="password1"><%= password %>:</label>
								<div class="col-sm-5">
									<input type="password" class="form-control" id="password1"
										name="password1" placeholder="Password">
								</div>
							</div>
							<div id="repassword" class="form-group" style="display:none">
								<label class="col-sm-4 control-label" for="confirm_password1"><%= rpassword %>:</label>
								<div class="col-sm-5">
									<input type="password" class="form-control"
										id="confirm_password1" name="confirm_password1"
										placeholder="Confirm password">
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
										value="crear">Crear cuenta</button>
									<div class="btn btn-primary" style="cursor:pointer" name="cancel"
										value="cancel" onclick="javascript:displayLogin()">Cancelar</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
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
	/*$.validator.setDefaults({
		onfocusin: function( element ) {
		},
		onfocusout: function( element ) {
		},
		onkeyup: function( element, event ) {
			return;
		},
		onclick: function( element ) {
		},
		highlight: function( element, errorClass, validClass ) {
		},
		unhighlight: function( element, errorClass, validClass ) {
		},
		submitHandler : function(element) {
			if(action=="crearCuenta" && validarDatos()){
				alert("crearCuenta")
			}
			else if (action=="login" && validarLogin()){
				alert("login")
			}
		}
	});*/
	
	$( "#username1" ).autocomplete({
	    source: function (request, response) {
	    	if(action=="crearCuenta"){
	    		userNameDisponible = false;
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
	    minLength: 5
	});
		$(document).ready(function(){
			$("#signupForm1").validate({ 
				  submitHandler: function(form) {
					  if(action=="crearCuenta" && validarDatos()){
							alert("crearCuenta")
						}
						else if (action=="login" && validarLogin()){
							alert("login")
						}
				  }
			});
			
			
			/*$("#signupForm1").validate(
					onfocusin: function( element ) {
					},
					onfocusout: function( element ) {
					},
					onkeyup: function( element, event ) {
						return;
					},
					onclick: function( element ) {
					},
					highlight: function( element, errorClass, validClass ) {
					},
					unhighlight: function( element, errorClass, validClass ) {
					},
					submitHandler : function(element) {
						if(action=="crearCuenta" && validarDatos()){
							alert("crearCuenta")
						}
						else if (action=="login" && validarLogin()){
							alert("login")
						}
					}		
			
			);*/
	  });
	</script>


</body>
</html>