<?php 
if(isset($_POST["mshv"]))
{

// defining main variables
	$dbHost = "localhost";
	$dbUser = "root";
	$dbPass = "123456";
	$dbName = "test";
	$dbTable = "taikhoan";
	
	// connecting and selecting database
	@mysql_connect($dbHost, $dbUser, $dbPass) or die(mysql_error());
	@mysql_select_db($dbName) or die(mysql_error());
	mysql_query('SET NAMES UTF8');
	
    date_default_timezone_set('Asia/Ho_Chi_Minh');	
    $mshv=$_POST["mshv"];
 //$pass=md5($_POST["pass"]);

        $last_active=time();
        //echo $num;
    	 $str="UPDATE ".$dbTable." set online='1', active=$last_active where username='".$mshv."'";
         
    	$res = mysql_query($str) or die(mysql_error());
    	echo "success";
}
?>