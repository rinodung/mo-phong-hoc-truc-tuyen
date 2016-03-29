<?php
session_start();
if(!isset($_POST['name'])||!isset($_POST['room_id']))
{
	header("location: index.php");
}
else
{
	
	$room_id=$_SESSION['room'];
    $name=$_POST['name'];
	
	$dbHost = "localhost";
	$dbUser = "root";
	$dbPass = "";
	$dbName = "test";
	$dbTable = "taikhoan";	
	// connecting and selecting database
	@mysql_connect($dbHost, $dbUser, $dbPass) or die(mysql_error());
	@mysql_select_db($dbName) or die(mysql_error());
	mysql_query('SET NAMES UTF8');
	$str="SELECT hoten FROM ".$dbTable." where username='$name'";
	$res = mysql_query($str) or die(mysql_error());
	$ten = mysql_result($res, 0, 0);
    
    $flashvar_str="room_id=$room_id&name=$ten";
	//echo $flashvar_str;
}

 ?>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
	<meta name="author" content="rinodung" />

	<title>Live Room Demo</title>
	<link href="assets/room.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="assets/jquery.min.js"></script>
    <script type="text/javascript" src="assets/jquery-scroller.js"></script>
	<script type="text/javascript" src="assets/jroom.js"></script>
</head>
<body>
    <div id="wrapper">
		 <div id="header">                    
            <img src="assets/logo.png" />
            <div id="banner">
                <p>ĐẠI HỌC QUỐC GIA THÀNH PHỐ HỒ CHÍ MINH</p>
                <p>TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN</p>
                <p>HỆ THỐNG ĐÀO TẠO TRỰC TUYẾN</p>
            </div><!-- end #banner -->
			<div id="menu">
				<ul>
					<li id="kehoach"><a href="logout.php?name=<?php echo $name; ?>" class="active">Thoát</a></li>
				</ul>
			</div>
        </div><!-- end #header -->
		
        <div id="primary">
            <div id="flashcontent">                      
                <object type="application/x-shockwave-flash" data="Main1.swf" width="1230" height="600" id="demo">
    					<param name="movie" value="Main1.swf" />
    					<param name="quality" value="high" />
    					<param name="bgcolor" value="#ffffff" />
    					<param name="play" value="true" />
    					<param name="loop" value="true" />
    					<param name="wmode" value="window" />
    					<param name="scale" value="showall" />
    					<param name="menu" value="true" />
    					<param name="devicefont" value="false" />
    					<param name="salign" value="" />
    					<param name="allowScriptAccess" value="sameDomain" />
    					<param name="FlashVars" value="<?php echo $flashvar_str; ?>" />
    					
    				<!--<![endif]-->
    					
    				<!--[if !IE]>-->
    				</object>
            </div><!--end #flashcontent -->
            
            
                       
        </div><!-- end #primary1 -->
        <span id="info" style="display:none"  ><?php echo $name ?></span>
        <span id="username" style="display:none" ><?php echo $name ?></span>
        <div id="header">                    
        </div><!-- end #header -->
        <!-- 
        <div id="top">            
            <h4 class="scrollingtext">Hệ Thống Đào Tạo Từ Xa - Trường Đại Học Công Nghệ Thông Tin  </h4>					
		</div>--><!-- end #top -->	       
        
    </div><!-- end #wrapper -->


</body>
</html>