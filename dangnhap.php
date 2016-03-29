<?php 
$str = "hello";
$dbHost = "localhost";
$dbUser = "root";
$dbPass = "";
$dbName = "hoc_vien";
$dbTable = "users";
if(isset($_GET["username"])&&isset($_GET["password"]))
{
//$str = "ok";
// defining main variables
	
	
// connecting and selecting database
@mysql_connect($dbHost, $dbUser, $dbPass) or die(mysql_error());
@mysql_select_db($dbName) or die(mysql_error());
mysql_query('SET NAMES UTF8');	
date_default_timezone_set('Asia/Ho_Chi_Minh');	

$username=$_POST["username"];
 
$password=$_POST["password"];
$result = login($username, $password);

if($result == true) {
	echo "success";
} else {
	echo "fail";
}

}
else
{
	echo $str;
}

function login($username, $password) {
	$result =false;
	$str="SELECT online FROM " . $dbTable . " where username='" . $username . "' and password='". $password . "'";
    $res = mysql_query($str) or die(mysql_error());
    $num = mysql_result($res, 0, 0);
	if($num>0) {
		 $result = true;
	}
	return $result;
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