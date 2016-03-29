<?php

	session_start();
	$dbHost = "localhost";
	$dbUser = "root";
	$dbPass = "123456";
	$dbName = "test";
	$dbTable = "taikhoan";
	$user = $_SESSION['user'];
	unset($_SESSION['user']);
	
	// connecting and selecting database
	@mysql_connect($dbHost, $dbUser, $dbPass) or die(mysql_error());
	@mysql_select_db($dbName) or die(mysql_error());
	mysql_query('SET NAMES UTF8');	
    $str="UPDATE ".$dbTable." set online='0' where username='$user'";
    $res = mysql_query($str) or die(mysql_error());
	
	header("location: index.php");

?>