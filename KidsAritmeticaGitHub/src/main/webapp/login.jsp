<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<script src="./js/jquery/jquery-ui.js"></script>
<script src="./js/jquery/jquery-3.3.1.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-app.js"></script>

  <!-- Add Firebase products that you want to use -->
  <script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/6.5.0/firebase-firestore.js"></script>
<script type="text/javascript">

function handleSignUp() {
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    var repassword = document.getElementById('repasswordd').value;
    if (email.length < 4) {
      alert('User name too short.');
      return;
    }
    if (password.length < 4) {
      alert('Please enter a password.');
      return;
    }
    
    if(repassword!=password){
    	alert("Password provided don\'t match");
        return;
    }
    // Sign in with email and pass.
    // [START createwithemail]
    firebase.auth().createUserWithEmailAndPassword(email+"@playaddition.com", password).catch(function(error) {
      // Handle Errors here.
      var errorCode = error.code;
      var errorMessage = error.message;
      // [START_EXCLUDE]
      if (errorCode == 'auth/weak-password') {
        alert('The password is too weak.');
      } else {
        alert(errorMessage);
      }
      console.log(error);
      // [END_EXCLUDE]
    });
    /*firebase.auth().currentUser.sendEmailVerification().then(function() {
        // Email Verification sent!
        // [START_EXCLUDE]
        alert('Email Verification Sent!');
        // [END_EXCLUDE]
      });*/
    
    // [END createwithemail]
  }



function initApp() {
	
	// Your web app's Firebase configuration
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
	  // Initialize Firebase
	  firebase.initializeApp(firebaseConfig);
	
    // Listening for auth state changes.
    // [START authstatelistener]
    firebase.auth().onAuthStateChanged(function(user) {
      // [START_EXCLUDE silent]
      //document.getElementById('quickstart-verify-email').disabled = true;
      // [END_EXCLUDE]
      if (user!=null) {
        // User is signed in.
        var displayName = user.displayName;
        var email = user.email;
        var emailVerified = user.emailVerified;
        var photoURL = user.photoURL;
        var isAnonymous = user.isAnonymous;
        var uid = user.uid;
        var providerData = user.providerData;
        location.href='presentacion.jsp'
        // [END_EXCLUDE]
      } else {
    	  
        // User is signed out.
        // [START_EXCLUDE]
        //document.getElementById('quickstart-sign-in-status').textContent = 'Signed out';
        //document.getElementById('quickstart-sign-in').textContent = 'Sign in';
        //document.getElementById('quickstart-account-details').textContent = 'null';
        // [END_EXCLUDE]
      }
      // [START_EXCLUDE silent]
      //document.getElementById('quickstart-sign-in').disabled = false;
      // [END_EXCLUDE]
    });
    // [END authstatelistener]
    //document.getElementById('quickstart-sign-in').addEventListener('click', toggleSignIn, false);
    //document.getElementById('quickstart-sign-up').addEventListener('click', handleSignUp, false);
    //document.getElementById('quickstart-verify-email').addEventListener('click', sendEmailVerification, false);
    //document.getElementById('quickstart-password-reset').addEventListener('click', sendPasswordReset, false);
  }
  window.onload = function() {
    initApp();
  };
	
	function createAccount(){
		//document.getElementById("emailid").style.display="inline";
		document.getElementById("repassword").style.display="inline";
		document.getElementById("repassword").style.position="relative";
		document.getElementById("terms").style.top="2vw";
		document.getElementById("terms").style.display="inline";
		document.getElementById("terms").style.top="4vw";
		document.getElementById("terms").style.left="2vw";
		document.getElementById("terms").style.width="29vw";
		document.getElementById("terms").style.height="5vw";
		document.getElementById("terms").style.position="relative";
		document.getElementById("loginaction").style.display="none";
		document.getElementById("createAccountAction").style.display="inline";
		document.getElementById("createAccountAction").style.top="6vw";
		document.getElementById("createAccountAction").style.width="29vw";
		document.getElementById("createAccountAction").style.height="4vw";
		document.getElementById("createAccountAction").style.position="relative";
		//document.getElementById("login").style.height="28vw";
		document.getElementById("loginlogo").style.backgroundImage="url(newaccount.png)";
		document.getElementById("loginlogo").style.backgroundSize="12.5vw 5vw";
		document.getElementById("loginlogo").style.width="12.5vw";
		document.getElementById("loginlogo").style.height="5vw";
	}
	
	function gotologin(){
		//document.getElementById("emailid").style.display="none";
		document.getElementById("repassword").style.display="none";
		document.getElementById("terms").style.display="none";
		document.getElementById("loginaction").style.display="inline";
		document.getElementById("loginaction").align="center";
		document.getElementById("login").align="center";
		document.getElementById("createAccountAction").style.display="none";
		//document.getElementById("login").style.height="22vw";
		document.getElementById("loginlogo").style.backgroundImage="url(login.png)";
		document.getElementById("loginlogo").style.backgroundSize="10vw 5vw";
		document.getElementById("loginlogo").style.width="10vw";
		document.getElementById("loginlogo").style.height="5vw";
	}
	
	function login(){
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;
		firebase.auth().signInWithEmailAndPassword(email, password)
		   .then(function(firebaseUser) {
			  // alert(firebaseUser);
			   $.ajax({
					  url: "/loginUser",
					  method: "post",
					  data:{loginuser: ''+firebaseUser.user.displayName, loginId:''+firebaseUser.user.uid}
					  /*success : function(responseText) {
						  location.href = "descripcionNivel.jsp";
					  }*/ 
					});
		   })
		  .catch(function(error) {
			  var errorCode = error.code;
			  var errorMessage = error.message;
		  		if (errorCode === 'auth/wrong-password') {
		    	alert('Wrong password.');
		  	} else {
		    	alert(errorMessage);
		  	}
		  	console.log(error);
			});
		 }
