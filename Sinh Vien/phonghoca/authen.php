<?php 
session_start();

if(isset($_POST["mshv"])&&isset($_POST["pass"]))
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
 $pass=$_POST["pass"];
 //$str="SELECT count(username) as num FROM ".$dbTable." where username='".$mshv."' and password=md5('".$pass."')";
 //$res = mysql_query($str) or die(mysql_error());
 $num=0;
 if($pass == '12345678')
 {
	$num= 1;
 }
// $num = mysql_result($res, 0, 0);
//CH1201150 : 20041979
//CH1201091 : 03121988
//CH1201001 : 04061983
//09730049  :  19031989

 if($num>0)//pass
 {
	if(is_online($mshv)==true)
    {	
        echo "online";
    }
    else
    {
        $last_active=time();
    	$str="UPDATE ".$dbTable." set online='1', active=$last_active where username='".$mshv."'";
		$_SESSION['user'] = $mshv;
    	$res = mysql_query($str) or die(mysql_error());
		
		$str="SELECT type FROM ".$dbTable." where username='".$mshv."'";
		$res = mysql_query($str) or die(mysql_error());
		$num = mysql_result($res, 0, 0);
		if($num == 1)
			$_SESSION['room'] = 'caohoc';
		else
			$_SESSION['room'] = 'tuxa';
    	echo "success";	
    }
	
 } //wrong
 else echo "invalid";
}
else
{
	echo "error ".$str;
}



function is_online($mshv)
{
     $dbTable = "taikhoan";
     $str="SELECT online FROM ".$dbTable." where username='".$mshv."'";
     $res = mysql_query($str) or die(mysql_error());
     $num = mysql_result($res, 0, 0);
	 if(!$num)
		return 0;	
		
     $str="SELECT active FROM ".$dbTable." where username='".$mshv."'";
     $res = mysql_query($str) or die(mysql_error());
     $last_active = mysql_result($res, 0, 0);
     $time=time();
	 if(($last_active+60)<$time)
     {
        $str="UPDATE ".$dbTable." set online=0 where username='".$mshv."'";
		return 0;
     }
	 return 1;
}
?>