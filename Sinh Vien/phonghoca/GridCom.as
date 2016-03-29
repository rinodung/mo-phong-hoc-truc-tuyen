package
{
	import fl.controls.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;

	public class GridCom extends Sprite
	{
		public var mygrid:DataGrid;
		public var btn_order:Button;
		public var textformat1: TextFormat;
		public var textformat2:TextFormat;
		import flash.display.MovieClip;
		public function GridCom()
		{
			trace("start");
			init();
			
		}
		public function init()
		{
			
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			this.btn_order=Button(this.getChildByName("order"));
			this.btn_order.addEventListener(MouseEvent.CLICK,on_btnOrder_CLICK);
			
			
			//set column
			this.mygrid.columns=["Name","Action1","Action2"];
			this.mygrid.columns[0].width=300;
			this.mygrid.columns[1].width=50;
			this.mygrid.columns[1].cellRenderer = mybutton;
			this.mygrid.columns[2].width=50;
			this.mygrid.columns[2].cellRenderer = Bell;
			
			this.mygrid.rowHeight=40;
			
			//set data provider
			var myData:Array = [{Name: "Hồ Trần Bắc An", id: "09520001", Job: "Shop manager's assistant"},
				{Name: "Nguyễn Hải Phong", id: "09520002", Job: "Doctor"},
				{Name: "Bùi Phát", id: "09520003", Job: "Chef"},
				{Name: "Long Nhật Minh", id:"09520004", Job: "Janitor"},
				{Name: "Khắc Minh", id:"09520005", Job: "Bank assistant"},
				{Name: "Đồng Gia", id:"09520006", Job: "Little kid"},
				{Name: "Bạch Tinh", id:"09520007", Job: "Little kid"}];
				
			
			//keep trace
			//trace(myData);
			
			this.mygrid.dataProvider=new DataProvider(myData);
			
			this.textformat1=new TextFormat();
			this.textformat1.size=14;
			
			this.textformat2=new TextFormat();
			this.textformat2.size=14;
			//this.mygrid.setStyle("textFormat",this.textformat2);
			//this.mygrid.setRendererStyle("textFormat",this.textformat2);
			
		}//end init
		
		private function on_btnOrder_CLICK(me:MouseEvent)
		{
			var col:int=2;
			var row:int=2;
			var id:String="09520004";
			var Rows=this.mygrid.length;
			var Cols=this.mygrid.columns.length;
			for(var i:int=0;i<Rows;i++)
			{
				var obj:Bell=Bell(this.mygrid.getCellRendererAt(i,2));
				if(obj.name==id)
				{
					obj.update_status("");
					trace(obj.name);
					break;
				}
				
			}
			trace("numRow: "+this.mygrid.length+" numCol: "+this.mygrid.columns.length);
			
			
			
			
		}
		
		
		
		//edit datagridcolumn object
		public function init2()
		{
			
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			
			var col_name:DataGridColumn = new DataGridColumn("Name");
			this.mygrid.addColumn(col_name);
			
			var col_age:DataGridColumn = new DataGridColumn("Age");
			this.mygrid.addColumn(col_age);
			col_age.sortOptions = Array.NUMERIC;
			
			var col_job:DataGridColumn = new DataGridColumn("Job");
			this.mygrid.addColumn(col_job);
			col_job.cellRenderer = wordWrapCellRenderer;
			
			this.mygrid.columns[0].width=140
			this.mygrid.columns[1].width=70
			this.mygrid.columns[2].width=150
			
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.size = 16;
			textFormat1.color = 0x333333;
			textFormat1.bold = true;
			textFormat1.font = "Arial"
			
			this.mygrid.setStyle("headerTextFormat", textFormat1);
			
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.size = 10;
			textFormat2.font = "Verdana"
			
			this.mygrid.setRendererStyle("textFormat", textFormat2);
			
			
			var myData:Array = [{Name: "John Jenkins", Age: "31", Job: "Shop manager's assistant"},
				{Name: "Anna Watson", Age: "28", Job: "Doctor"},
				{Name: "Susan McCallister", Age: "29", Job: "Chef"},
				{Name: "Joe Thompson", Age:"32", Job: "Janitor"},
				{Name: "Bob Anderson", Age:"31", Job: "Bank assistant"},
				{Name: "William Thompson", Age:"2", Job: "Little kid"},
				{Name: "Oscar Anderson", Age:"3", Job: "Little kid"}];
			
			this.mygrid.dataProvider = new DataProvider(myData);
			this.mygrid.rowCount =this.mygrid.length;
			this.mygrid.rowHeight = 40;
		}//end init2
		
		public function init3()
		{
			
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			
			var col_name:DataGridColumn = new DataGridColumn("Name");
			this.mygrid.addColumn(col_name);
			
			var col_age:DataGridColumn = new DataGridColumn("Age");
			this.mygrid.addColumn(col_age);
			col_age.sortOptions = Array.NUMERIC;
			
			var col_job:DataGridColumn = new DataGridColumn("Job");
			this.mygrid.addColumn(col_job);
			col_job.cellRenderer = mybutton;
			col_job.sortable=false;
			
			this.mygrid.columns[0].width=140
			this.mygrid.columns[1].width=70
			this.mygrid.columns[2].width=50
			
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.size = 16;
			textFormat1.color = 0x333333;
			textFormat1.bold = true;
			
			
			this.mygrid.setStyle("headerTextFormat", textFormat1);
			
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.size = 10;
			
			
			this.mygrid.setRendererStyle("textFormat", textFormat2);
			
			
			var myData:Array = [{Name: "John Jenkins", Age: "31", Job: "Shop manager's assistant"},
				{Name: "Anna Watson", Age: "28", Job: "Doctor"},
				{Name: "Susan McCallister", Age: "29", Job: "Chef"},
				{Name: "Joe Thompson", Age:"32", Job: "Janitor"},
				{Name: "Bob Anderson", Age:"31", Job: "Bank assistant"},
				{Name: "William Thompson", Age:"2", Job: "Little kid"},
				{Name: "Oscar Anderson", Age:"3", Job: "Little kid"}];
			
			this.mygrid.dataProvider = new DataProvider(myData);
			this.mygrid.rowCount =this.mygrid.length;
			this.mygrid.rowHeight = 20;
		}//end init3
		
		//editable
		public function init4():void
		{
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			this.mygrid.editable = true;
			
			var col_id:DataGridColumn = new DataGridColumn("ID");
			this.mygrid.addColumn(col_id);
			col_id.editable = false;
			
			var col_name:DataGridColumn = new DataGridColumn("Name");
			this.mygrid.addColumn(col_name);
			
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.size = 16;
			textFormat1.color = 0x333333;
			textFormat1.bold = true;
			textFormat1.font = "Arial";
			
			this.mygrid.setStyle("headerTextFormat", textFormat1);
			
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.size = 10;
			textFormat2.font = "Verdana";
			
			this.mygrid.setRendererStyle("textFormat", textFormat2);
			
			var myData:Array = [{Name: "John", ID: "1025001"},
				{Name: "Ralph", ID: "1025002"},
				{Name: "Ted", ID: "1025003"},
				{Name: "Bob", ID: "1025004"},
				{Name: "Jack", ID: "1025005"},
				{Name: "Claire", ID: "1025006"},
				{Name: "Michael", ID: "1025007"},
				{Name: "Daniel", ID: "1025008"}
			];
			
			this.mygrid.dataProvider = new DataProvider(myData);
			this.mygrid.rowHeight = 26;
			
			
			
		}//end init4
		//checkbox
		public function init5():void
		{
			
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			var col_img:DataGridColumn = new DataGridColumn("Available");
			this.mygrid.addColumn(col_img);
			col_img.cellRenderer = mycheckbox;
			mycheckbox._stage = this;
			col_img.width = 24;
			
			var col_desc:DataGridColumn = new DataGridColumn("Name");
			this.mygrid.addColumn(col_desc);
			
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.size = 16;
			textFormat1.color = 0x333333;
			textFormat1.bold = true;
			textFormat1.font = "Arial";
			
			this.mygrid.setStyle("headerTextFormat", textFormat1);
			
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.size = 10;
			textFormat2.font = "Verdana";
			
			this.mygrid.setRendererStyle("textFormat", textFormat2);
			
			var myData:Array = [{Name: "John", Available: true},
				{Name: "Ralph", Available: true},
				{Name: "Ted", Available: false},
				{Name: "Bob", Available: true},
				{Name: "Jack", Available: false},
				{Name: "Claire", Available: true},
				{Name: "Michael", Available: false},
				{Name: "Daniel", Available: true}
			];
			
			this.mygrid.dataProvider = new DataProvider(myData);
			this.mygrid.rowHeight = 26;
			
			this.mygrid.showHeaders = false;
		}
		
		public function gettrace():void
		{
			trace("Checkbox click");
		}
		
		
		
	//end init 5
	
	//combobox
		public function init6():void
		{
			
			this.mygrid=DataGrid(this.getChildByName("mygrid"));
			
			var col_img:DataGridColumn = new DataGridColumn("Role");
			this.mygrid.addColumn(col_img);
			col_img.cellRenderer = mycombo;
			mycombo._stage = this;
			
			var col_desc:DataGridColumn = new DataGridColumn("Name");
			this.mygrid.addColumn(col_desc);
			
			var textFormat1:TextFormat = new TextFormat();
			textFormat1.size = 16;
			textFormat1.color = 0x333333;
			textFormat1.bold = true;
			textFormat1.font = "Arial";
			
			this.mygrid.setStyle("headerTextFormat", textFormat1);
			
			var textFormat2:TextFormat = new TextFormat();
			textFormat2.size = 10;
			textFormat2.font = "Verdana";
			
			this.mygrid.setRendererStyle("textFormat", textFormat2);
			
			var myData:Array = [{Name: "John", Role: ([{label:"Footman", data:1},{label:"Archer", data:2},{label:"Knight", data:3}])},
				{Name: "Ralph", Role: ([{label:"Footman", data:1},{label:"Archer", data:2},{label:"Knight", data:3}])},
				{Name: "Ted", Role: ([{label:"Footman", data:1},{label:"Archer", data:2},{label:"Knight", data:3}])},
				{Name: "Bob", Role: ([{label:"Footman", data:1},{label:"Archer", data:2},{label:"Knight", data:3}])}
			];
			
			this.mygrid.dataProvider = new DataProvider(myData);
			this.mygrid.rowHeight = 26;
			this.mygrid.rowCount = this.mygrid.length;
		}//end init 6
	}//end class
	

	
	
}