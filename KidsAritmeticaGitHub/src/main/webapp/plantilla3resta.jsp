<%@page import="playaddition.model.Resta"%>
<%@page import="java.util.*"%>
<%
String nivel =  (String) session.getAttribute("nivel");
List<Resta>  restas = (List<Resta>) session.getAttribute("restas");
boolean assistance = (Boolean)session.getAttribute("assistance");
boolean wa = (Boolean)session.getAttribute("wa");
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>PlayAddition</title>
  <style>
  	#preload-03 { background: url(http://test.playaddition.com/checkBoton.png) no-repeat -9999px -9999px; }
	#preload-04 { background: url(http://test.playaddition.com/checkBotonClick.png) no-repeat -9999px -9999px; }
	#preload-05 { background: url(http://test.playaddition.com/startOverBoton.png) no-repeat -9999px -9999px; }
	#preload-06 { background: url(http://test.playaddition.com/levelUpBoton.png) no-repeat -9999px -9999px; }
	#preload-07 { background: url(http://test.playaddition.com/correctBoton.png) no-repeat -9999px -9999px; }
   @font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
   @font-face{
	 	font-family:'digital7';
 		src: url('digital7.ttf');
	}
	
	@font-face{
	 	font-family:'digital7mono';
 		src: url('digital7Mono.ttf');
	}
	
  a {
	    font-family:"Berlin Sans FB Demi";  
	    color:rgb(0, 112, 192);
	    font-size: 28px;
	    cursor: pointer;
	}
	
	.unselectable {
	    -moz-user-select: -moz-none;
	    -khtml-user-select: none;
	    -webkit-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
  
  </style>
  <script src="./js/jquery/jquery-ui.js"></script>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  
  
  
 <!-- Global site tag (gtag.js) - Google Analytics 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-130256336-3');
</script>
-->


<!-- Global site tag (gtag.js) - Google Analytics-->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130256336-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-130256336-1');
</script>
  
   
  
  <script>
var dominio = "test.playaddition.com";
//  var dominio = "playaddition.com";
  $( function() {
	  	
  } );           
  var nivel = <%=nivel%>;
  var assistanceMode = <%=wa%>;
  var assistance = <%=assistance%>;	
  var sumas = [];
  var indexSuma = -1;
 <%
   int sumasNecesarias = 10;
 if(nivel.equalsIgnoreCase("22") || nivel.equalsIgnoreCase("26") || nivel.equalsIgnoreCase("32") || nivel.equalsIgnoreCase("40"))
	  			sumasNecesarias = 15;
   Iterator<Resta> iter = restas.iterator();
   int i = 0;
   while(iter.hasNext()){
	   Resta suma = iter.next();%>
 	 sumas[<%=i%>] = {operador1:"<%=suma.getOperando1()%>", operador2:"<%=suma.getOperando2()%>", resultado:"<%=suma.getResultadoResta()%>"};
  <%i++;}%>
	
  function subirNivel() {
		nivel++;
		$.ajax({
			  url: "/hello",
			  method: "post",
			  data:{nivel: ''+nivel, accion:'subirNivel'},
			  success : function(responseText) {
				  location.href = "descripcionSubtraction.jsp";
			  }  
			});
	}
  

	function calcularSuma() {
		indexSuma++;
		 if (parseInt(sumas[indexSuma].operador1, 10)<10){
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1;
			 document.getElementById('decenasCifra1').innerHTML = "";
			 document.getElementById('centenasCifra1').innerHTML = "";
			
		 }else if(parseInt(sumas[indexSuma].operador1, 10)<100){
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(1);
			 document.getElementById('decenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(0);
			 document.getElementById('centenasCifra1').innerHTML = "";
			 
		 } else {
			 document.getElementById('unidadesCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(2);
			 document.getElementById('decenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(1);
			 document.getElementById('centenasCifra1').innerHTML = ""+sumas[indexSuma].operador1.charAt(0);
			 var decenas = parseInt(sumas[indexSuma].operador1.charAt(1), 10)
			 if(decenas==0)
				 document.getElementById('decenasCifra1').style.cursor="default";
				 
		 }
		 
		 if(document.getElementById('decenasCifra1').innerHTML == "0"){
			 document.getElementById('decenasCifra1').style.cursor="default";
			 document.getElementById("casillaLlevadaDecenas").style.cursor="default";
			 document.getElementById('cifraCasillaLlevadaDecenas').style.cursor="default";
		 }
		 
		 if (parseInt(sumas[indexSuma].operador2, 10)<10){
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2;
			 document.getElementById('decenasCifra2').innerHTML = "";
		 }else if(parseInt(sumas[indexSuma].operador2, 10)<100){
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(1);
			 document.getElementById('decenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(0);
		 } else {
			 document.getElementById('unidadesCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(2);
			 document.getElementById('decenasCifra2').innerHTML = ""+sumas[indexSuma].operador2.charAt(1);
		 }
		
		 document.getElementById('sumaUnidadesCifra').innerHTML ="";
		 document.getElementById('sumaDecenasCifra').innerHTML ="";
		 document.getElementById('sumaCentenasCifra').innerHTML ="";
	     
	     document.getElementById('sumaUnidadesCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaDecenasCifra').style.color="rgb(0,110,188)";
		 document.getElementById('sumaCentenasCifra').style.color="rgb(0,110,188)";
		 

	     document.getElementById("casillaLlevadaCentenas").style.borderStyle = "none";
		 document.getElementById('cifraCasillaLlevadaCentenas').innerHTML="";
		 
		 document.getElementById("casillaLlevadaDecenas").style.borderStyle = "none";
		 document.getElementById('cifraCasillaLlevadaDecenas').innerHTML="";
		 
		 document.getElementById("tachadaCentenas").style.visibility="hidden";
	  	 document.getElementById("elunoCentenas").style.visibility="hidden";
	  	 document.getElementById("tachadaDecenas").style.visibility="hidden";
	  	 document.getElementById("elunoDecenas").style.visibility="hidden";

	     setSelected ("sumaUnidades");
	     
	}
	
	function asyncCall() {
		if(sumasActuales<<%=sumasNecesarias%>) {
	  		calcularSuma();
	  		document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
	  		bloquearInteracciones = false;
		}else {
			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(levelUpBoton.png)";
	  		nivelIniciado = false;
	  		document.getElementById('capaBotonCheckSuma').onclick=function(){subirNivel()}
	  		document.body.onkeydown = function(evObject){
	  			if(window.event)
	  		  	      var keyCode = window.event.keyCode;       // IE
	  		  	else
	  		  	      var keyCode = evObject.which;
  		  		if (keyCode==13)
  		  			subirNivel();
  			};
		}
	}

  
  
  function comprobarSuma(){
	  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBotonClick.png)';
	  if(document.getElementById('sumaDecenasCifra').innerHTML==''  || document.getElementById('sumaDecenasCifra').innerHTML==null ||
	      document.getElementById('sumaUnidadesCifra').innerHTML=='' || document.getElementById('sumaUnidadesCifra').innerHTML==null ) {
		  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBoton.png)';
		  	return;
	  } else {
		  if (!bloquearInteracciones) {
			  bloquearInteracciones = true;
			  document.getElementById('capaBotonCheckSuma').style.backgroundImage='url(checkBotonClick.png)';
			  
			  var centenas = document.getElementById('sumaCentenasCifra').innerHTML;
			  if(document.getElementById('sumaCentenasCifra').innerHTML=='' ||
					  document.getElementById('sumaCentenasCifra').innerHTML==null)
				  centenas="0";
			  var sumaAlumno = (100*parseInt(centenas, 10)+
					  10*parseInt(document.getElementById('sumaDecenasCifra').innerHTML, 10) +
				  parseInt(document.getElementById('sumaUnidadesCifra').innerHTML, 10));
			  
			  var operador1 = (100*parseInt(document.getElementById('centenasCifra1').innerHTML, 10)+
					  10*parseInt(document.getElementById('decenasCifra1').innerHTML, 10) +
				  parseInt(document.getElementById('unidadesCifra1').innerHTML, 10));
			  
			  
			  
			  var decenas = document.getElementById('decenasCifra2').innerHTML;
			  if(document.getElementById('decenasCifra2').innerHTML=='' ||
					  document.getElementById('decenasCifra2').innerHTML==null)
				  decenas="0";
			  var operador2 = (10*parseInt(decenas, 10) +
				  parseInt(document.getElementById('unidadesCifra2').innerHTML, 10));
			  
			  if (sumaAlumno == operador1-operador2){
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(correctBoton.png)";
				  sumasActuales++;
				  document.getElementById('indicadorSumas').innerHTML = ""+sumasActuales+"/<%=sumasNecesarias%>";
				  setTimeout(asyncCall, 600);
			  } else {
				 if(sumas[indexSuma].resultado.length == 3) {
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaCentenasCifra').innerHTML)  
			  			  document.getElementById('sumaCentenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaDecenasCifra').innerHTML)
						  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(2)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
				  }else if(sumas[indexSuma].resultado.length == 2) {
					  if(document.getElementById('sumaCentenasCifra').innerHTML!="0")  
			  			  document.getElementById('sumaCentenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(0)!=document.getElementById('sumaDecenasCifra').innerHTML)
						  document.getElementById('sumaDecenasCifra').style.color="red";
					  if(sumas[indexSuma].resultado.charAt(1)!=document.getElementById('sumaUnidadesCifra').innerHTML)
						  document.getElementById('sumaUnidadesCifra').style.color="red";
			  	  }
				  document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(startOverBoton.png)";
				  document.getElementById('capaBotonCheckSuma').onclick = function(){
					  	sumasActuales = 0;
					  	document.getElementById('indicadorSumas').innerHTML = "0/<%=sumasNecesarias%>";
					  	calcularSuma();
			  			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
			  			bloquearInteracciones = false;
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){this.style.backgroundImage="url(checkBotonClick.png)";setTimeout(comprobarSuma, 400)}
			  			document.body.onkeydown = function(evObject){
				  			if(window.event)
				  		  	      var keyCode = window.event.keyCode;       // IE
				  		  	else
				  		  	      var keyCode = evObject.which;
				  	  		if(!bloquearInteracciones) {
				  		  		makeUnselectable();
				  		  		if(keyCode==8 || keyCode==46)
				  		  			document.getElementById(""+casillaSeleccionada).firstElementChild.innerHTML ="";
				  		  		else if (keyCode==13)
				  		  			comprobarSuma();
				  	  		}
			  			};
			  	  };
			  	  document.body.onkeydown = function(evObject){
		  			if(window.event)
		  		  	      var keyCode = window.event.keyCode;       // IE
		  		  	else
		  		  	      var keyCode = evObject.which;
		  	  		if (keyCode==13){
			  	  		calcularSuma();
			  			document.getElementById('capaBotonCheckSuma').style.backgroundImage="url(checkBoton.png)";
			  			bloquearInteracciones = false;
			  			document.getElementById('capaBotonCheckSuma').onclick=function(){comprobarSuma()}
			  			document.body.onkeydown = function(evObject){
				  			if(window.event)
				  		  	      var keyCode = window.event.keyCode;       // IE
				  		  	else
				  		  	      var keyCode = evObject.which;
				  	  		if(!bloquearInteracciones) {
				  		  		makeUnselectable();
				  		  		if(keyCode==8 || keyCode==46)
				  		  			document.getElementById(""+casillaSeleccionada).firstElementChild.innerHTML ="";
				  		  		else if (keyCode==13)
				  		  			comprobarSuma();
				  	  		}
			  			};
			  	  	}
	  			  };
			  }
			  
		  } else
			  return;
  		}
  	}
  


   function iniciarCrono() {
        emp=new Date();
        elcrono=setInterval(tiempo,10);
   }
  			
  function tiempo() { 
	  if(nivelIniciado) {
	       actual=new Date();
	       cro=actual-emp;
	       cr=new Date();
	       cr.setTime(cro); 
	       cs=cr.getMilliseconds();
	       cs=cs/10;
	       cs=Math.round(cs);
	       sg=cr.getSeconds();
	       mn=cr.getMinutes();
	       ho=cr.getHours()-1;	 
	       if (cs<10) {cs="0"+cs;} 
	       if (sg<10) {sg="0"+sg;} 
	       if (mn<10) {mn="0"+mn;} 
	       document.getElementById('minutero').innerHTML =""+mn+":"+sg;
	  }
    }
  	
  	function clickCifraSuma(cifra) {
  		makeUnselectable();
  		if(!bloquearInteracciones) {
  			setSelected(cifra.id);
  		}
  	}
  	
  	
  	function dobleClickCifraSuma(cifra) {
  		makeUnselectable();
  		if(!bloquearInteracciones) {
  			cifra.firstElementChild.innerHTML ="";
  			setSelected(cifra.id);
  		}
  	}
  	
  	function ponerDigito (idDigito) {
  	  if(!bloquearInteracciones) {
  		var digito = document.getElementById(idDigito).firstElementChild.firstChild.nodeValue;
  	 	document.getElementById(''+casillaSeleccionada).firstElementChild.innerHTML = ""+digito;
  	  	if(casillaSeleccionada=='sumaUnidades'){
  		  document.getElementById(''+casillaSeleccionada).style.borderColor="black";
		  var divCifra = document.getElementById(''+casillaSeleccionada).previousElementSibling;
		  divCifra.style.borderColor="blue";
		  casillaSeleccionada=''+divCifra.id;
  	  	} else if(casillaSeleccionada=='sumaDecenas'){
    		  document.getElementById(''+casillaSeleccionada).style.borderColor="black";
    		  var divCifra = document.getElementById(''+casillaSeleccionada).previousElementSibling;
    		  divCifra.style.borderColor="blue";
    		  casillaSeleccionada=''+divCifra.id;
      	} else if(casillaSeleccionada=="casillaLlevadaCentenas"){
  	  		document.getElementById("cifraCasillaLlevadaCentenas").innerHTML = ""+digito;
  	  		document.getElementById("elunoCentenas").style.visibility="visible";
  	  		if(document.getElementById("decenasCifra1").innerHTML!="0" || 
					(document.getElementById("decenasCifra1").innerHTML=="0" && document.getElementById("cifraCasillaLlevadaCentenas").innerHTML!="") 
			  )
  	  			document.getElementById("decenasCifra1").style.cursor="pointer";
  		}else if(casillaSeleccionada=="casillaLlevadaDecenas"){
  	  		document.getElementById("cifraCasillaLlevadaDecenas").innerHTML = ""+digito;
  	  		if(document.getElementById("elunoDecenas").style.visibility=="hidden")
  	  			document.getElementById("unidadesCifra1").style.cursor="pointer";
  	  			//document.getElementById("elunoDecenas").style.visibility=="visible"
  		}
  	  }
    }
  	
  	function setSelected (id) {
  		casillaSeleccionada = id;
  		if (id=='sumaCentenas') {
  			document.getElementById("sumaCentenas").style.borderColor="blue";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevadaCentenas").style.border = "";
  			document.getElementById("casillaLlevadaDecenas").style.border = "";
  		} else if (id=='sumaDecenas') {
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="blue";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevadaCentenas").style.border = "";
  			document.getElementById("casillaLlevadaDecenas").style.border = "";
  		} else if (id=='sumaUnidades') {
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="blue";
  			document.getElementById("casillaLlevadaCentenas").style.border = "";
  			document.getElementById("casillaLlevadaDecenas").style.border = "";
  		} else if (id=='casillaLlevadaCentenas'){
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevadaCentenas").style.border = "0.2vw solid blue";
	  		document.getElementById("casillaLlevadaCentenas").style.borderRadius="0.1vw";
	  		document.getElementById("casillaLlevadaDecenas").style.border = "";
  		} else if (id=='casillaLlevadaDecenas'){
  			document.getElementById("sumaCentenas").style.borderColor="black";
  			document.getElementById("sumaDecenas").style.borderColor="black";
  			document.getElementById("sumaUnidades").style.borderColor="black";
  			document.getElementById("casillaLlevadaCentenas").style.border = "";
  			document.getElementById("casillaLlevadaDecenas").style.border = "0.2vw solid blue";
	  		document.getElementById("casillaLlevadaDecenas").style.borderRadius="0.1vw";
  		}
  	}
  	
  	function makeUnselectable() {
 		 if (window.getSelection) {window.getSelection().removeAllRanges();}
 		 else if (document.selection) {document.selection.empty();}
 	}
  	
  	var emp;
  	var casillaSeleccionada='sumaUnidades';
  	var nivelIniciado = true;
  	var sumasActuales = 0;
  	var bloquearInteracciones = false;
  	var navegador;  
  	
  	function borrarNumero(evObject) {
  		if(window.event)
	  	      var keyCode = window.event.keyCode;       // IE
	  	else
	  	      var keyCode = evObject.which;
  		if(!bloquearInteracciones) {
	  		makeUnselectable();
	  		if(keyCode==8 || keyCode==46)
	  			document.getElementById(""+digitoSuma).firstElementChild.innerHTML ="";
	  		else if (keyCode==13)
	  			comprobarSuma();
  		}
  	}
  	
  	function ponerNumero(evObject) {
  		if(!bloquearInteracciones) {
	  		makeUnselectable();
	  		var obj;
	  		if(window.event)
	  	      var keyCode = window.event.keyCode;       // IE
	  	   else
	  	      var keyCode = evObject.which;
			 if (keyCode==48) {
				obj = document.getElementById("cero");
				obj.style.backgroundColor="rgb(236, 178, 178)";
	  	    	ponerDigito("cero");
			 } else if(keyCode==49){
				obj = document.getElementById("uno");
				obj.style.backgroundColor="rgb(236, 178, 178)";
		    	ponerDigito("uno");
	  	     } else if(keyCode==50){
	  	    	obj = document.getElementById("dos");
	  	    	obj.style.backgroundColor="rgb(236, 178, 178)";
		    	ponerDigito("dos");
	  	  	 } else if(keyCode==51){
	  	  		obj = document.getElementById("tres");
	  	  	obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("tres");
	  		 } else if(keyCode==52){
	  			obj = document.getElementById("cuatro");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("cuatro");
	  		 } else if(keyCode==53){
	  			obj = document.getElementById("cinco");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("cinco");
	  		 } else if(keyCode==54){
	  			obj = document.getElementById("seis");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("seis");
	  		 } else if(keyCode==55){
	  			obj = document.getElementById("siete");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("siete");
	  		 } else if(keyCode==56){
	  			obj = document.getElementById("ocho");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("ocho");
	  		} else if(keyCode==57){
	  			obj = document.getElementById("nueve");
	  			obj.style.backgroundColor="rgb(236, 178, 178)";
	    		ponerDigito("nueve");
	  		}
			setTimeout(function(){obj.style.backgroundColor=""},500);
  		}
  	}
  	
  	function onClickCifra(obj){
  		if(!bloquearInteracciones) {
  			makeUnselectable();
  			obj.style.backgroundColor="rgb(236, 178, 178)";
  			ponerDigito(obj.id);
  			setTimeout(function(){obj.style.backgroundColor=""},500);
  		}
  	}
  	
  	function initAssistance(obj) {
	  	if(assistance)	{
	  		if(obj.id=="centenasCifra1" || obj.id=="tachadaCentenas" || obj.id=="casillaLlevadaCentenas"){
	  			document.getElementById("tachadaCentenas").style.visibility="visible";
	  			document.getElementById("tachadaCentenas").style.backgroundSize="6vw 6vw";
	  		} else if( obj.id=="decenasCifra1" || obj.id=="tachadaDecenas" || obj.id=="casillaLlevadaDecenas"){
	  			if(document.getElementById("decenasCifra1").innerHTML!="0" || 
	  					(document.getElementById("decenasCifra1").innerHTML=="0" && document.getElementById("cifraCasillaLlevadaCentenas").innerHTML!="") 
	  			  ) {
		  				document.getElementById("tachadaDecenas").style.visibility="visible";
		  				document.getElementById("tachadaDecenas").style.backgroundSize="6vw 6vw";
	  				}
	  			if(document.getElementById("decenasCifra1").innerHTML=="0" && document.getElementById("cifraCasillaLlevadaCentenas").innerHTML!=""){
	  				document.getElementById("elunoCentenas").style.visibility=="visible";
	  				document.getElementById("cifraCasillaLlevadaDecenas").innerHTML = ""+9;
	  				document.getElementById("unidadesCifra1").style.cursor="pointer";
	  			}	
	  		}
	  		if(assistanceMode){
	  			if(obj.id=="centenasCifra1" || obj.id=="tachadaCentenas" || obj.id=="casillaLlevadaCentenas"){
		  			var numero = parseInt(document.getElementById('centenasCifra1').innerHTML, 10) - 1;
		  			document.getElementById("cifraCasillaLlevadaCentenas").innerHTML = ""+numero;
		  			document.getElementById("elunoCentenas").style.visibility="visible";
		  			document.getElementById('decenasCifra1').style.cursor="pointer";
		  			
		  			
	  			} else if(obj.id=="decenasCifra1" || obj.id=="tachadaDecenas" || obj.id=="casillaLlevadaDecenas"){
	  				if(document.getElementById("decenasCifra1").innerHTML=="0" && document.getElementById("cifraCasillaLlevadaCentenas").innerHTML=="")
	  					return;
	  				var numero = parseInt(document.getElementById('decenasCifra1').innerHTML, 10);
	  				if (numero==0) 
	  					numero=9; 
	  				else 
	  					numero = numero-1;
		  			document.getElementById("cifraCasillaLlevadaDecenas").innerHTML = ""+numero;
		  			document.getElementById("elunoDecenas").style.visibility="visible";
		  			
	  			}
	  		} else{
	  			if(obj.id=="centenasCifra1" || obj.id=="tachadaCentenas" || obj.id=="casillaLlevadaCentenas"){
		  			setSelected("casillaLlevadaCentenas");
	  			}else if(obj.id=="decenasCifra1" || obj.id=="tachadaDecenas" || obj.id=="casillaLlevadaDecenas"){
	  				if(document.getElementById("decenasCifra1").innerHTML!="0")
		  				setSelected("casillaLlevadaDecenas");
	  			}
	  		}
	  	}
  	}
  	
  	function setOneUnidades(){
  		if(assistance){
  			if(document.getElementById("cifraCasillaLlevadaDecenas").innerHTML != ""){
				document.getElementById("elunoDecenas").style.visibility="visible";
				document.getElementById("unidadesCifra1").style.cursor="default";
  			}
  		}
  	}
	  
  </script>
</head>

  <body onload="javascript:calcularSuma();iniciarCrono()" onkeypress="javascript:ponerNumero(event)" onkeydown="javascript:borrarNumero(event)">

	<div id="contenedor" class="unselectable" style="position:absolute;width:99vw">
			
			<!-- CAPA DE ARRIBA: MARCADOR, RECUADRO DE SUMA, BOTÓN DE CERRAR Y VOLVER AL MENU PRINCIPAL-->
			<div style="position:absolute;width:16.17vw;height:20vw;background-image:url(marcador.png);background-repeat:no-repeat;background-size:16.15vw 19.15vw;text-align:center">
				<div style="width:16.15vw;position:absolute">
						<label style="color:white;font-family:BerlinDemi;font-size:3.2vw;">LEVEL&nbsp;</label><label id="nivel" style="color:white;font-family:BerlinDemi;font-size:4.5vw;"><%=nivel%></label>
				</div>
				
				<div style="width:16.15vw;position:absolute;top:4vw">
						<label id="indicadorSumas" style="color:rgb(99, 43, 141);font-family:Times New Roman;font-size:6.3vw;font-weight:bold">0/<%=sumasNecesarias%></label>
				</div>
				<div style="width:16.15vw;position:absolute;top:13.5vw">
						<label id="minutero" style="color:black;font-size:4.4vw;font-family:digital7mono">00:00</label>
				</div>
			</div>
				
			<div style="position:absolute;left:22.45vw;width:34.5vw;height:34.5vw;background-size:34.5vw 33.5vw;background-image:url(cuadroResta3.png);background-repeat:no-repeat">
				<!--CASILLAS LLEVADA -->
				<div style="width:62vw;left:11.5vw;position:absolute;top:1vw">
					<div id="casillaLlevadaCentenas" onclick="javascript:initAssistance(this)" style="position:absolute;cursor:pointer;background-image:url(casillaLlevada.png);background-repeat:no-repeat;background-size:2.1vw 3.1vw;width:2.1vw;height:3.1vw">
							<label id="cifraCasillaLlevadaCentenas" style="position:absolute;cursor:pointer;left:0.15vw;top:-0.6vw;font-family:Calibri;font-size:3.5vw;font-weight:bold;font-color:black"></label>
					</div>
					<div id="casillaLlevadaDecenas" onclick="javascript:initAssistance(this)" style="position:absolute;cursor:pointer;left:7.1vw;background-image:url(casillaLlevada.png);background-repeat:no-repeat;background-size:2.1vw 3.1vw;width:2.1vw;height:3.1vw">
							<label id="cifraCasillaLlevadaDecenas" style="position:absolute;left:0.15vw;top:-0.6vw;cursor:pointer;font-family:Calibri;font-size:3.5vw;font-weight:bold;font-color:black"></label>
					</div>
				</div>
					
				<!--PRIMER OPERADOR  -->
				<div style="width:62vw;left:10vw;position:absolute;bottom:31.5vw">
							
							<label id="centenasCifra1" onclick="javascript:initAssistance(this)" style="cursor:pointer;position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
							
							<div id="tachadaCentenas" onclick="javascript:initAssistance(this)" style="position:absolute;left:0.2vw;top:3.5vw;width:5vw;height:7vw;cursor:pointer;background-image:url(tacha.png);background-size:6vw 7.5vw;background-repeat:no-repeat;font-family:Calibri"></div>
							<label id="elunoCentenas" style="position:absolute;left:5vw;top:1.7vw;font-family:Calibri;font-size:5vw;font-weight:bold;font-color:black;visibility:hidden">1</label>
							
							<label id="decenasCifra1" onclick="javascript:initAssistance(this)" style="position:absolute;width:6vw;height:6.5vw;left:7.1vw;cursor:pointer;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black" onclick="javascript:initAssistance()">&nbsp;</label>
							<div id="tachadaDecenas" onclick="javascript:initAssistance(this)" style="left:7.3vw;position:absolute;top:3.5vw;width:5vw;height:7vw;cursor:pointer;background-image:url(tacha.png);background-size:6vw 7.5vw;background-repeat:no-repeat;font-family:Calibri"></div>
							<label id="elunoDecenas" style="position:absolute;left:12.1vw;top:1.7vw;font-family:Calibri;font-size:5vw;font-weight:bold;font-color:black;visibility:hidden">1</label>
							
							<label id="unidadesCifra1" style="position:absolute;width:6vw;height:6.5vw;left:14.2vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black" onclick="javascript:setOneUnidades(this)">&nbsp;</label>
				</div>	
					
				<!--SEGUNDO OPERADOR  -->
				<div style="width:62vw;left:17.1vw;position:absolute;top:13vw">	 
						<label id="decenasCifra2" style="position:absolute;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
						<label id="unidadesCifra2" style="position:absolute;left:7.1vw;font-family:Calibri;font-size:10vw;font-weight:bold;font-color:black">&nbsp;</label>
				</div>
				
				<!--RESULTADO SUMA -->
				<div style="width:63vw;position:absolute;left:0.5vw;top:24vw">
								
						<a id="sumaCentenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:9.1vw;width:5.2vw;height:7.1vw;top:0.15vw;border:0.3vw solid black;">
								<label id="sumaCentenasCifra" onMouseOver="this.style.cursor='pointer'"	style="position:absolute;bottom:-1.5vw;left:0.3vw;font-family:Calibri;font-size:8.9vw;font-weight:bold;font-color:black"></label>
						</a>
						
					
						<a id="sumaDecenas" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)" 
							style="position:absolute;left:16.2vw;width:5.2vw;height:7.1vw;top:0.15vw;border:0.3vw solid black">
								<label id="sumaDecenasCifra" onMouseOver="this.style.cursor='pointer'" style="position:absolute;bottom:-1.5vw;left:0.3vw;position:absolute;font-family:Calibri;font-size:8.9vw;font-weight:bold;font-color:black"></label>
						</a>
					
						<a id="sumaUnidades" onclick="clickCifraSuma(this)" ondblclick="dobleClickCifraSuma(this)"
							style="position:absolute;left:23.3vw;width:5.2vw;height:7.1vw;top:0.15vw;border:0.3vw solid blue">
								<label id="sumaUnidadesCifra" onMouseOver="this.style.cursor='pointer'"	style="position:absolute;bottom:-1.5vw;left:0.3vw;font-family:Calibri;font-size:8.9vw;font-weight:bold;font-color:black"></label>
						</a>
				</div>
			
			</div>
				
			<div onclick="javascript:location.href='seleccionNivelSubtraction.jsp'" onmouseout="this.style.backgroundImage='url(cerrarAspa.png)'" onmouseover="this.style.backgroundImage='url(cerrarAspaSelect.png)'"
			style="position:absolute;background-size:9.5vw 8.5vw;left:66vw;cursor:pointer;background-image:url(cerrarAspa.png);background-repeat:no-repeat;width:9.5vw;height:8.5vw">
			</div>
				
		   
			
			<!-- CAPAS DE ABAJO: TABLA DE CIFRAS Y BOTON DE CHECK -->
			<div style="position:absolute;width:66vw;height:10vw;background-size:65.5vw 10vw;top:34.25vw;background-image:url(tablaNumeros.png);background-repeat:no-repeat">
				<div id="cero" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:0.46vw;width:6.105vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.6vw;color:black;font-family:Calibri;font-size:9vw">0</a>
				</div>
				<div id="uno" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:6.86vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.7vw;color:black;font-family:Calibri;font-size:9vw">1</a>
				</div>
				<div id="dos" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:13.35vw;width:6.12vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">2</a>
				</div>
				<div id="tres" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:19.85vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">3</a>
				</div>
				<div id="cuatro" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:26.3vw;width:6.12vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">4</a>
				</div>
				<div id="cinco" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:32.85vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">5</a>
				</div>
				<div id="seis" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:39.35vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">6</a>
				</div>
				<div id="siete" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:45.9vw;width:6.11vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">7</a>
				</div>
				<div id="ocho" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:52.33vw;width:6.19vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">8</a>
				</div>
				<div id="nueve" onclick="onClickCifra(this)" style="position:absolute;top:0.468vw;left:58.85vw;width:6.21vw;height:9.175vw">
					<a style="position:absolute;bottom:-0.6vw;left:0.8vw;color:black;font-family:Calibri;font-size:9vw">9</a>
				</div>
			</div>
			<div id="capaBotonCheckSuma" onclick="javascript:this.style.backgroundImage='url(checkBotonClick.png)';setTimeout(comprobarSuma, 320)" 
				style="background-size:13vw 13vw;width:20vw;height:15vw;position:absolute;top:32.3vw;left:66.25vw;cursor:pointer;background-image:url(checkBoton.png);background-repeat:no-repeat">
			</div>
	</div>
  </body>
</html>