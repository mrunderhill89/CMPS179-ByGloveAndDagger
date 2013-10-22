package  {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flashx.textLayout.formats.Float;
	import flashx.textLayout.elements.ListElement;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class tile_default extends SimpleButton {
		
		//Indices start from the top and go clockwise.
		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;
		public static const COORDS:Array = [[0,-1],[1,0],[0,1],[-1,0]];
		public static const OPPOSITES:Array = [DOWN,LEFT,UP,RIGHT];
		public static const COORDICONS:Array = ['U','R','D','L'];

		public static const X_SIZE:Number = 50.0;
		public static const Y_SIZE:Number = 50.0;		
		public static const X_SNAP:Number = 0.1;
		public static const Y_SNAP:Number = 0.1;
		protected static var tile_index:int = 0;
		protected static var tiles:Array = new Array();

		protected var neighbors:Array;
		protected var elements:Array;
		protected var un:unit = null;
		
		protected var id:int;
		
		protected var text:TextField;
		
		protected static var currentTile:tile_default = null;
		public static function getCurrentTile():tile_default {
			return currentTile;
		}
		public static var highlighting:Boolean = true;
		public function tile_default() {
			id = tile_index;
			tile_index++;
			neighbors = new Array();
			elements = new Array();
			if (this is tile_default)
				tiles.push(this);
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE,initialize);
			}
		}
		
		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			var x_dist:Number;
			var y_dist:Number;
			//Find tile elements and store them here.
			for (var ei:String in tile_element.getInstances()){
				var el:tile_element = tile_element.getInstances()[ei];
				if (el != null){
					x_dist = el.x - this.x;
					y_dist = el.y - this.y;
					if (Math.abs(x_dist) < X_SNAP && Math.abs(y_dist) < Y_SNAP){
						el.setTile(this);
						elements.push(el);
						//trace("Adding tile element:"+ el.name + " to tile:" + id); 
					}
				}
			}

			//Find units and set their tile to this.
			//trace("Adding units...");
			for (var ui:String in unit.getInstances()){
				var u:unit = unit.getInstances()[ui];
				if (u != null){
					trace("Adding unit:"+ u.name + " to tile:" + id); 
					x_dist = u.x - this.x;
					y_dist = u.y - this.y;
					if (Math.abs(x_dist) < X_SNAP && Math.abs(y_dist) < Y_SNAP){
						u.setTile(this);
						this.un = u;
					}
				}
			}

			//Generate debug text on each tile
			text = new TextField();
			text.text = this.id.toString();
			
			//Find neighboring tiles
			for (var t:String in tiles){
				var tile:tile_default = tiles[t];
				if (tile.id != this.id){
					x_dist = tile.x - this.x;
					y_dist = tile.y - this.y;
					
					//Horizontal
					if (Math.abs(y_dist) < Y_SNAP){
						if (Math.abs(x_dist) <= X_SIZE + X_SNAP){
							if (x_dist > 0){
								this.neighbors[RIGHT] = tile;
								tile.neighbors[LEFT] = this;
								//trace(this.id + ">" + COORDICONS[RIGHT] + ">" + tile.id);
							} else {
								this.neighbors[LEFT] = tile;
								tile.neighbors[RIGHT] = this;
								//trace(this.id + ">" + COORDICONS[LEFT] + ">" + tile.id);
							}
						}
					} else if (Math.abs(x_dist) < X_SNAP){
						if (Math.abs(y_dist) <= Y_SIZE + Y_SNAP){
							if (y_dist > 0){
								this.neighbors[DOWN] = tile;
								tile.neighbors[UP] = this;
								//trace(this.id + ">" + COORDICONS[DOWN] + ">" + tile.id);
							} else {
								this.neighbors[UP] = tile;
								tile.neighbors[DOWN] = this;
								//trace(this.id + ">" + COORDICONS[UP] + ">" + tile.id);
							}
						}
					}
				}
			}
			text.x = x;
			text.y = y;
			text.selectable = false;
			//parent.addChild(text);
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
			addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, _mouseOut );
			addEventListener( MouseEvent.CLICK, _mouseClick);
		}
		
		public function _mouseOver( e:MouseEvent): void
		{
			//trace("Tile Selected:" + id);
			dispatchEvent(new TileEvent(TileEvent.TILE_MOUSEOVER, true, false, this));
			currentTile = this;
		}
		
		public function _mouseOut( e:MouseEvent): void
		{
			//trace("Tile Deselected:" + id);
			dispatchEvent(new TileEvent(TileEvent.TILE_MOUSEOUT, true, false, this));
		}

		public function _mouseClick ( e:MouseEvent): void
		{
			trace("Tile Clicked:" + text.text);
			dispatchEvent(new TileEvent(TileEvent.TILE_CLICKED, true, false, this));
			if (this.un != null) {
				this.un.dispatchEvent(new UnitEvent(UnitEvent.UNIT_CLICKED));
			}
		}
				
		public function dehighlight(): void {
			this.transform.colorTransform = new ColorTransform();
		}

		public function highlight(): void {
			var myColorTransform:ColorTransform = new ColorTransform();
			myColorTransform.color = 0x1133FF;
			this.transform.colorTransform = myColorTransform;			
		}
		
		public function _onUpdate( e:Event ):void
		{
			text.text = this.id.toString();
			for (var d:int = 0; d < 4; d++){
				if (this.neighbors[d] != null){
					text.appendText(COORDICONS[d]);
				}
			}
			if (currentTile == this && highlighting) {
				highlight();
			} else {
				dehighlight();
			}
		}
	}
}
