<%
    String nivel =  (String) session.getAttribute("nivel");
    if ( nivel == null)
    	session.setAttribute("nivel", "1");
    nivel =  (String) session.getAttribute("nivel");
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PlayAddition</title>
  <style>
   
  a {
	    font-family:"Berlin Sans FB Demi";  
	    text-align:center;
	    color:black;
	    text-decoration:none;
	    font-size: 80px;
	    color:red;
	}
  
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script>
  $( function() {
  	
  } );
  
  function goToLevel1(nivel){

	  location.href = "plantilla1.jsp"
}
	  
	
  </script>
</head>

  <body style="background-image:url(fondoPlayAddition.png);background-repeat:no-repeat;background-size:cover;width:100%;height:100%">
	
	
	<div align ="center" style="margin-top:100px">
		<div style="background-image:url(logoPlayAdditionSmall.png);background-repeat:no-repeat;background-size:cover;width:301px;height:299px;">
		</div>
		<div onclick="javascript:goToLevel1(1);" style="background-image:url(goToLevel.png);background-repeat:no-repeat;background-size:cover;width:560px;height:299px;">
			<label id="level" style="position:relative; left:160px;top:119px;color:white;font-family:Berlin Sans FB Demi;font-size: 145px"><%=nivel%></label>
		</div>
	</div>
  </body>
</html>