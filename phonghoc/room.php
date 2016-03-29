<?php
function md5_hmac($data, $key)
{
	$key = str_pad(strlen($key) <= 64 ? $key : pack('H*', md5($key)), 64, chr(0x00));
	return md5(($key ^ str_repeat(chr(0x5c), 64)) . pack('H*', md5(($key ^ str_repeat(chr(0x36), 64)) . $data)));
}
?>

<?php

if(!isset($_POST['name'])||!isset($_POST['room_id']))
{
	header("location: index.php");
}
else
{
	
	$input_host = "rtmp://118.69.55.61:1935";
	$room_id="caohoc";
    $name = $_POST['name'];
	$password = $_POST['pass'];
	
	
	if($password != "12345678"){
		header("location: index.php");
	}
	else
	{
		$flashvar_str="room_id=$room_id&name=$name&input_host=$input_host";
	}
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
            <img id="logo" src="assets/logo.png" />
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
                <object type="application/x-shockwave-flash" data="Main.swf" width="1280" height="800" id="demo">
    					<param name="movie" value="Main.swf" />
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
       
        <!-- 
        <div id="top">            
            <h4 class="scrollingtext">Hệ Thống Đào Tạo Từ Xa - Trường Đại Học Công Nghệ Thông Tin  </h4>					
		</div>--><!-- end #top -->	       
        
    </div><!-- end #wrapper -->


</body>
</html>