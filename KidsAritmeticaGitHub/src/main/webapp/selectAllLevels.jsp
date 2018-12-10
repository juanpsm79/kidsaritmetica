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
 		window.opener.callback(nivel);
 		window.close();
 	}
  </script>
</head>

  <body style="height:100%">
		<div style="position:relative;top:20px;left:98px;width:1206px;height:694px;background-image:url(sal1.png);background-repeat:no-repeat">
			<div style="position:relative;top:356px;left:495px">
				<a onclick="selectNivel(1)" style="cursor:pointer;position:relative;top:100px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 1</a>
				<a onclick="selectNivel(2)" style="cursor:pointer;position:relative;top:163px;right:195px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 2</a>
				<a onclick="selectNivel(3)" style="cursor:pointer;position:relative;top:223px;right:380px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 3</a>
				<a onclick="selectNivel(4)" style="cursor:pointer;position:relative;top:284px;right:565px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 4</a>
			</div>
 		</div>
		<div style="position:relative;top:40px;left:100px;width:1196px;height:692px;background-image:url(sal2.png);background-repeat:no-repeat">
			<div style="position:relative;left:545px">
				<a onclick="selectNivel(5)" style="cursor:pointer;position:relative;bottom:10px;left:90px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 5</a>
				<a onclick="selectNivel(6)" style="cursor:pointer;position:relative;top:51px;right:150px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 6</a>
				<a onclick="selectNivel(7)" style="cursor:pointer;position:relative;top:112px;right:335px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 7</a>
				<a onclick="selectNivel(8)" style="cursor:pointer;position:relative;top:175px;right:525px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 8</a>
				<a onclick="selectNivel(9)" style="cursor:pointer;position:relative;top:236px;right:715px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 9</a>
				<div style="z-index:10"><a onclick="selectNivel(10)" style="cursor:pointer;position:relative;top:253px;left:210px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 10</a></div>
				<a onclick="selectNivel(11)" style="cursor:pointer;position:relative;top:270px;left:125px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 11</a>
				<a onclick="selectNivel(12)" style="cursor:pointer;position:relative;top:466px;right:35px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 12</a>
				<a onclick="selectNivel(13)" style="cursor:pointer;position:relative;top:527px;right:305px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 13</a>
			</div>
		</div>
		<div style="position:relative;top:100px;left:100px;width:1201px;height:600px;background-image:url(sal3.png);background-repeat:no-repeat">
			<div style="position:relative;top:141px;left:560px">
				<a onclick="selectNivel(14)" style="cursor:pointer;position:relative;top:100px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 14</a>
				<a onclick="selectNivel(15)" style="cursor:pointer;position:relative;top:161px;right:177px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 15</a>
				<a onclick="selectNivel(16)" style="cursor:pointer;position:relative;top:223px;right:295px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 16</a>
				<a onclick="selectNivel(17)" style="cursor:pointer;position:relative;top:285px;right:597px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 17</a>
			</div>
		</div>
		<div style="position:relative;top:20px;left:100px;width:1212px;height:393px;background-image:url(sal4.png);background-repeat:no-repeat">
			<div style="position:relative;top:75px;left:500px">
				<a onclick="selectNivel(18)" style="cursor:pointer;position:relative;left:70px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 18</a>
				<a onclick="selectNivel(19)" style="cursor:pointer;position:relative;top:61px;right:118px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 19</a>
				<a onclick="selectNivel(20)" style="cursor:pointer;position:relative;top:123px;right:355px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 20</a>
				<a onclick="selectNivel(21)" style="cursor:pointer;position:relative;top:186px;right:462px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 21</a>
				<a onclick="selectNivel(22)" style="cursor:pointer;position:relative;top:247px;right:772px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 22</a>
			</div>
		</div>
		<div style="position:relative;top:20px;left:98px;width:1218px;height:437px;background-image:url(sal5.png);background-repeat:no-repeat">
			<div style="position:relative;top:247px;left:500px">
				<a onclick="selectNivel(23)" style="cursor:pointer;position:relative;left:70px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 23</a>
				<a onclick="selectNivel(24)" style="cursor:pointer;position:relative;top:61px;right:116px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 24</a>
				<a onclick="selectNivel(25)" style="cursor:pointer;position:relative;top:123px;right:255px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 25</a>
			</div>
		</div>
		<div style="position:relative;top:20px;left:98px;width:1206px;height:489px;background-image:url(sal6.png);background-repeat:no-repeat">
			<div style="position:relative;top:78px;left:475px">
				<a onclick="selectNivel(26)" style="cursor:pointer;position:relative;bottom:10px;left:90px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 26</a>
				<a onclick="selectNivel(27)" style="cursor:pointer;position:relative;top:52px;right:105px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 27</a>
				<a onclick="selectNivel(28)" style="cursor:pointer;position:relative;top:114px;right:335px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 28</a>
				<a onclick="selectNivel(29)" style="cursor:pointer;position:relative;top:175px;right:450px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 29</a>
				<a onclick="selectNivel(30)" style="cursor:pointer;position:relative;top:237px;right:615px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 30</a>
				<div style="z-index:10"><a onclick="selectNivel(31)" style="cursor:pointer;position:relative;top:255px;left:425px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 31</a></div>
				<a onclick="selectNivel(32)" style="cursor:pointer;position:relative;top:273px;left:205px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 32</a>
			</div>
		</div>
		<div style="position:relative;top:20px;left:98px;width:1201px;height:556px;background-image:url(sal7.png);background-repeat:no-repeat">
			<div style="position:relative;top:83px;left:472px">
				<a onclick="selectNivel(33)" style="cursor:pointer;position:relative;bottom:10px;left:90px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 33</a>
				<a onclick="selectNivel(34)" style="cursor:pointer;position:relative;top:52px;right:94px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 34</a>
				<a onclick="selectNivel(35)" style="cursor:pointer;position:relative;top:114px;right:333px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 35</a>
				<a onclick="selectNivel(36)" style="cursor:pointer;position:relative;top:175px;right:442px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 36</a>
				<a onclick="selectNivel(37)" style="cursor:pointer;position:relative;top:237px;right:608px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 37</a>
				<div style="z-index:10"><a onclick="selectNivel(38)" style="cursor:pointer;position:relative;top:255px;left:342px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 38</a></div>
				<a onclick="selectNivel(39)" style="cursor:pointer;position:relative;top:273px;left:427px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 39</a>
				<a onclick="selectNivel(40)" style="cursor:pointer;position:relative;top:334px;right:27px;font-family:Calibri;font-size:36px;color:red">GO TO LEVEL 40</a>
			</div>
		</div>
  </body>
</html>