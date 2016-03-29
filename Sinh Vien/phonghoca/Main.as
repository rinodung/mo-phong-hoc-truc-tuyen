package
{
	import com.bit101.components.*;	
	import fl.controls.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.events.SyncEvent;
	import flash.events.TimerEvent;
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
	import red5.*;
	

	
	public class Main extends Sprite
	{		
		// Declare layout elements 
		public var nc:NetConnection;
		public var input_chat:fl.controls.TextInput;	
		public var status_a:fl.controls.Label;
		public var total_ol:fl.controls.Label;
		public var room_info:fl.controls.Label;
		public var room_info1:fl.controls.Label;
		public var btn_send:fl.controls.Button;
		public var btn_vote:MovieClip;
		public var btn_NetConnect:MovieClip;
		public var ta_chat:fl.controls.TextArea;
		
		// Declare video elements 
		private var ns_playback:NetStream;
		private var ns_voteback:NetStream;
		private var video_playback:Video;
		private var video_voteback:Video;
		private var mic:Microphone;
		private var h264Settings:H264VideoStreamSettings;
		private var options:MicrophoneEnhancedOptions
		
		//Declare SharedObject elements 
		public var so_ol:SharedObject;
		
		//Declare stuff elements 
		public var grid_online:DataGrid;
		public var textformat1: TextFormat;
		public var room_id:String;
		public var name_client:String;
		public var address_client:String;
		public var type_client:String;
		public var masv:String;
		public var input_host:String;
		
		///////////////////
		// Main Function //
		///////////////////	
		
		public function Main()
		{
			// Initial function
			init();
		}
		
		//////////////////////////////////////////////////////
		// Create new stream when student speak to teacher //
		////////////////////////////////////////////////////
		
		private function playbackVideo():void
		{
			// Create new stream
			ns_playback = new NetStream(nc);
			ns_playback.addEventListener(NetStatusEvent.NET_STATUS, handleStreamStatus);
			
			// Create vital parameters
			video_voteback = new Video(5,5);
			video_voteback.x = 15;
			video_voteback.y = 5;
			video_playback = new Video(1000,450);
			video_playback.x = 1;
			video_playback.y = 1;
			video_playback.attachNetStream(ns_playback);
			
			// Play with id equal room_id
			ns_playback.play(room_id, -1);
			
			// Add to main layout
			addChild(video_playback);
		}
		private function init():void
		{
			// Get layout elements.
			this.input_chat=fl.controls.TextInput(this.getChildByName("input_chat"));
			this.status_a=fl.controls.Label(this.getChildByName("lbl_status"));
			this.total_ol=fl.controls.Label(this.getChildByName("lbl_total"));
			this.room_info=fl.controls.Label(this.getChildByName("lbl_room_info"));
			this.room_info1=fl.controls.Label(this.getChildByName("lbl_room_info1"));
			this.btn_send=fl.controls.Button(this.getChildByName("btn_send"));
			this.btn_vote=MovieClip(this.getChildByName("btn_vote"));
			this.btn_NetConnect = MovieClip(this.getChildByName("btn_NetConnect"));
			this.ta_chat=fl.controls.TextArea(this.getChildByName("ta_chat"));	
			
			// Add event
			this.input_chat.addEventListener(KeyboardEvent.KEY_DOWN,input_chat_enter);
			this.root.loaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
			this.btn_NetConnect.addEventListener(MouseEvent.CLICK,btn_connect_click);
			this.btn_vote.addEventListener(MouseEvent.CLICK,btn_vote_click);
			this.btn_vote.addEventListener(MouseEvent.ROLL_OVER,btn_over);
			this.btn_vote.addEventListener(MouseEvent.ROLL_OUT,btn_out);
			
			// Associate to remote class
			registerClassAlias("org.red5.core.Client",Client);
			
			// Establish audio factors
			options = new MicrophoneEnhancedOptions();
			options.mode = MicrophoneEnhancedMode.OFF;
			options.echoPath = 128;
			options.nonLinearProcessing = false;
			options.autoGain = true;
			
			// Create network connection to server
			nc = new NetConnection();			
			nc.client = { onBWDone: function():void{ trace("onBWDone") } };
			nc.addEventListener(NetStatusEvent
				.NET_STATUS , netStatus);
			
			// Create data girdlist to display Online  student list
			this.grid_online=DataGrid(this.getChildByName("grid_online"));
			this.grid_online.columns=["name","Action2"];
			this.grid_online.columns[0].width=180;
			
			// Declare Bell object to display bell image
			Bell.main=this;
			this.grid_online.columns[1].cellRenderer = Bell;
				
			this.textformat1=new TextFormat();
			this.textformat1.size=11;
			
			
			//this.mygrid.setStyle("textFormat",this.textformat2);
			this.grid_online.setRendererStyle("textFormat",this.textformat1);
			this.grid_online.showHeaders=false;
			
			// Declare state of button student vote.
			btn_vote.gotoAndStop(2);
			
			// Establish Microphone set up and display configuration panel if lacking of recognizing
			mic = Microphone.getEnhancedMicrophone();
			mic.setUseEchoSuppression(false);
			Security.showSettings("privacy");
			if(mic.muted)
			{
				Security.showSettings("microphone");
			}
		    mic.codec = SoundCodec.SPEEX;
			mic.framesPerPacket = 1;
		    mic.setSilenceLevel(0, 2000);
			mic.setLoopBack(false);
			mic.enhancedOptions = options;
		}
		
		//////////////////////////////////////////////////////////////////
		// This function is called after finishing loading application //
		////////////////////////////////////////////////////////////////
		
		public function loaderComplete(e:Event):void
		{
			// Get parameter from previous fram. (username and room id)
			var paras:Object=this.root.loaderInfo.parameters;
			var key:String;
			var value:String;
			for(key in paras)
			{
				value=String(paras[key]);
				
			}
			if(paras["room_id"]!=null)this.room_id=paras["room_id"];
			else this.room_id="phc";
			
			// Establish URL to connect server
			this.room_info.text+="\nPhòng: room_"+this.room_id+"\n";
			this.input_host="rtmp://118.69.55.61:3935/firstapp/room"+room_id;
			
			if(paras["address"]!=null)this.address_client=paras["address"];
			else this.address_client="Address 1";
			
			if(paras["client_name"]!=null)this.name_client=paras["client_name"];
			else this.name_client="Sinh Viên";
			
			// Random number to connect to server. This look like application ID 
			this.masv=randomRange(5000,2).toString(4);
			type_client = "sv";
			trace(this.masv); 
			
			// Connect function after all.
			connect();
		}
		
		private function btn_over(me:MouseEvent)
		{
			Mouse.cursor="button";
		}
		private function btn_out(me:MouseEvent)
		{
			Mouse.cursor="auto";
		}
		
		///////////////////////
		// Connect Function //
		/////////////////////
		
		private function connect()
		{
			var link:String =this.input_host;
			nc.connect(link,this.name_client,masv,this.type_client);
			
			// Create share object to share list of the student.
			var so_name:String="OnlineList";
			this.so_ol=SharedObject.getRemote(so_name,nc.uri,false);
			this.so_ol.client=this;
			this.so_ol.addEventListener(SyncEvent.SYNC,on_so_ol_sync);
			this.so_ol.connect(nc);
			
			var room:String="room"+this.room_id;
			var responder:Responder = new Responder(on_getOldMessage_Complete,on_getOldMessage_fail);
			
			// Send request to server and receive the results in responder. 
			this.nc.call("getOldMessage",responder,room);
		}
		
		//////////////////////////////////////////
		// Function associate with vote button //
		////////////////////////////////////////
		
		private function btn_vote_click(event:MouseEvent):void
		{
			var scope:String="room"+this.room_id;
			
			if(this.nc.connected==true)
			{
				// Change image when change state of vote.
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
		
		/////////////////////////////////////////////
		// Function associate with Connect button //
		///////////////////////////////////////////
		
		private function btn_connect_click(event:MouseEvent):void
		{
			// Perform connect or disconnect to server.
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
		
		///////////////////////////////////////////////
		// Function associate with input of chatter //
		/////////////////////////////////////////////
		
		private function input_chat_enter(event:KeyboardEvent):void
		{
			if(event.charCode == 13){
				var scope:String="room"+this.room_id;
				var message:String=this.name_client+": "+this.input_chat.text;
				if(message!=""&&this.nc.connected==true)
				{
					// After getting message will send it to server.
					var responder:Responder = new Responder(on_btn_connect_Complete, on_btn_connect_fail);
					this.nc.call("sendMessage",null,scope,message);	
				}
				this.input_chat.text="";
			}
		}
		
		////////////////////////////
		// The same above funtion//
		//////////////////////////
		
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
		
		////////////////////////////
		// Send message function //
		//////////////////////////
	
		private function on_btn_connect_Complete(result:Object):void
		{
			this.ta_chat.appendText(result.toString());
		}
		private function on_btn_connect_fail(result:Object):void
		{
			this.ta_chat.appendText(result.toString());
		}
		
		///////////////////////////////////
		// Get old message chat in room //
		/////////////////////////////////

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
		
		//////////////////////////////////
		// Update message chat in room //
		////////////////////////////////
		
		public function receiveMessage(mesg:String):void
		{
			this.ta_chat.appendText(mesg+"\n");
			this.ta_chat.verticalScrollPosition=this.ta_chat.maxVerticalScrollPosition;
			
		}
		
		//////////////////////////////////////////////////////////////////
		// Function help teacher accept or close student stream (vote) //
		////////////////////////////////////////////////////////////////
		
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
					ns_voteback.attachAudio(mic);
					ns_voteback.publish(clientCer, "live");
					trace("Client has been publish stream: " + masv);
				}else
				{
					ns_voteback = new NetStream(nc);
					ns_voteback.addEventListener(NetStatusEvent.NET_STATUS, handleStreamStatus);
					video_voteback.attachNetStream(ns_voteback);
					ns_voteback.play(clientCer, -1);
					trace("Client has been Subscribe stream: " + masv);
				}
			}if(command =="reject")
			{
				btn_vote.gotoAndStop(2);
				ns_voteback.close();
				trace("All client has been remove stream");
			}
		}
		
		///////////////////////////////////////////////////////////////////
		// Sync function to update student list when new student access //
		/////////////////////////////////////////////////////////////////
		
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
		
		///////////////////////////////////////////////////////////////////
		// Sync function to update student list when new student access //
		/////////////////////////////////////////////////////////////////
		
		
		private function update_online_list(data:Object):void
		{
			this.room_info.text ="Vui lòng chờ giảng viên";
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
					//obj.address=client.address;
					obj.bell_status=client.vote_status;
					if(client.getclient_type()=="gv"){
						this.room_info.text = "Giảng viên: " + client.getname().split("-")[0];
						this.room_info1.text = "Lớp: " + client.getname().split("-")[1];
						this.total_ol.text= (parse(data["count"]) - 1).toString() ;
					}
					else if(client.name == this.name_client)
					{
						arr_data.unshift(obj);
					}
					else{
						arr_data.push(obj);
					}
				}
				
				
				//define properties to the objects
				
			//	trace(arr_data);
				this.grid_online.dataProvider=new DataProvider(arr_data);
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
					this.status_a.text=this.name+masv+ "has Connected";
					btn_NetConnect.gotoAndStop(2);
					break;
				case "NetConnection.Connect.Closed":
					
					this.status_a.text="Closed";
					//this.result.text="";
					
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
