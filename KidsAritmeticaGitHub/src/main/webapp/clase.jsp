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
String validacionesPendientesClase=RB.getString("validacionesPendientesClase");
String creandoClase=RB.getString("creandoClase");
String imprimirPdf=RB.getString("imprimirPdf");
String creado=RB.getString("creado");
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


var unAvailableUserNameError="<%= unAvailableUserNameError %>"
var usernameCortoError="<%= usernameCortoError %>"
var passordsInvalidas="<%= passordsInvalidas %>"
var usernameObligatorio="<%= usernameObligatorio %>"
var loginIncorrecto="<%= loginIncorrecto %>"
var verificarRecaptcha="<%= verificarRecaptcha %>"
var assignedUserNameError ="<%=assignedUserNameError%>"
var validacionesPendientesClase ="<%=validacionesPendientesClase%>"
var creandoClase ="<%=creandoClase%>"
var imprimirPdf ="<%=imprimirPdf%>"
var creado ="<%=creado%>"
var unAvailableUserNames = [];
var assignedUserNames = [];
var igualUsuarioPassword = false;
var ultimoAlumnoCreado

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
		    	if(user!=null) {
		    		document.getElementById("cresultado"+ultimoAlumnoCreado).style.backgroundImage="";
		    		document.getElementById("resultado"+ultimoAlumnoCreado).innerHTML=""+creado
		    		if (ultimoAlumnoCreado<30)
			    		handleSignUp();
			    	else {
			    		document.getElementById("loginAjax1").style.visibility="hidden"
						document.getElementById("createClassLabel").innerHTML=""+imprimirPdf
						document.getElementById("createClassLabel1").innerHTML=""+imprimirPdf
						document.getElementById("createClass").style.backgroundImage="url('BotonA.png')";
			    		document.getElementById("createClass1").style.backgroundImage="url('BotonA.png')";
			    		document.getElementById("createClass").onclick=function(){descargarFichero()};
			    		document.getElementById("createClass1").onclick=function(){descargarFichero()};
						firebase.auth().signOut().then(function() {
						}).catch(function(error) {
							alert("Error deslogue")
						});
			    	}
		    	}
		    });
		   
	});
 
	function handleSignUp() {
		ultimoAlumnoCreado++;
		if(document.getElementById("username"+ultimoAlumnoCreado).value.length>0) {
		    var user = document.getElementById("username"+ultimoAlumnoCreado).value;
		    var password = document.getElementById("password").value;
		    firebase.auth().createUserWithEmailAndPassword(user+"@playaddition.com", password)
		   	.catch(function(error) {
			    alert(errorCode+" "+errorMessage);
			    console.log(error);
		   	});
		} else {
			if (ultimoAlumnoCreado<30)
	    		handleSignUp();
			else {
				firebase.auth().signOut().then(function() {
				}).catch(function(error) {
					alert("Error deslogue")
				});
				document.getElementById("loginAjax1").style.visibility="hidden";
				document.getElementById("createClassLabel").innerHTML=""+imprimirPdf
				document.getElementById("createClassLabel1").innerHTML=""+imprimirPdf
				document.getElementById("createClass").style.backgroundImage="url('BotonA.png')";
	    		document.getElementById("createClass1").style.backgroundImage="url('BotonA.png')";
	    		document.getElementById("createClass").onclick=function(){descargarFichero()};
	    		document.getElementById("createClass1").onclick=function(){descargarFichero()};
			}
		}
	}
	
	function descargarFichero(){
		//location.href="/DescargaFichero"
		window.open("./DescargaFichero")
		 /*$.ajax({
			  url: "/DescargaFichero",
			  method: "post",
			  data:{nivel: '3'},
			  dataType: "application/pdf",
			  success : function(responseText) {
					//location.href = "descripcionNivel.jsp";
			  }
			})*/
				
	}

	//Username
	function checkUserName(i){
		if (document.getElementById("username"+i).value.length>0 && document.getElementById("username"+i).value.length<6)
			displayerrorUsername(usernameCortoError,i);
		if(document.getElementById("username"+i).value.length<1) {
			displayNormalUsername(i)
			//if(document.getElementById("password"+i).value.length<1)
			//	displayNormalPassword(i)
		}
	}
	function displayerrorUsername(error,i){
		$("#username"+i+"-glyphicon").remove();
		$("#username"+i+"-error").remove();
		$("<span id='username"+i+"-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#username"+i+".form-control"));
		$("<em id='username"+i+"-error' class='error help-block'>"+error+".</em>").insertAfter($("#username"+i+"-glyphicon"));
		$("input#username"+i+".form-control").parents(".col-md-3").addClass("has-error").removeClass("has-success");
	}
	
	function displayNormalUsername(i){
		$("input#username"+i+".form-control").parents(".col-md-3").removeClass("has-error").removeClass("has-success");
		$("#username"+i+"-glyphicon").remove();
		$("#username"+i+"-error").remove();
	}
	
	function displayOkeyUserName(i){
		$("input#username"+i+".form-control").parents(".col-md-3").addClass("has-success").removeClass("has-error");
		$("#username"+i+"-glyphicon").remove();
		$("#username"+i+"-error").remove();
		$("<span id='username"+i+"-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#username"+i+".form-control"));
	}
	
	//Password
	function checkPassword() {

			if (document.getElementById("password").value.length<1) {
				displayerrorPassword(usernameObligatorio);
				return
			}
			if (document.getElementById("password").value.length>0 && document.getElementById("password").value.length<6) {
				displayerrorPassword(usernameCortoError);
				return
			}
			if(document.getElementById("password").value.length>5)
				displayOkeyPassword();

	}
	
	function displayerrorPassword(error){
		$("#password-glyphicon").remove();
		$("#password-error").remove();
		$("<span id='password-glyphicon' class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter($("input#password.form-control"));
		$("<em id='password-error' class='error help-block'>"+error+".</em>").insertAfter($("#password-glyphicon"));
		$("input#password.form-control").parents(".col-md-3").addClass("has-error").removeClass("has-success");
	}
	
	function displayNormalPassword(){
		$("input#password.form-control").parents(".col-md-3").removeClass("has-error").removeClass("has-success");
		$("#password-glyphicon").remove();
		$("#password-error").remove();
	}
	
	function displayOkeyPassword(){
		$("input#password.form-control").parents(".col-md-3").addClass("has-success").removeClass("has-error");
		$("#password-glyphicon").remove();
		$("#password-error").remove();
		$("<span id='password-glyphicon' class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($("input#password.form-control"));
	}
	
	/*function usarMismaUsuarioPassword (checkbox){
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
				checkPassword(i);
			}
		}
	}*/
  
	
  function verificarFormulario() {
	  /*if (igualUsuarioPassword) {
		  for(i=1;i<=30;i++)
			  checkUserName(i)
	  } else {*/
	  checkPassword()
	  for(i=1;i<=30;i++)
		  checkUserName(i)  
	 // }
	  for(i=1;i<=30;i++)
	   		if(document.getElementById("password-error")!=null || document.getElementById("username"+i+"-error")!=null)
				return false;
	  return true;
  }
  
  function crearClase() {
	  if(verificarFormulario()) {
		  document.getElementById('createClass').onclick=function(){;}
		  document.getElementById('createClass1').onclick=function(){;}
		  document.getElementById("loginAjax1").style.visibility="visible";
		  document.getElementById("createClassLabel").innerHTML=""+creandoClase
		  document.getElementById("createClassLabel1").innerHTML=""+creandoClase
		  for(i=1;i<=30;i++) {
				document.getElementById("username"+i).disabled = true;
				//document.getElementById("password"+i).disabled = true;
				if(document.getElementById("username"+i).value.length>0)
					document.getElementById("cresultado"+i).style.visibility="visible";
		  }
		  ultimoAlumnoCreado = 0;
		  actualizarDatosPDF();
		  
	  } else {
		  alert(validacionesPendientesClase);
	  }
  }
  
  function actualizarDatosPDF(){
	  $.ajax({
		  url: "/DescargaFichero",
		  method: "post",
		  data:{
			  accion:'datos',
			  password:''+ document.getElementById("password").value,
			  usu1:''+document.getElementById("username1").value,
			 // pass1:''+document.getElementById("password1").value,
			  usu2:''+document.getElementById("username2").value,
			 // pass2:''+document.getElementById("password2").value,
			  usu3:''+document.getElementById("username3").value,
			 // pass3:''+document.getElementById("password3").value,
			  usu4:''+document.getElementById("username4").value,
			//  pass4:''+document.getElementById("password4").value,
			  usu5:''+document.getElementById("username5").value,
			//  pass5:''+document.getElementById("password5").value,
			  usu6:''+document.getElementById("username6").value,
			//  pass6:''+document.getElementById("password6").value,
			  usu7:''+document.getElementById("username7").value,
			//  pass7:''+document.getElementById("password7").value,
			  usu8:''+document.getElementById("username8").value,
			//  pass8:''+document.getElementById("password8").value,
			  usu9:''+document.getElementById("username9").value,
			//  pass9:''+document.getElementById("password9").value,
			  usu10:''+document.getElementById("username10").value,
			//  pass10:''+document.getElementById("password10").value,
			  usu11:''+document.getElementById("username11").value,
			//  pass11:''+document.getElementById("password11").value,
			  usu12:''+document.getElementById("username12").value,
			//  pass12:''+document.getElementById("password12").value,
			  usu13:''+document.getElementById("username13").value,
			//  pass13:''+document.getElementById("password13").value,
			  usu14:''+document.getElementById("username14").value,
			//  pass14:''+document.getElementById("password14").value,
			  usu15:''+document.getElementById("username15").value,
			//  pass15:''+document.getElementById("password15").value,
			  usu16:''+document.getElementById("username16").value,
			//  pass16:''+document.getElementById("password16").value,
			  usu17:''+document.getElementById("username17").value,
			 // pass17:''+document.getElementById("password17").value,
			  usu18:''+document.getElementById("username18").value,
			 // pass18:''+document.getElementById("password18").value,
			  usu19:''+document.getElementById("username19").value,
			 // pass19:''+document.getElementById("password19").value,
			  usu20:''+document.getElementById("username20").value,
			//  pass20:''+document.getElementById("password20").value,
			  usu21:''+document.getElementById("username21").value,
			//  pass21:''+document.getElementById("password21").value,
			  usu22:''+document.getElementById("username22").value,
			//  pass22:''+document.getElementById("password22").value,
			  usu23:''+document.getElementById("username23").value,
			//  pass23:''+document.getElementById("password23").value,
			  usu24:''+document.getElementById("username24").value,
			//  pass24:''+document.getElementById("password24").value,
			  usu25:''+document.getElementById("username25").value,
			//  pass25:''+document.getElementById("password25").value,
			  usu26:''+document.getElementById("username26").value,
			//  pass26:''+document.getElementById("password26").value,
			  usu27:''+document.getElementById("username27").value,
			//  pass27:''+document.getElementById("password27").value,
			  usu28:''+document.getElementById("username28").value,
			//  pass28:''+document.getElementById("password28").value,
			  usu29:''+document.getElementById("username29").value,
			//  pass29:''+document.getElementById("password29").value,
			  usu30:''+document.getElementById("username30").value
			//  pass30:''+document.getElementById("password30").value
			  },
		  success : function(responseText) {
			  handleSignUp();
		  }
	})
  }
  
  function resizePage() {
	 if(device.type=='mobile'){
		 document.getElementById('loginlogo').style.width="27vw";
		 document.getElementById('loginlogo').style.height="9vw";
	     document.getElementById('loginlogo').style.backgroundSize="27vw 9vw";
	     
	     document.getElementById('createClass1').style.width="30vw";
		 document.getElementById('createClass1').style.height="6vw";
		 document.getElementById('createClass1').style.fontSize="3.75vw";
		 document.getElementById('createClass1').style.left="19vw"
	     document.getElementById('createClass1').style.backgroundSize="30vw 6vw";
	     
	     document.getElementById('createClassCancel').style.width="20vw";
		 document.getElementById('createClassCancel').style.height="6vw";
		 document.getElementById('createClassCancel').style.fontSize="3.75vw";
		 document.getElementById('createClassCancel').style.left="54vw"
	     document.getElementById('createClassCancel').style.backgroundSize="20vw 6vw";
		 
		 document.getElementById('createClass').style.width="30vw";
		 document.getElementById('createClass').style.height="6vw";
		 document.getElementById('createClass').style.fontSize="3.75vw";
		 document.getElementById('createClass').style.left="19vw"
	     document.getElementById('createClass').style.backgroundSize="30vw 6vw";
	     
	     document.getElementById('createClassCancel1').style.width="20vw";
		 document.getElementById('createClassCancel1').style.height="6vw";
		 document.getElementById('createClassCancel1').style.fontSize="3.75vw";
		 document.getElementById('createClassCancel1').style.left="54vw"
	     document.getElementById('createClassCancel1').style.backgroundSize="20vw 6vw";
		 
		// document.getElementById('mismoUsuPassword').style.height="8vw";
	     
	     for(i=1;i<=30;i++) {
				document.getElementById("cresultado"+i).style.width="4.5vw";
				document.getElementById("cresultado"+i).style.height="4.5vw";
				document.getElementById("cresultado"+i).style.backgroundSize="4.5vw 4.5vw";
	     }
	     screenfull.request();
	 }
	 
  }
  function keyupPassword(e, index) {
	  if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18) {
	  	checkPassword(index);
	  }
  }
  
  function keyupUsername(e,index){
	  if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18
      		&& e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {
      	checkUserName(index);
      }
  }
  
  function keydownUsername(e, index){
	  if (e.which != 9 && e.which != 20 && e.which != 13 && e.which != 16 && e.which != 17 && e.which != 18
      		&& e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {
      	for (i = 0; i < assignedUserNames.length; i++) {
      		if(assignedUserNames[i][0]==index){
      			  assignedUserNames[i].pop(0);
      			  assignedUserNames[i].pop(1);
					  break;
				  }
      	 }
      }
  }
  
  function validarUserName(index){
	  var fLen = unAvailableUserNames.length;
		var fAsg = assignedUserNames.length;
		var user = document.getElementById("username"+index).value;
		var encontrado = false;
		if(fAsg>0){
	  		for (j = 0; j < fAsg; j++) {
					if(user==assignedUserNames[j][1] && assignedUserNames[j][0]!=index){
						encontrado=true;
						break;
					}
				}
	  		if(encontrado) {
	  			displayerrorUsername(assignedUserNameError,index);
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
	  			displayerrorUsername(unAvailableUserNameError,index);
	  			return
	  		}
  		} 
	    firebase.auth().signInWithEmailAndPassword(user+"@playaddition.com", "defaultpassword")
	      .then(function(firebaseUser) {
	    }).catch(function(error) {
			var errorCode = error.code;
		  	if (errorCode == 'auth/wrong-password') {
		  		unAvailableUserNames.push(user)
		  		displayerrorUsername(unAvailableUserNameError,index)
		  	} else if (errorCode=='auth/user-not-found'){
		  		var existente = false
		  		for (j = 0; j < fAsg; j++) {
	  				if(assignedUserNames[j][0]==index){
	  					assignedUserNames[j][1]=user
	  					existente = true
	  				}
				}
		  		if(!existente)
		  			assignedUserNames.push([index, user]);
		  		displayOkeyUserName(index);
		  	}
		  	console.log(error);
		});
	  
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
<body onload="initFormulario();resizePage()">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<div class="panel panel-default" align="center">
					<div class="panel-heading">
						<div id="loginlogo" style="position:relative;width:12.5vw;height:5vw;background-size:12.5vw 5vw;background-image:url(newaccount.png);background-repeat:no-repeat"></div>
					</div>
					<div class="panel-body">
						<form id="signupForm1" class="form-horizontal" action="" method="post">
					        <div class="form-group" style="height:2vw">
								<div class="col-sm-9 col-sm-offset-2" style="cursor:default;padding-left: 0px"> 
									<div id="createClass1" style="position:absolute;left:7vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:12vw;height:2.5vw;background-size:12vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="crearClase()" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label id="createClassLabel1" style="cursor:pointer;margin-top:0.3vw"><%= crearClase %></label></div>
									<div id="createClassCancel" style="position:absolute;left:20vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:7vw;height:2.5vw;background-size:7vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="location.href='presentacion.jsp'" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label style="cursor:pointer;margin-top:0.3vw"><%= cancelarBoton %></label></div>
								</div>
							</div>
							<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label><%= mismoUsuPass %>:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label><%=alumno %> 1:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username1" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          <!-- 
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="password1" placeholder="<%= password %>" required="" style="width:85%">
						          </div>
						            -->
						          <div id="cresultado1" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado1"></label>
						          </div>
						          
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 2:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username2" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						          <div id="cresultado2" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado2"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 3:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username3" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado3" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado3"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 4:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username4" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						         <div id="cresultado4" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado4"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 5:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username5" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						         <div id="cresultado5" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado5"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 6:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username6" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado6" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado6"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 7:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username7" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado7" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado7"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 8:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username8" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						         <div id="cresultado8" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado8"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 9:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username9" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado9" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado9"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 10:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username10" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado10" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado10"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 11:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username11" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado11" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado11"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 12:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username12" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado12" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado12"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 13:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username13" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado13" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado13"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 14:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username14" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						          <div id="cresultado14" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado14"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 15:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username15" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado15" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado15"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 16:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username16" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado16" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado16"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 17:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username17" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						         <div id="cresultado17" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado17"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 18:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username18" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado18" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado18"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 19:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username19" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado19" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado19"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 20:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username20" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						          <div id="cresultado20" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado20"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 21:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username21" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						          <div id="cresultado21" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado21"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 22:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username22" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado22" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado22"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 23:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username23" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado23" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado23"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 24:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username24" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						         <div id="cresultado24" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado24"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 25:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username25" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado25" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado25"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 26:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username26" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado26" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado26"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 27:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username27" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						         
						          <div id="cresultado27" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado27"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 28:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username28" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado28" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado28"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 29:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username29" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado29" class="col-md-3 mb-3" style="top:0.5vw;;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado29"></label>
						          </div>
       						</div>
       						<div class="form-group" align="center">
       							  <div class="col-md-3 mb-3" style="margin-left: 5vw">
						            <label ><%=alumno %> 30:</label>
						          </div>
						          <div class="col-md-3 mb-3">
						            <input type="text" class="form-control" id="username30" placeholder="<%= usuario %>" required="" style="width:85%">
						          </div>
						          
						          <div id="cresultado30" class="col-md-3 mb-3" style="top:0.5vw;visibility:hidden;width:1vw;height:1vw;background-size:1vw 1vw;background-image:url(loading.gif);background-repeat:no-repeat">
						            <label id="resultado30"></label>
						          </div>
       						</div>
       						<div class="form-group" style="height:2vw">
								<div class="col-sm-9 col-sm-offset-2" style="cursor:default;padding-left: 0px"> 
									<div id="createClass" style="position:absolute;left:7vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:12vw;height:2.5vw;background-size:12vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="crearClase()" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label id="createClassLabel" style="cursor:pointer;margin-top:0.3vw"><%= crearClase %></label></div>
									<div id="createClassCancel1" style="position:absolute;left:20vw;font-size:1.3vw;color:white;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;cursor:pointer;width:7vw;height:2.5vw;background-size:7vw 2.5vw;background-image:url(BotonA.png);background-repeat:no-repeat"
										onclick="location.href='presentacion.jsp'" onmouseover="this.style.backgroundImage='url(BotonB.png)'" onmouseout="this.style.backgroundImage='url(BotonA.png)'"><label style="cursor:pointer;margin-top:0.3vw"><%= cancelarBoton %></label></div>
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

	$('#password').on({
		"keyup": function(e) {
			keyupPassword(e);
		}
	});

	$('#password').on({
		"focusout": function(e) {
			checkPassword();
		}
	});

	$('#username1').on({
		"keyup": function(e) {
			keyupUsername(e,1)
		}
	});

	$('#username1').on({
		"keydown": function(e) {
			keydownUsername(e, 1)
		}
	});

	$('#username1').on({
		"focusout": function(e) {
			checkUserName(1);
		}
	});

	$('#username1').autocomplete({
		source: function (request, response) {
			validarUserName(1)
		},
		minLength: 6
	});

	/*$('#password2').on({
		"keyup": function(e) {
			keyupPassword(e, 2);
		}
	});

	$('#password2').on({
		"focusout": function(e) {
			checkPassword(2);
		}
	});*/

	$('#username2').on({
		"keyup": function(e) {
			keyupUsername(e,2)
		}
	});

	$('#username2').on({
		"keydown": function(e) {
			keydownUsername(e, 2)
		}
	});

	$('#username2').on({
		"focusout": function(e) {
			checkUserName(2);
		}
	});

	$('#username2').autocomplete({
		source: function (request, response) {
			validarUserName(2)
		},
		minLength: 6
	});

	/*$('#password3').on({
		"keyup": function(e) {
			keyupPassword(e, 3);
		}
	});

	$('#password3').on({
		"focusout": function(e) {
			checkPassword(3);
		}
	});*/

	$('#username3').on({
		"keyup": function(e) {
			keyupUsername(e,3)
		}
	});

	$('#username3').on({
		"keydown": function(e) {
			keydownUsername(e, 3)
		}
	});

	$('#username3').on({
		"focusout": function(e) {
			checkUserName(3);
		}
	});

	$('#username3').autocomplete({
		source: function (request, response) {
			validarUserName(3)
		},
		minLength: 6
	});

	/*$('#password4').on({
		"keyup": function(e) {
			keyupPassword(e, 4);
		}
	});

	$('#password4').on({
		"focusout": function(e) {
			checkPassword(4);
		}
	});*/

	$('#username4').on({
		"keyup": function(e) {
			keyupUsername(e,4)
		}
	});

	$('#username4').on({
		"keydown": function(e) {
			keydownUsername(e, 4)
		}
	});

	$('#username4').on({
		"focusout": function(e) {
			checkUserName(4);
		}
	});

	$('#username4').autocomplete({
		source: function (request, response) {
			validarUserName(4)
		},
		minLength: 6
	});

	/*$('#password5').on({
		"keyup": function(e) {
			keyupPassword(e, 5);
		}
	});

	$('#password5').on({
		"focusout": function(e) {
			checkPassword(5);
		}
	});*/

	$('#username5').on({
		"keyup": function(e) {
			keyupUsername(e,5)
		}
	});

	$('#username5').on({
		"keydown": function(e) {
			keydownUsername(e, 5)
		}
	});

	$('#username5').on({
		"focusout": function(e) {
			checkUserName(5);
		}
	});

	$('#username5').autocomplete({
		source: function (request, response) {
			validarUserName(5)
		},
		minLength: 6
	});

	/*$('#password6').on({
		"keyup": function(e) {
			keyupPassword(e, 6);
		}
	});

	$('#password6').on({
		"focusout": function(e) {
			checkPassword(6);
		}
	});*/

	$('#username6').on({
		"keyup": function(e) {
			keyupUsername(e,6)
		}
	});

	$('#username6').on({
		"keydown": function(e) {
			keydownUsername(e, 6)
		}
	});

	$('#username6').on({
		"focusout": function(e) {
			checkUserName(6);
		}
	});

	$('#username6').autocomplete({
		source: function (request, response) {
			validarUserName(6)
		},
		minLength: 6
	});

	/*$('#password7').on({
		"keyup": function(e) {
			keyupPassword(e, 7);
		}
	});

	$('#password7').on({
		"focusout": function(e) {
			checkPassword(7);
		}
	});*/

	$('#username7').on({
		"keyup": function(e) {
			keyupUsername(e,7)
		}
	});

	$('#username7').on({
		"keydown": function(e) {
			keydownUsername(e, 7)
		}
	});

	$('#username7').on({
		"focusout": function(e) {
			checkUserName(7);
		}
	});

	$('#username7').autocomplete({
		source: function (request, response) {
			validarUserName(7)
		},
		minLength: 6
	});

	/*$('#password8').on({
		"keyup": function(e) {
			keyupPassword(e, 8);
		}
	});

	$('#password8').on({
		"focusout": function(e) {
			checkPassword(8);
		}
	});*/

	$('#username8').on({
		"keyup": function(e) {
			keyupUsername(e,8)
		}
	});

	$('#username8').on({
		"keydown": function(e) {
			keydownUsername(e, 8)
		}
	});

	$('#username8').on({
		"focusout": function(e) {
			checkUserName(8);
		}
	});

	$('#username8').autocomplete({
		source: function (request, response) {
			validarUserName(8)
		},
		minLength: 6
	});

	/*$('#password9').on({
		"keyup": function(e) {
			keyupPassword(e, 9);
		}
	});

	$('#password9').on({
		"focusout": function(e) {
			checkPassword(9);
		}
	});*/

	$('#username9').on({
		"keyup": function(e) {
			keyupUsername(e,9)
		}
	});

	$('#username9').on({
		"keydown": function(e) {
			keydownUsername(e, 9)
		}
	});

	$('#username9').on({
		"focusout": function(e) {
			checkUserName(9);
		}
	});

	$('#username9').autocomplete({
		source: function (request, response) {
			validarUserName(9)
		},
		minLength: 6
	});

	/*$('#password10').on({
		"keyup": function(e) {
			keyupPassword(e, 10);
		}
	});

	$('#password10').on({
		"focusout": function(e) {
			checkPassword(10);
		}
	});*/

	$('#username10').on({
		"keyup": function(e) {
			keyupUsername(e,10)
		}
	});

	$('#username10').on({
		"keydown": function(e) {
			keydownUsername(e, 10)
		}
	});

	$('#username10').on({
		"focusout": function(e) {
			checkUserName(10);
		}
	});

	$('#username10').autocomplete({
		source: function (request, response) {
			validarUserName(10)
		},
		minLength: 6
	});

	/*$('#password11').on({
		"keyup": function(e) {
			keyupPassword(e, 11);
		}
	});

	$('#password11').on({
		"focusout": function(e) {
			checkPassword(11);
		}
	});*/

	$('#username11').on({
		"keyup": function(e) {
			keyupUsername(e,11)
		}
	});

	$('#username11').on({
		"keydown": function(e) {
			keydownUsername(e, 11)
		}
	});

	$('#username11').on({
		"focusout": function(e) {
			checkUserName(11);
		}
	});

	$('#username11').autocomplete({
		source: function (request, response) {
			validarUserName(11)
		},
		minLength: 6
	});

	/*$('#password12').on({
		"keyup": function(e) {
			keyupPassword(e, 12);
		}
	});

	$('#password12').on({
		"focusout": function(e) {
			checkPassword(12);
		}
	});*/

	$('#username12').on({
		"keyup": function(e) {
			keyupUsername(e,12)
		}
	});

	$('#username12').on({
		"keydown": function(e) {
			keydownUsername(e, 12)
		}
	});

	$('#username12').on({
		"focusout": function(e) {
			checkUserName(12);
		}
	});

	$('#username12').autocomplete({
		source: function (request, response) {
			validarUserName(12)
		},
		minLength: 6
	});

	/*$('#password13').on({
		"keyup": function(e) {
			keyupPassword(e, 13);
		}
	});

	$('#password13').on({
		"focusout": function(e) {
			checkPassword(13);
		}
	});*/

	$('#username13').on({
		"keyup": function(e) {
			keyupUsername(e,13)
		}
	});

	$('#username13').on({
		"keydown": function(e) {
			keydownUsername(e, 13)
		}
	});

	$('#username13').on({
		"focusout": function(e) {
			checkUserName(13);
		}
	});

	$('#username13').autocomplete({
		source: function (request, response) {
			validarUserName(13)
		},
		minLength: 6
	});

	/*$('#password14').on({
		"keyup": function(e) {
			keyupPassword(e, 14);
		}
	});

	$('#password14').on({
		"focusout": function(e) {
			checkPassword(14);
		}
	});*/

	$('#username14').on({
		"keyup": function(e) {
			keyupUsername(e,14)
		}
	});

	$('#username14').on({
		"keydown": function(e) {
			keydownUsername(e, 14)
		}
	});

	$('#username14').on({
		"focusout": function(e) {
			checkUserName(14);
		}
	});

	$('#username14').autocomplete({
		source: function (request, response) {
			validarUserName(14)
		},
		minLength: 6
	});

	/*$('#password15').on({
		"keyup": function(e) {
			keyupPassword(e, 15);
		}
	});

	$('#password15').on({
		"focusout": function(e) {
			checkPassword(15);
		}
	});*/

	$('#username15').on({
		"keyup": function(e) {
			keyupUsername(e,15)
		}
	});

	$('#username15').on({
		"keydown": function(e) {
			keydownUsername(e, 15)
		}
	});

	$('#username15').on({
		"focusout": function(e) {
			checkUserName(15);
		}
	});

	$('#username15').autocomplete({
		source: function (request, response) {
			validarUserName(15)
		},
		minLength: 6
	});

	/*$('#password16').on({
		"keyup": function(e) {
			keyupPassword(e, 16);
		}
	});

	$('#password16').on({
		"focusout": function(e) {
			checkPassword(16);
		}
	});*/

	$('#username16').on({
		"keyup": function(e) {
			keyupUsername(e,16)
		}
	});

	$('#username16').on({
		"keydown": function(e) {
			keydownUsername(e, 16)
		}
	});

	$('#username16').on({
		"focusout": function(e) {
			checkUserName(16);
		}
	});

	$('#username16').autocomplete({
		source: function (request, response) {
			validarUserName(16)
		},
		minLength: 6
	});

	/*$('#password17').on({
		"keyup": function(e) {
			keyupPassword(e, 17);
		}
	});

	$('#password17').on({
		"focusout": function(e) {
			checkPassword(17);
		}
	});*/

	$('#username17').on({
		"keyup": function(e) {
			keyupUsername(e,17)
		}
	});

	$('#username17').on({
		"keydown": function(e) {
			keydownUsername(e, 17)
		}
	});

	$('#username17').on({
		"focusout": function(e) {
			checkUserName(17);
		}
	});

	$('#username17').autocomplete({
		source: function (request, response) {
			validarUserName(17)
		},
		minLength: 6
	});

	/*$('#password18').on({
		"keyup": function(e) {
			keyupPassword(e, 18);
		}
	});

	$('#password18').on({
		"focusout": function(e) {
			checkPassword(18);
		}
	});*/

	$('#username18').on({
		"keyup": function(e) {
			keyupUsername(e,18)
		}
	});

	$('#username18').on({
		"keydown": function(e) {
			keydownUsername(e, 18)
		}
	});

	$('#username18').on({
		"focusout": function(e) {
			checkUserName(18);
		}
	});

	$('#username18').autocomplete({
		source: function (request, response) {
			validarUserName(18)
		},
		minLength: 6
	});

	/*$('#password19').on({
		"keyup": function(e) {
			keyupPassword(e, 19);
		}
	});

	$('#password19').on({
		"focusout": function(e) {
			checkPassword(19);
		}
	});*/

	$('#username19').on({
		"keyup": function(e) {
			keyupUsername(e,19)
		}
	});

	$('#username19').on({
		"keydown": function(e) {
			keydownUsername(e, 19)
		}
	});

	$('#username19').on({
		"focusout": function(e) {
			checkUserName(19);
		}
	});

	$('#username19').autocomplete({
		source: function (request, response) {
			validarUserName(19)
		},
		minLength: 6
	});

	/*$('#password20').on({
		"keyup": function(e) {
			keyupPassword(e, 20);
		}
	});

	$('#password20').on({
		"focusout": function(e) {
			checkPassword(20);
		}
	});*/

	$('#username20').on({
		"keyup": function(e) {
			keyupUsername(e,20)
		}
	});

	$('#username20').on({
		"keydown": function(e) {
			keydownUsername(e, 20)
		}
	});

	$('#username20').on({
		"focusout": function(e) {
			checkUserName(20);
		}
	});

	$('#username20').autocomplete({
		source: function (request, response) {
			validarUserName(20)
		},
		minLength: 6
	});

	/*$('#password21').on({
		"keyup": function(e) {
			keyupPassword(e, 21);
		}
	});

	$('#password21').on({
		"focusout": function(e) {
			checkPassword(21);
		}
	});*/

	$('#username21').on({
		"keyup": function(e) {
			keyupUsername(e,21)
		}
	});

	$('#username21').on({
		"keydown": function(e) {
			keydownUsername(e, 21)
		}
	});

	$('#username21').on({
		"focusout": function(e) {
			checkUserName(21);
		}
	});

	$('#username21').autocomplete({
		source: function (request, response) {
			validarUserName(21)
		},
		minLength: 6
	});

	/*$('#password22').on({
		"keyup": function(e) {
			keyupPassword(e, 22);
		}
	});

	$('#password22').on({
		"focusout": function(e) {
			checkPassword(22);
		}
	});*/

	$('#username22').on({
		"keyup": function(e) {
			keyupUsername(e,22)
		}
	});

	$('#username22').on({
		"keydown": function(e) {
			keydownUsername(e, 22)
		}
	});

	$('#username22').on({
		"focusout": function(e) {
			checkUserName(22);
		}
	});

	$('#username22').autocomplete({
		source: function (request, response) {
			validarUserName(22)
		},
		minLength: 6
	});

	/*$('#password23').on({
		"keyup": function(e) {
			keyupPassword(e, 23);
		}
	});

	$('#password23').on({
		"focusout": function(e) {
			checkPassword(23);
		}
	});*/

	$('#username23').on({
		"keyup": function(e) {
			keyupUsername(e,23)
		}
	});

	$('#username23').on({
		"keydown": function(e) {
			keydownUsername(e, 23)
		}
	});

	$('#username23').on({
		"focusout": function(e) {
			checkUserName(23);
		}
	});

	$('#username23').autocomplete({
		source: function (request, response) {
			validarUserName(23)
		},
		minLength: 6
	});

	/*$('#password24').on({
		"keyup": function(e) {
			keyupPassword(e, 24);
		}
	});

	$('#password24').on({
		"focusout": function(e) {
			checkPassword(24);
		}
	});*/

	$('#username24').on({
		"keyup": function(e) {
			keyupUsername(e,24)
		}
	});

	$('#username24').on({
		"keydown": function(e) {
			keydownUsername(e, 24)
		}
	});

	$('#username24').on({
		"focusout": function(e) {
			checkUserName(24);
		}
	});

	$('#username24').autocomplete({
		source: function (request, response) {
			validarUserName(24)
		},
		minLength: 6
	});

	/*$('#password25').on({
		"keyup": function(e) {
			keyupPassword(e, 25);
		}
	});

	$('#password25').on({
		"focusout": function(e) {
			checkPassword(25);
		}
	});*/

	$('#username25').on({
		"keyup": function(e) {
			keyupUsername(e,25)
		}
	});

	$('#username25').on({
		"keydown": function(e) {
			keydownUsername(e, 25)
		}
	});

	$('#username25').on({
		"focusout": function(e) {
			checkUserName(25);
		}
	});

	$('#username25').autocomplete({
		source: function (request, response) {
			validarUserName(25)
		},
		minLength: 6
	});

	/*$('#password26').on({
		"keyup": function(e) {
			keyupPassword(e, 26);
		}
	});

	$('#password26').on({
		"focusout": function(e) {
			checkPassword(26);
		}
	});*/

	$('#username26').on({
		"keyup": function(e) {
			keyupUsername(e,26)
		}
	});

	$('#username26').on({
		"keydown": function(e) {
			keydownUsername(e, 26)
		}
	});

	$('#username26').on({
		"focusout": function(e) {
			checkUserName(26);
		}
	});

	$('#username26').autocomplete({
		source: function (request, response) {
			validarUserName(26)
		},
		minLength: 6
	});

	/*$('#password27').on({
		"keyup": function(e) {
			keyupPassword(e, 27);
		}
	});

	$('#password27').on({
		"focusout": function(e) {
			checkPassword(27);
		}
	});*/

	$('#username27').on({
		"keyup": function(e) {
			keyupUsername(e,27)
		}
	});

	$('#username27').on({
		"keydown": function(e) {
			keydownUsername(e, 27)
		}
	});

	$('#username27').on({
		"focusout": function(e) {
			checkUserName(27);
		}
	});

	$('#username27').autocomplete({
		source: function (request, response) {
			validarUserName(27)
		},
		minLength: 6
	});

	/*$('#password28').on({
		"keyup": function(e) {
			keyupPassword(e, 28);
		}
	});

	$('#password28').on({
		"focusout": function(e) {
			checkPassword(28);
		}
	});*/

	$('#username28').on({
		"keyup": function(e) {
			keyupUsername(e,28)
		}
	});

	$('#username28').on({
		"keydown": function(e) {
			keydownUsername(e, 28)
		}
	});

	$('#username28').on({
		"focusout": function(e) {
			checkUserName(28);
		}
	});

	$('#username28').autocomplete({
		source: function (request, response) {
			validarUserName(28)
		},
		minLength: 6
	});

	/*$('#password29').on({
		"keyup": function(e) {
			keyupPassword(e, 29);
		}
	});

	$('#password29').on({
		"focusout": function(e) {
			checkPassword(29);
		}
	});*/

	$('#username29').on({
		"keyup": function(e) {
			keyupUsername(e,29)
		}
	});

	$('#username29').on({
		"keydown": function(e) {
			keydownUsername(e, 29)
		}
	});

	$('#username29').on({
		"focusout": function(e) {
			checkUserName(29);
		}
	});

	$('#username29').autocomplete({
		source: function (request, response) {
			validarUserName(29)
		},
		minLength: 6
	});

	/*$('#password30').on({
		"keyup": function(e) {
			keyupPassword(e, 30);
		}
	});

	$('#password30').on({
		"focusout": function(e) {
			checkPassword(30);
		}
	});*/

	$('#username30').on({
		"keyup": function(e) {
			keyupUsername(e,30)
		}
	});

	$('#username30').on({
		"keydown": function(e) {
			keydownUsername(e, 30)
		}
	});

	$('#username30').on({
		"focusout": function(e) {
			checkUserName(30);
		}
	});

	$('#username30').autocomplete({
		source: function (request, response) {
			validarUserName(30)
		},
		minLength: 6
	});
	
}
	
</script>
</html>