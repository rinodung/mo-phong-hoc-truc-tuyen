$(document).ready(function()
{	
	
	$("input#name").focus();
	$("#linklogin p").click(function(e)
	{
		openPopup();
	});
	
	$("#popup").click(function(e)
	{
		closePopup();
	});
    $("#formlogin img#close").click(function(e)
	{
		closePopup();
	});
	
	 $('*').keypress(function(e){

        if(e.keyCode=='27')
		{
			closePopup();
        }
		if(e.keyCode=='13')
		{
		
			$("#submit").click();
			return false;
		}

    });
	
	function openPopup()
	{
		$("#popup").show();
		$("#formlogin").show();
	}
	
	function closePopup()
	{
		$("#popup").hide();
		$("#formlogin").hide();
	}
    
     $("#wrapper #top").SetScroller({	velocity: 	 30,
											direction: 	 'horizontal',
											startfrom: 	 'left',
											loop:		 'infinite',
											movetype: 	 'pingpong',
											onmouseover: 'pause',
											onmouseout:  'play',
											onstartup: 	 'play',
											cursor: 	 'pointer'
										});	
	 $("#submit").click(function(event)
     {
        var mshv=$("#name").val();
		var pass=$("#pass").val();
		if(!$("#rb").is(':checked'))
		{
			alert("Bạn cần chấp nhận điều kiện về bản quyền.");
			return;
		}
        if(mshv=="")
        {
            alert("Vui lòng điền Mã Số Học Viên(MSHV)");
            $("input#name").focus();
			return;
        }
		else if(pass=="")
		{
			alert("Vui lòng điền mật khẩu là 12345678");
            $("input#pass").focus();
			return;
		}
		else if(pass=="12345678")
		{
			$("#flogin").submit();
		}
		else
		{									
            alert("Tài khoản không hợp lệ. Vui lòng kiểm tra và đăng nhập lại");	
			return;
		}
		
			
	});//end elfe
		 

	
});