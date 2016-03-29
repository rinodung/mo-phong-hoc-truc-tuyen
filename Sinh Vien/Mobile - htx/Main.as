/*
	This is version for android mobile. 
	Each student is authorized by account from htx (the manage studying system).
	
	After login, panel will show the subject in that day.
*/
package
{
	import com.bit101.components.*;
	import fl.controls.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.events.SyncEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.H264Level;
	import flash.media.H264Profile;
	import flash.media.H264VideoStreamSettings;
	import flash.media.ID3Info;
	import flash.media.Microphone;
	import flash.media.MicrophoneEnhancedMode;
	import flash.media.MicrophoneEnhancedOptions;
	import flash.media.SoundCodec;
	import flash.media.Video;
	import flash.net.*;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.Security;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.geom.Rectangle; 
	
	import flashx.textLayout.factory.StringTextLineFactory;
	
	import red5.*;
	import mx.core.FlexBitmap;
	
	
	public class Main extends MovieClip
	{		
		// Content var
		public var nc:NetConnection;
		public var input_chat:fl.controls.TextInput;	
		public var status_a:fl.controls.Label;
		public var lbl_online_list:fl.controls.Label;
		public var total_ol:fl.controls.Label;
		public var lbl_mic:fl.controls.Label;
		public var room_info:fl.controls.Label;
		public var room_info1:fl.controls.Button;
		public var btn_login:fl.controls.Button;
		public var btn_send:fl.controls.Button;
		public var btn_vote:MovieClip;
		public var btn_back:fl.controls.Button;
		public var btn_chat_switch:fl.controls.Button;
		public var btn_NetConnect:MovieClip;
		public var ta_chat:fl.controls.TextArea;
		public var input_username:fl.controls.TextInput;
		public var input_password:fl.controls.TextInput;
		public var input_info:fl.controls.TextArea;
		private var mc1:MovieClip ;
		public var cbb_He:fl.controls.ComboBox;
		public var ta_classinfo:fl.controls.TextArea;
		
		// Video  var
		private var ns_playback:NetStream;
		private var ns_voteback:NetStream;
		private var video_playback:Video;
		private var video_voteback:Video;
		private var mic:Microphone;
		//SharedObject
		public var so_ol:SharedObject;
		private var loader:URLLoader;
		
		//List var
		public var grid_online:DataGrid;
		public var textformat1: TextFormat;
		//info
		public var room_id:String;
		public var khoa:String;
		public var name_client:String;
		public var address_client:String;
		public var type_client:String;
		public var masv:String;
		public var input_host:String;
		public var username:String;
		public var password:String;
		public var tenhv:String;
		public var port:String;
		public var dem:int;
		
		public var tenMH:String;
		//list
		
		
		
		public function Main()
		{
			this.input_username = fl.controls.TextInput(this.getChildByName("input_tengv"));
			this.input_password = fl.controls.TextInput(this.getChildByName("input_lop"));
			this.input_info = fl.controls.TextArea(this.getChildByName("input_info"));
			this.btn_login = fl.controls.Button(this.getChildByName("btn_login"));	
			this.cbb_He = fl.controls.ComboBox(this.getChildByName("cbb_He"));
			this.btn_login.addEventListener(MouseEvent.CLICK, btn_login_click);
			
			
			//EVENT
			
			//init();
			//	connect();
			stop();
		}//end constructor
		private function playbackVideo():void
		{
			ns_playback = new NetStream(nc);
			ns_playback.addEventListener(NetStatusEvent.NET_STATUS, handleStreamStatus);
			video_voteback = new Video(5,5);
			video_voteback.x = 15;
			video_voteback.y = 5;
			mc1 = new MovieClip();
			video_playback = new Video(1200,480);
			video_playback.x = 10;
			video_playback.y = 10;
			video_playback.attachNetStream(ns_playback);
			ns_playback.play(room_id, -1);
		//	video_playback.clear();
		//	mc1.addChild(video_playback);
	//		mc1.addEventListener(MouseEvent.CLICK, fullscreen);
			addChild(video_playback);
		}
		private function fullscreen(event:MouseEvent):void
		{
			trace("fullscreen");
			event.target.stage.displayState = ( stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE ) ?
				StageDisplayState.NORMAL :
				StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		private  function toggleFullScreen():void {
			
		}
		
		/*
		* Init Frame Chat
		*/
		private function toggleFrameChat(type:String):void {
			if(type == "show") {
				this.input_chat.visible = true;
				this.ta_chat.visible = true;
				this.room_info.visible = true;
				this.total_ol.visible = true;
				this.grid_online.visible = true;
				this.btn_back.visible = true;
				this.lbl_online_list.visible = true;
				this.btn_send.visible = true;
				
				this.lbl_mic.visible = false;
				this.btn_NetConnect.visible = false;
				this.btn_vote.visible = false;
				this.btn_chat_switch.visible = false;
				this.status_a.visible = false;
				if(this.video_playback != null) {
					this.video_playback.visible = false;
				}
				
				if(this.video_voteback != null) {
					this.video_voteback.visible = false;
				}
				
			} else {
				
				this.input_chat.visible = false;
				this.ta_chat.visible = false;
				this.room_info.visible = false;
				this.total_ol.visible = false;
				this.grid_online.visible = false;
				this.btn_back.visible = false;
				this.lbl_online_list.visible = false;
				this.btn_send.visible = false;
				this.lbl_mic.visible = true;
				this.btn_NetConnect.visible = true;
				this.btn_vote.visible = true;
				this.btn_chat_switch. visible = true;
				this.status_a.visible = true;
				if(this.video_playback != null) {
					this.video_playback.visible = true;
				}
				
				if(this.video_voteback != null) {
					this.video_voteback.visible = true;
				}
			}
		}
		private function init():void
		{
			this.input_chat=fl.controls.TextInput(this.getChildByName("input_chat"));
			
			this.textformat1=new TextFormat();			
			this.ta_chat=fl.controls.TextArea(this.getChildByName("ta_chat"));
			this.textformat1.size=16;
			this.ta_chat.setStyle("textFormat", this.textformat1);
			
			this.room_info=fl.controls.Label(this.getChildByName("lbl_room_info"));				
			this.total_ol=fl.controls.Label(this.getChildByName("lbl_total"));
			this.lbl_mic=fl.controls.Label(this.getChildByName("lbl_mic"));
			this.lbl_online_list=fl.controls.Label(this.getChildByName("lbl_online_list"));
			
			this.btn_back=fl.controls.Button(this.getChildByName("btn_back"));
			this.textformat1.size=14;
			this.btn_back.setStyle("textFormat", this.textformat1);
			
			this.btn_chat_switch=fl.controls.Button(this.getChildByName("btn_chat_switch"));
			this.btn_chat_switch.setStyle("textFormat", this.textformat1);
				
			this.status_a=fl.controls.Label(this.getChildByName("lbl_status"));			
			this.btn_send=fl.controls.Button(this.getChildByName("btn_send"));
			this.btn_send.setStyle("textFormat", this.textformat1);
			
			this.btn_vote=MovieClip(this.getChildByName("btn_vote"));
			this.btn_NetConnect = MovieClip(this.getChildByName("btn_NetConnect"));	
			this.input_chat.addEventListener(KeyboardEvent.KEY_DOWN,input_chat_enter);
			this.btn_NetConnect.addEventListener(MouseEvent.CLICK,btn_connect_click);
			this.btn_vote.addEventListener(MouseEvent.CLICK,btn_vote_click);
			this.btn_vote.addEventListener(MouseEvent.ROLL_OVER,btn_over);
			this.btn_vote.addEventListener(MouseEvent.ROLL_OUT,btn_out);		
			
			this.btn_back.addEventListener(MouseEvent.CLICK, btn_back_click);
			this.btn_back.addEventListener(MouseEvent.ROLL_OVER,btn_over);
			this.btn_back.addEventListener(MouseEvent.ROLL_OUT,btn_out);
			
			this.btn_chat_switch.addEventListener(MouseEvent.CLICK, btn_chat_switch_click);
			this.btn_chat_switch.addEventListener(MouseEvent.ROLL_OVER,btn_over);
			this.btn_chat_switch.addEventListener(MouseEvent.ROLL_OUT,btn_out);
			
			this.btn_send.addEventListener(MouseEvent.CLICK, btn_send_click);
			this.btn_send.addEventListener(MouseEvent.ROLL_OVER,btn_over);
			this.btn_send.addEventListener(MouseEvent.ROLL_OUT,btn_out);
			
			this.toggleFrameChat("hide");
			
			//REMOTECLASS
			
			registerClassAlias("org.red5.core.Client",Client);

			//NET CONNECTION
			nc = new NetConnection();			
			nc.client = { onBWDone: function():void{ trace("onBWDone") } };
			nc.addEventListener(NetStatusEvent
				.NET_STATUS , netStatus);
			loaderComplete();		
			
			//Datagrid OnlineList
			this.grid_online=DataGrid(this.getChildByName("grid_online"));
			this.grid_online.columns=["name","Action2"];
			this.grid_online.columns[0].width=180;
			
			
			Bell.main=this;
			this.grid_online.columns[1].cellRenderer = Bell;
			
			this.textformat1=new TextFormat();
			this.textformat1.size=11;
			
			this.grid_online.setRendererStyle("textFormat",this.textformat1);
			this.grid_online.showHeaders=false;
			
			//btn_vote
			btn_vote.gotoAndStop(2);
			mic = Microphone.getMicrophone();
			
			if(mic!= null){
				
				this.lbl_mic.text = "Mic: " + mic.name;
			}
			else{
				this.lbl_mic.text = "Mic: not found";
			}
			
			
		}
		private function btn_login_click(event:MouseEvent):void
		{
			this.username = this.input_username.text;
			this.password = this.input_password.text;
			trace(this.username + " " + this.password);
			if(this.username == "") {
				input_info.visible = true;
				input_info.text = "Vui lòng nhập tên";
			} else {
				if(password != "12345678") {
					input_info.visible = true;
					input_info.text = "Mật khẩu sai, vui lòng nhập lại";
				}
				else {
					gotoAndStop(2);
					this.init();
					
				}
			}
			
			
			/*
			loader = new URLLoader();
			configureListeners(loader);
			
			// App will send the authenticate request to server. Result will be filter in completeHandler function
			
			var request:URLRequest = new URLRequest("http://online.citd.vn:10088/phonghoca/index.php/index/mobilecheck?user="+username+"&pass="+password+"&khoa="+khoa);
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
			*/
		}
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		// Seperate data from authenticated request
		
		private function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var result:String = String(loader.data).split("%")[0]
			trace(String(loader.data).split("%")[0]);
			trace(String(loader.data).split("%")[1]);
			trace(String(result).split("|")[0]);
			if(String(result).split("|")[0] == "1")
			{
				tenhv = username;
				if(String(loader.data).split("-")[1] != ""){
					var info_class = String(loader.data).split("-");
					room_id = String(loader.data).split("%")[1];
					var cordx=0;
					var cordy=0;
					switch (info_class.length-1){
						case 1:
							cordx = 600;
							cordy = 335;
						break;						
						case 2:
							cordx = [300,670];
							cordy = [320,320];
						break;						
						case 3:
							cordx = [300,700,300];
							cordy = [200,200,400];
						break;
						case 4:
							cordx = [300,700,300,700];
							cordy = [200,200,400,400];
						break;
					}
					for(var i = 1; i < info_class.length; i++)
					{
						var data_arr = String(info_class[i]).split("%");
						drawclass(data_arr[2],data_arr[3],data_arr[0],cordx[i-1],cordy[i-1]);
						trace(data_arr[2]);
					}

				gotoAndStop(2);
				this.ta_classinfo=fl.controls.TextArea(this.getChildByName("TA_Class_info"));
				}
			}else
			{
				input_info.visible = true;
				if(String(loader.data).split("%")[0] == "0" )
				{
						input_info.text = "Tài khoản đang bị khóa!";
				}else if (String(loader.data).split("%")[0] == "2")
				{
						input_info.text = "Tài khoản đang bị sai mật khẩu!";
				}else if (String(loader.data).split("%")[0] == "2")
				{
						input_info.text = "Tài khoản đang bị đăng nhập!";
				}else{
						input_info.text = "Kiểm tra kết nối internet";
				}
			}
			trace("completeHandler: " + loader.data);
		}
		
		// Create the form to show the information after login. 
		
		private function drawclass(clainfo:String,clainfo1:String,class_room:String,corx:int,cory:int):void{
				var lb_infoclass:fl.controls.Label = new fl.controls.Label;
				var lb_infoclass1:fl.controls.Label = new fl.controls.Label;
				var bt_enterclass:fl.controls.Button = new fl.controls.Button;
				var codix = corx;
				var codiy = cory;
				
				bt_enterclass.x = codix+50;
				bt_enterclass.y = codiy+70;
				bt_enterclass.name = class_room;
				bt_enterclass.label = "Enter class"
				bt_enterclass.addEventListener(MouseEvent.CLICK, btn_access_class);
				
				lb_infoclass.x = codix+50;
				lb_infoclass.y = codiy+30;
				lb_infoclass.text = clainfo;
				lb_infoclass.autoSize = TextFieldAutoSize.CENTER;
				
				lb_infoclass1.x = codix+50;
				lb_infoclass1.y = codiy+10;
				lb_infoclass1.text = clainfo1;
				lb_infoclass1.autoSize = TextFieldAutoSize.CENTER;
				
				var rectangle:Shape = new Shape; 
				rectangle.graphics.lineStyle(3,0x29ACFE);
				rectangle.graphics.drawRect(codix, codiy, 200,100);
				
				addChild(rectangle); 
				addChild(bt_enterclass);
				addChild(lb_infoclass);
				addChild(lb_infoclass1);
		}
		
		private function btn_access_class(event:MouseEvent):void
		{
			var target_name = event.target;
			var class_name = target_name.name;
			trace(class_name);
		}
		
		private function openHandler(event:Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			input_info.visible = true;
			input_info.text = "ioErrorHandler: " + event;
		}
		public function loaderComplete():void
		{			
			this.room_id = "phc";
			this.input_host = "rtmp://118.69.55.61:3935/firstapp/room"+ this.room_id;
			this.name_client = this.username;
			
			this.masv = randomRange(5000,2).toString(4);
			type_client = "sv";			
			connect();
		}//end loadcomplete
		private function btn_over(me:MouseEvent)
		{
			Mouse.cursor="button";
		}
		private function btn_out(me:MouseEvent)
		{
			Mouse.cursor="auto";
		}
		private function connect()
		{
			trace("Connecting to: " + this.input_host + " " + this.name_client + " " + this.masv);
			nc.connect(this.input_host, this.name_client, this.masv, this.type_client);			
			
			var so_name:String="OnlineList";
			this.so_ol=SharedObject.getRemote(so_name,nc.uri,false);
			this.so_ol.client=this;
			this.so_ol.addEventListener(SyncEvent.SYNC,on_so_ol_sync);
			this.so_ol.connect(nc);
			
			var room:String="room"+this.room_id;
			var responder:Responder = new Responder(on_getOldMessage_Complete,on_getOldMessage_fail);
			this.nc.call("getOldMessage",responder,room);
		}
		
		private function btn_vote_click(event:MouseEvent):void
		{
			var scope:String="room"+this.room_id;
			
			if(this.nc.connected==true)
			{
				if(btn_vote.currentFrame==2)
				{
					var message:String="vote";
					var responder:Responder = new Responder(on_btn_vote_Complete, on_btn_vote_fail);
					this.nc.call("sendCommand",responder,scope,message, this.masv);	
				}
				
				if(btn_vote.currentFrame==3)
				{
					var message1:String="canvote";
					var responder1:Responder = new Responder(on_btn_cancelvote_Complete, on_btn_cancelvote_fail);
					this.nc.call("sendCommand",responder1,scope,message1,this.masv);
				}
				
				if(btn_vote.currentFrame==4) {
					var message2:String="stopvote";
					var responder2:Responder = new Responder(on_btn_stop_vote_complete, on_btn_stop_vote_fail);
					this.nc.call("sendCommand",responder2,scope,message2,this.masv);
				}
			}
		}
		
		private function on_btn_vote_Complete(result:Object):void
		{
			btn_vote.gotoAndStop(3);
			trace("Vote Complete");
		}
		
		private function on_btn_vote_fail(result:Object):void
		{
			trace("Vote False");
		}
		
		private function on_btn_cancelvote_Complete(result:Object):void
		{
			btn_vote.gotoAndStop(2);
			trace("Vote Complete");
		}
		
		private function on_btn_cancelvote_fail(result:Object):void
		{
			trace("Vote False");
		}
		
		private function on_btn_stop_vote_complete(result:Object):void
		{
			btn_vote.gotoAndStop(2);
			if(ns_voteback != null) {
					ns_voteback.close();
			}			
				
			trace("Stop Vote Complete");
		}
		
		private function on_btn_stop_vote_fail(result:Object):void
		{
			trace("Stop Vote Fail");
		}
		
		private function btn_back_click(event:MouseEvent):void
		{
			trace("click back");
			this.toggleFrameChat("hide");
		}
		
		private function btn_chat_switch_click(event:MouseEvent):void
		{
			trace("click chat switcher");
			this.toggleFrameChat("show");
		}
		
		private function btn_connect_click(event:MouseEvent):void
		{
			if(btn_NetConnect.currentFrame==1)
			{	
				trace("Connect");
				connect();
			}
			else
			{
				nc.close();
				trace("disconnect");
			}
		}
		private function input_chat_enter(event:KeyboardEvent):void
		{
			if(event.charCode == 13){
				
				// your code here
				var scope:String="room"+this.room_id;
				var message:String=this.name_client+": "+this.input_chat.text;
				if(message!=""&&this.nc.connected==true)
				{
					var responder:Responder = new Responder(on_btn_connect_Complete, on_btn_connect_fail);
					this.nc.call("sendMessage",null,scope,message);	
				}
				this.input_chat.text="";
			}
		}
		private function btn_send_click(event:MouseEvent):void
		{
			var scope:String="room"+this.room_id;
			var message:String=this.name_client+": "+this.input_chat.text;
			if(message!=""&&this.nc.connected==true)
			{
				var responder:Responder = new Responder(on_btn_connect_Complete, on_btn_connect_fail);
				this.nc.call("sendMessage",null,scope,message);	
			}
			this.input_chat.text="";		
		}
		// Send message function
		private function on_btn_connect_Complete(result:Object):void
		{
			this.ta_chat.appendText(result.toString());
		}
		private function on_btn_connect_fail(result:Object):void
		{
			this.ta_chat.appendText(result.toString());
		}
		
		//get old message chat in room
		private function on_getOldMessage_Complete(result:Object):void
		{
			if(result.toString()!="") this.ta_chat.text=result.toString();
			this.ta_chat.verticalScrollPosition=this.ta_chat.maxVerticalScrollPosition;
			
		}
		private function on_getOldMessage_fail(result:Object):void
		{
			this.ta_chat.appendText(result.toString());
			
		}
		function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		public function receiveMessage(mesg:String):void
		{
			this.ta_chat.appendText(mesg+"\n");
			this.ta_chat.verticalScrollPosition=this.ta_chat.maxVerticalScrollPosition;
			
		}

		public function receiveCommand(mesg:String):void
		{
			// This blank will fill by some code to occour some thing.
			trace(mesg);
			var comArray:Array = mesg.split("-");
			trace("Commmad: " + comArray[0]);
			trace("Client cer:" + comArray[1]);
			var clientCer:String = comArray[1];
			var command:String = comArray[0];
			if(command == "accept")
			{
				if(clientCer == masv)
				{
					btn_vote.gotoAndStop(4);
					ns_voteback = new NetStream(nc);
					ns_voteback.addEventListener(NetStatusEvent.NET_STATUS, handleStreamStatus);
					ns_voteback.inBufferSeek = true;
					ns_voteback.attachAudio(mic);
					video_voteback.attachNetStream(ns_voteback);
					ns_voteback.publish(clientCer, "live");
					trace("Client has been publish stream: " + masv);
				}else
				{
					ns_voteback = new NetStream(nc);
					ns_voteback.addEventListener(NetStatusEvent.NET_STATUS, handleStreamStatus);
			//		ns_voteback.inBufferSeek = true;
					video_voteback.attachNetStream(ns_voteback);
					ns_voteback.play(clientCer, -1);
					trace("Client has been Subscribe stream: " + masv);
				}
			}
			
			if(command =="reject")
			{
				btn_vote.gotoAndStop(2);
				if(ns_voteback != null) {
					ns_voteback.close();
				}
				trace("All client has been remove stream");
			}
			
			if(command == "stopvote") {
				btn_vote.gotoAndStop(2);
				if(ns_voteback != null) {
					ns_voteback.close();
				}
				
				trace("Stop vote");
			}			
			
		}
		
		private function on_so_ol_sync(event:SyncEvent):void
		{
			if(event.changeList[0].code=="clear")
			{
				switch(event.changeList[1].code) 
				{
					case "success":  update_online_list(event.target.data);    break;
					case "change":  update_online_list(event.target.data);    break;
				}    
			}
			else
			{
				switch(event.changeList[1].code) 
				{
					case "success":  update_online_list(event.target.data);    break;
					case "change":  update_online_list(event.target.data);    break;
				}    
			}
			
		}
		
		function parse(str:String):Number
		{
			for(var i = 0; i < str.length; i++)
			{
				var c:String = str.charAt(i);
				if(c != "0") break;
			}
			
			return Number(str.substr(i));
		}
		private function update_online_list(data:Object):void
		{
			this.room_info.text = "Chưa có giảng viên tham gia.";
			if(data["count"]!=null)
			{
				this.total_ol.text=data["count"];
				var list_SV:Array=new Array();
				list_SV=data["ol"] as Array;
				var arr_data:Array=new Array();
				
				for(var i:String in list_SV)
				{
					var obj:Object = new Object();
					var client:Client=list_SV[i] as Client;
					//define properties to the objects
					obj.id =client.client_id ;
					obj.name = client.name;
					obj.bell_status=client.vote_status;
					if(client.getclient_type()=="gv"){
						this.room_info.text = "Thông tin giảng viên: " + client.getname();
						this.total_ol.text= (parse(data["count"]) - 1).toString() ;
					}
					else if(client.name == this.name_client)
					{
						arr_data.unshift(obj);
						dem = dem + 1;
						if(dem == 2)
						{
							
						//	trace("123123");
					//		stop();
							gotoAndStop(1);
							this.input_info.text = "Tài khoản đang bị đăng nhập!";
							break;
							
						}
					}
					else{
						arr_data.push(obj);
					}
				}
				
				dem = 0;
				//define properties to the objects
				if(this.grid_online != null){
					this.grid_online.dataProvider=new DataProvider(arr_data);
				}
			}
			
		}//end update_online_list		
		
		private function netStatus(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Rejected":
					
					this.status_a.text="Rejected";	
					btn_NetConnect.gotoAndStop(1);
					break;
				case "NetConnection.Connect.Success":
					playbackVideo();
					this.status_a.text=this.name+masv+ " has connected";
					btn_NetConnect.gotoAndStop(2);
					break;
				case "NetConnection.Connect.Closed":
					
					this.status_a.text="Closed";
					this.ta_chat.text="";
					this.total_ol.text="";
					this.grid_online.removeAll();
					this.btn_vote.gotoAndStop(2);
					btn_NetConnect.gotoAndStop(1);
					break;
				case "NetConnection.Call.Failed":
					
					this.status_a.text="Call Fail";
					btn_NetConnect.gotoAndStop(1);
					break;
				
			}//end switch
		}//end netstatus
		private function handleStreamStatus(e:NetStatusEvent):void {
			switch(e.info.code) {
				case 'NetStream.Buffer.Empty':
					trace("Video Netstream Buffer Empty");
					break;
				case 'NetStream.Buffer.Full':
					trace("Video Netstream Buffer Full");
					break;
				case 'NetStream.Buffer.Flush':
					trace("Video Netstream Buffer Flushed!!!!");
					break;
			}
		}

		public function demofunction():void
		{
			trace("Demo Fucntion run");
		}
		
	}
	
}
