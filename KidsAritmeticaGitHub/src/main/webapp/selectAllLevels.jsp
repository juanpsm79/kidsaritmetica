<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PlayAddition</title>
  <style type="text/css">
  	@font-face{
	 	font-family:'BerlinDemi';
 		src: url('BerlinDemi.ttf');
	}
  </style>
  <script src="./js/jquery/jquery-3.3.1.js"></script>
  <script src="./js/jquery.flip.min.js"></script>
  <script>
 	var nivel
 	function selectNivel(nivel){
 		if(window.opener!=null) {
 			window.opener.callback(nivel);
 			window.close();
 		}else{
 			$.ajax({
 				  url: "/hello",
 				  method: "post",
 				  data:{nivel: ''+nivel},
 				 // dataType: "json",
 				  success : function(responseText) {
 						location.href = "descripcionNivel.jsp";
 				  }
 				});
 		}
 	}
  </script>
</head>

  <body>
  
  	<div style="width:80vw;position:absolute;left:10vw">
  		<img src="seeAllLevels.png" style="width:80vw"/>
  		<a onclick="selectNivel(1)" style="cursor:pointer;position:absolute;top:27.3vw;left:31.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 1</a>
		<a onclick="selectNivel(2)" style="cursor:pointer;position:absolute;top:30.9vw;left:33.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 2</a>
		<a onclick="selectNivel(3)" style="cursor:pointer;position:absolute;top:34.35vw;left:35.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 3</a>
		<a onclick="selectNivel(4)" style="cursor:pointer;position:absolute;top:37.85vw;left:37.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 4</a>
		
		
		
		<a onclick="selectNivel(5)" style="cursor:pointer;position:absolute;top:41.35vw;left:39.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 5</a>
		<a onclick="selectNivel(6)" style="cursor:pointer;position:absolute;top:44.95vw;left:38.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 6</a>
		<a onclick="selectNivel(7)" style="cursor:pointer;position:absolute;top:48.45vw;left:40.3vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 7</a>
		<a onclick="selectNivel(8)" style="cursor:pointer;position:absolute;top:52.05vw;left:42vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 8</a>
		<a onclick="selectNivel(9)" style="cursor:pointer;position:absolute;top:55.54vw;left:44.2vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 9</a>
		<a onclick="selectNivel(10)" style="cursor:pointer;position:absolute;top:59.11vw;left:46.6vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 10</a>
		<a onclick="selectNivel(11)" style="cursor:pointer;position:absolute;top:62.72vw;left:41.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 11</a>
		
		
		
		<a onclick="selectNivel(12)" style="cursor:pointer;position:absolute;top:73.9vw;left:46.1vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 12</a>
		<a onclick="selectNivel(13)" style="cursor:pointer;position:absolute;top:77.47vw;left:44vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 13</a>
		
		 
		
		<a onclick="selectNivel(14)" style="cursor:pointer;position:absolute;top:99.15vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 14</a>
		<a onclick="selectNivel(15)" style="cursor:pointer;position:absolute;top:102.65vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 15</a>
		<a onclick="selectNivel(16)" style="cursor:pointer;position:absolute;top:106.25vw;left:46vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 16</a>
		<a onclick="selectNivel(17)" style="cursor:pointer;position:absolute;top:109.8vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 17</a>
		
		
		
		
		<a onclick="selectNivel(18)" style="cursor:pointer;position:absolute;top:119.4vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 18</a>
		<a onclick="selectNivel(19)" style="cursor:pointer;position:absolute;top:122.88vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 19</a>
		<a onclick="selectNivel(20)" style="cursor:pointer;position:absolute;top:126.5vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 20</a>
		<a onclick="selectNivel(21)" style="cursor:pointer;position:absolute;top:130.15vw;left:46vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 21</a>
		<a onclick="selectNivel(22)" style="cursor:pointer;position:absolute;top:133.75vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 22</a>
		
		
		
		<a onclick="selectNivel(23)" style="cursor:pointer;position:absolute;top:152vw;left:35vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 23</a>
		<a onclick="selectNivel(24)" style="cursor:pointer;position:absolute;top:155.45vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 24</a>
		<a onclick="selectNivel(25)" style="cursor:pointer;position:absolute;top:159.05vw;left:44.8vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 25</a>
		
		
		
		<a onclick="selectNivel(26)" style="cursor:pointer;position:absolute;top:166.85vw;left:36vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 26</a>
		<a onclick="selectNivel(27)" style="cursor:pointer;position:absolute;top:170.25vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 27</a>
		<a onclick="selectNivel(28)" style="cursor:pointer;position:absolute;top:174vw;left:39.1vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 28</a>
		<a onclick="selectNivel(29)" style="cursor:pointer;position:absolute;top:177.5vw;left:46.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 29</a>
		<a onclick="selectNivel(30)" style="cursor:pointer;position:absolute;top:181vw;left:50.1vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 30</a>
		<a onclick="selectNivel(31)" style="cursor:pointer;position:absolute;top:184.7vw;left:55.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 31</a>
		<a onclick="selectNivel(32)" style="cursor:pointer;position:absolute;top:188.15vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 32</a>
		
		
		
		<a onclick="selectNivel(33)" style="cursor:pointer;position:absolute;top:195.5vw;left:36vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 33</a>
		<a onclick="selectNivel(34)" style="cursor:pointer;position:absolute;top:198.8vw;left:39vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 34</a>
		<a onclick="selectNivel(35)" style="cursor:pointer;position:absolute;top:202.52vw;left:39.1vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 35</a>
		<a onclick="selectNivel(36)" style="cursor:pointer;position:absolute;top:206.03vw;left:46.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 36</a>
		<a onclick="selectNivel(37)" style="cursor:pointer;position:absolute;top:209.41vw;left:50.1vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 37</a>
		<a onclick="selectNivel(38)" style="cursor:pointer;position:absolute;top:212.99vw;left:49.81vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 38</a>
		<a onclick="selectNivel(39)" style="cursor:pointer;position:absolute;top:216.56vw;left:55.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 39</a>
		<a onclick="selectNivel(40)" style="cursor:pointer;position:absolute;top:219.99vw;left:42.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 40</a>
		
		
		
  	</div>
  	<!--  
		<div style="position:absolute;top:1.25vw;left:6.25vw;width:75.3vw;height:43.3vw;background-image:url(sal1.png);background-repeat:no-repeat">
			<div style="position:absolute;top:22.2vw;left:30.9vw">
				<a onclick="selectNivel(1)" style="cursor:pointer;position:absolute;top:6.25vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 1</a>
				<a onclick="selectNivel(2)" style="cursor:pointer;position:absolute;top:10.18vw;right:12.18vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 2</a>
				<a onclick="selectNivel(3)" style="cursor:pointer;position:absolute;top:13.93vw;right:23.75vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 3</a>
				<a onclick="selectNivel(4)" style="cursor:pointer;position:absolute;top:17.75vw;right:35.31vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 4</a>
			</div>
 		</div>
		<div style="position:absolute;top:2.5vw;left:6.25vw;width:74.75vw;height:43.25vw;background-image:url(sal2.png);background-repeat:no-repeat">
			<div style="position:absolute;left:34.06vw">
				<a onclick="selectNivel(5)" style="cursor:pointer;position:absolute;bottom:0.62vw;left:5.62vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 5</a>
				<a onclick="selectNivel(6)" style="cursor:pointer;position:absolute;top:3.28vw;right:10vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 6</a>
				<a onclick="selectNivel(7)" style="cursor:pointer;position:absolute;top:7vw;right:20.93vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 7</a>
				<a onclick="selectNivel(8)" style="cursor:pointer;position:absolute;top:10.93vw;right:32.81vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 8</a>
				<a onclick="selectNivel(9)" style="cursor:pointer;position:absolute;top:14.8vw;right:44.68vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 9</a>
				<div style="z-index:10"><a onclick="selectNivel(10)" style="cursor:pointer;position:absolute;top:15.81vw;left:13.12vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 10</a></div>
				<a onclick="selectNivel(11)" style="cursor:pointer;position:absolute;top:16.87vw;left:7.81vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 11</a>
				<a onclick="selectNivel(12)" style="cursor:pointer;position:absolute;top:29.12vw;right:2.18vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 12</a>
				<a onclick="selectNivel(13)" style="cursor:pointer;position:absolute;top:32.93vw;right:19.06vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 13</a>
			</div>
		</div>
		<div style="position:absolute;top:6.25vw;left:6.25vw;width:75.06vw;height:37.5vw;background-image:url(sal3.png);background-repeat:no-repeat">
			<div style="position:absolute;top:8.81vw;left:35vw">
				<a onclick="selectNivel(14)" style="cursor:pointer;position:absolute;top:6.25vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 14</a>
				<a onclick="selectNivel(15)" style="cursor:pointer;position:absolute;top:10.06vw;right:11.06vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 15</a>
				<a onclick="selectNivel(16)" style="cursor:pointer;position:absolute;top:13.93vw;right:18.43vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 16</a>
				<a onclick="selectNivel(17)" style="cursor:pointer;position:absolute;top:17.81vw;right:37.31vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 17</a>
			</div>
		</div>
		<div style="position:absolute;top:1.25vw;left:6.25vw;width:75.75vw;height:24.56vw;background-image:url(sal4.png);background-repeat:no-repeat">
			<div style="position:absolute;top:4.68vw;left:31.25vw">
				<a onclick="selectNivel(18)" style="cursor:pointer;position:absolute;left:4.37vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 18</a>
				<a onclick="selectNivel(19)" style="cursor:pointer;position:absolute;top:3.81vw;right:7.37vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 19</a>
				<a onclick="selectNivel(20)" style="cursor:pointer;position:absolute;top:7.68vw;right:22.18vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 20</a>
				<a onclick="selectNivel(21)" style="cursor:pointer;position:absolute;top:11.62vw;right:28.87vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 21</a>
				<a onclick="selectNivel(22)" style="cursor:pointer;position:absolute;top:15.43vw;right:48.25vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 22</a>
			</div>
		</div>
		<div style="position:absolute;top:1.25vw;left:6.25vw;width:76.12vw;height:27.31vw;background-image:url(sal5.png);background-repeat:no-repeat">
			<div style="position:absolute;top:15.43vw;left:31.25vw">
				<a onclick="selectNivel(23)" style="cursor:pointer;position:absolute;left:4.37vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 23</a>
				<a onclick="selectNivel(24)" style="cursor:pointer;position:absolute;top:3.81vw;right:7.25vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 24</a>
				<a onclick="selectNivel(25)" style="cursor:pointer;position:absolute;top:7.68vw;right:15.93vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 25</a>
			</div>
		</div>
		<div style="position:absolute;top:1.25vw;left:6.25vw;width:75.35vw;height:30.56vw;background-image:url(sal6.png);background-repeat:no-repeat">
			<div style="position:absolute;top:4.87vw;left:29.68vw">
				<a onclick="selectNivel(26)" style="cursor:pointer;position:absolute;bottom:0.62;left:5.62vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 26</a>
				<a onclick="selectNivel(27)" style="cursor:pointer;position:absolute;top:3.25vw;right:6.25vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 27</a>
				<a onclick="selectNivel(28)" style="cursor:pointer;position:absolute;top:7.12vw;right:20.93vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 28</a>
				<a onclick="selectNivel(29)" style="cursor:pointer;position:absolute;top:10.93vw;right:28.12vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 29</a>
				<a onclick="selectNivel(30)" style="cursor:pointer;position:absolute;top:14.81vw;right:38.43vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 30</a>
				<div style="z-index:10"><a onclick="selectNivel(31)" style="cursor:pointer;position:absolute;top:15.93vw;left:26.56vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 31</a></div>
				<a onclick="selectNivel(32)" style="cursor:pointer;position:absolute;top:17.06vw;left:12.81vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 32</a>
			</div>
		</div>
		<div style="position:absolute;top:1.25vw;left:6.25vw;width:75.06vw;height:34.75vw;background-image:url(sal7.png);background-repeat:no-repeat">
			<div style="position:absolute;top:5.18vw;left:29.5vw">
				<a onclick="selectNivel(33)" style="cursor:pointer;position:absolute;bottom:0.62vw;left:5.62vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 33</a>
				<a onclick="selectNivel(34)" style="cursor:pointer;position:absolute;top:3.25vw;right:5.87vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 34</a>
				<a onclick="selectNivel(35)" style="cursor:pointer;position:absolute;top:7.12vw;right:20.81vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 35</a>
				<a onclick="selectNivel(36)" style="cursor:pointer;position:absolute;top:10.93vw;right:27.62vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 36</a>
				<a onclick="selectNivel(37)" style="cursor:pointer;position:absolute;top:14.81vw;right:38vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 37</a>
				<div style="z-index:10"><a onclick="selectNivel(38)" style="cursor:pointer;position:absolute;top:16vw;left:21.5vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 38</a></div>
				<a onclick="selectNivel(39)" style="cursor:pointer;position:absolute;top:17.06vw;left:26.68vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 39</a>
				<a onclick="selectNivel(40)" style="cursor:pointer;position:absolute;top:20.87vw;right:1.68vw;font-family:Calibri;font-size:2.25vw;color:red">GO TO LEVEL 40</a>
			</div>
		</div>
		
		-->
  </body>
</html>