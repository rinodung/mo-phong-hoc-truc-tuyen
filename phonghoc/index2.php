<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
	<meta name="author" content="rinodung" />

	<title>Live Room Demo</title>
	<link href="assets/login.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="assets/jquery.min.js"></script>
    <script type="text/javascript" src="assets/jquery-scroller.js"></script>
	<script type="text/javascript" src="assets/vlogin.js"></script>
</head>



<body>
    <div id="wrapper">
		<div id="top">            
				   <h4 class="scrollingtext">Đại Học Quốc Gia Thành Phố Hồ Chí Minh - Trường Đại Học Công Nghệ Thông Tin  </h4>
					
		</div><!-- end #top -->	
        <div id="header">                    
            <img src="assets/logo.png" />
            <div id="banner">
                <p>ĐẠI HỌC QUỐC GIA THÀNH PHỐ HỒ CHÍ MINH</p>
                <p>TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN</p>
                <p>HỆ THỐNG ĐÀO TẠO TRỰC TUYẾN</p>
            </div><!-- end #banner -->           
        
            <div id="menu">
                <ul>
                    <li id="kehoach"><a href="#" class="active">Đăng nhập</a></li>
                    <li id="hd"><a href="#">Hướng Dẫn Chi Tiết</a></li>
                </ul>
            </div><!-- end #menu -->
        </div><!-- end #header -->
        
        
        
        
        <div id="primary">
        <div id="login">    
			<div id="content">
			<fieldset id='dangnhap'>
			<legend>Đăng nhập</legend>
			<table>
			<form id='flogin' action='room2.php' method='post'>		
			<tr>
				<td class="label" style='text-align: right; padding-right: 20px;'>MSHV </td>
				<td style='width:500px;'>
					<input id="name" type='text' name='name' />
				</td>
			</tr>
			
			<tr>
				<td class="label" style='text-align: right; padding-right: 20px;'>Mật khẩu </td>
				<td>
					<input id="pass" type='password' name='pass' />
				</td> 
			</tr>
			<tr><td></td><td style='font-size:12px;'></td></tr>
			<tr><td style='text-align: right; padding-right: 20px; vertical-align: top;'><input type='checkbox' name='rb' id='rb'/></td><td style='font-size:12px; padding-right: 30px;'>Tôi thực hiện luật bản quyền sở hữu trí tuệ của Nhà nước Việt nam và Quốc tế nói chung, cùng với các quy định của Trường ĐH CNTT nói riêng. Tôi không tùy tiện cho sao chép hoặc phát tán các tư liệu bài giảng, cũng như các tài liệu tham khảo mà giảng viên Nhà trường đã cung cấp để phục vụ nhu cầu học tập của tôi. Nếu vi phạm, tôi xin chịu mọi hình phạt của pháp luật và mọi kỹ luật mà Nhà trường đã quy định !</td></tr>
			<tr style='height:0px' >
				<td class="label" style="display:none">Chọn phòng:</td>
				<td style="display:none">
					<select name="room_id">
					<option value="1">Room1</option>
					<option value="2">Room2</option>    
					<option value="3">Room3</option>    
					</select>
				</td>
			</tr>
			</form>
			<tr><td></td><td><button id='submit' >Go</button> <img title='Đang tải' style='display:none' width="16px" height="16px" id='loading' src='assets/loading.gif' /></td></tr>
			<tr><td id='error' colspan='2' style='color:red;'></td></tr>
			</table>
			</fieldset>
			
            
			
			<fieldset id="huongdan">
			<legend>HƯỚNG DẪN CÀI ĐẶT MICROPHONE</legend>			
				<p>- Sau khi đăng nhập, nếu microphone của bạn chưa hoạt động thì chương trình sẽ hiện ra một bảng cài đặt.</p>
				<img src="assets/hd1.jpg">
				<p>- Chọn Microphone, nếu trong khi nói mà thanh bên trái thay đổi lên xuống thì Microphone hoạt động tốt.</p>
				<img src="assets/hd2.jpg">
				<p>- Chọn Close, hiện ra bảng thông báo security, chọn "Allow" và check vào ô "Remember"</p>
				<img src="assets/hd3.jpg">
				<p>- Nhấn "Close" để kết thúc.</p>
			</fieldset>
			</div>
			
           </div><!--end div #login -->    

		   
        </div><!-- end #primary1 -->       
        <div id="footer">
		<div>
    </div><!-- end #wrapper -->


</body>
</html>