</script>

<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer>
</script>

<script type="text/javascript">
      var onloadCallback = function() {
        grecaptcha.render('html_element', {
          'sitekey' : '6LdtBsMUAAAAALnCsHUaDL6jAdyyi5YVwRvXCXrP'
        });
      };
    </script>

</head>
<body>
	<div style="position:absolute;top:4vw;left:38vw;width:29vw;height:45vw;" align="center">
		<div id="loginlogo" style="position:relative;width:10vw;height:5vw;background-size:10vw 5vw;background-image:url(login.png);background-repeat:no-repeat"></div>

		<div id="login" style="position:relative;top:3vw;width:29vw;height:25vw;border:0.1vw solid blue" align="center">
			<div id="logininfo" style="position:relative;top:1vw;width:29vw;height:15vw;padding:1vw" align="left">
				
				<div>
					<label style ="font-family:Calibri;font-size:1.5vw;font-color:black">User:</label>
					<input type="text" id="email" style="position:relative;left:7.95vw;width:14.5vw;height:1.5vw"></input>
					<div id="available" style="display:none;font-family:Calibri;font-size:0.8vw;position:relative;left:12.6vw">Available</div>
				</div>
				<div style="position:relative;top:1vw">
					<label style="font-family:Calibri;font-size:1.5vw;font-color:black">Password:&nbsp;</label>
					<input type="password" id="password" style="position:relative;left:4.65vw;width:14.5vw;height:1.5vw"></input>
				</div>
				
				<div id="repassword" style="position:relative;top:2vw;display:none">
					<label style="font-family:Calibri;font-size:1.5vw;font-color:black">Repeat password:&nbsp;</label>
					<input type="password" id="repasswordd" style="position:relative;width:14.5vw;height:1.5vw"></input>
				</div>
				
				<div id="terms" style="position:relative;display:none;top:4vw;left:2vw;width:29vw;height:5vw">
					<div style="position:relative;width:29vw;height:2.5vw">
						<label style="font-family:Calibri;font-size:1.25vw;font-color:black"><input style="width:1vw;height:1vw" type="checkbox" value="">I agree to Arithmetics terms of service</label>
					</div>
					<div style="position:relative;width:29vw;height:2.5vw">
						<label style="font-family:Calibri;font-size:1.25vw;font-color:black"><input style="width:1vw;height:1vw" type="checkbox" value="">Send me information...(it's optional)</label>
					</div>
				</div>
				
				<div id="loginaction" style="position:relative;width:29vw;height:12vw;top:5vw" align="center">
					<div id="loginboton" style="cursor:pointer;width:8vw;height:4vw;background-size:8vw 4vw;background-image:url(login.png);background-repeat:no-repeat" onclick="javascript:login()"></div>
					<div id="loginaccount" style="position:relative;top:5vw;font-family:Calibri;font-size:1.5vw;font-color:blue">
						<a style="color:blue;cursor:pointer" onclick="javascript:createAccount()"><u>Create an account</u></a>
					</div>
				</div>
				
				<div id="createAccountAction" style="position:relative;display:none;top:4vw;width:29vw;height:4vw;">
					<div style="float:left;position:relative;left:6.75vw;cursor:pointer;width:8vw;height:4vw;background-size:8vw 4vw;background-image:url(createaccount.png);background-repeat:no-repeat" onclick="javascript:handleSignUp()"></div>
					<div style="float:right;position:relative;right:6.75vw;top:1vw;cursor:pointer;width:6vw;height:3vw;background-size:6vw 3vw;background-image:url(cancelaccount.png);background-repeat:no-repeat" onclick="javascript:gotologin()"></div>
				</div>	
			</div>
			
		</div>
		
		<div id="html_element" style="position:relative;top:5vw"></div>
	</div>
	
	
	
</body>
</html>