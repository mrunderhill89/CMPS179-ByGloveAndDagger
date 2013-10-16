package  {
	
	import flash.display.SimpleButton;
	import flashx.textLayout.formats.Float;
	import flashx.textLayout.elements.ListElement;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import flash.display.MovieClip;
	
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
		protected static var tile_index:int = 0;
		protected static var tiles:Array = new Array();

		protected var neighbors:Array;
		protected var elements:Array;
		
		protected var id:int;
		
		protected var text:TextField;
		
		public function tile_default() {
			id = tile_index;
			tile_index++;
			neighbors = new Array();
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
			//Find tile elements and store them here.
			var point:Point = new Point(x, y);			

			//Generate debug text on each tile
			text = new TextField();
			text.text = this.id.toString();
			
			//Find Neighboring Tiles
			var n_x:Number;
			var n_y:Number;
			var objectsAt:Array;
			trace("Begin neighbor search, tile:" + id);
			trace("Position:" + point);
			for(var d:int = 0; d < 4; d++){
				n_x = x + (X_SIZE * COORDS[d][0]);
				n_y = y + (Y_SIZE * COORDS[d][1]);
				trace ( COORDICONS[d] + ":" + new Point(n_x, n_y));
				for (var t in tiles){
					var tile:tile_default = tiles[t];
					if (tile != null && tile != this){
						if (tile.x == n_x && tile.y == n_y){
							this.neighbors[d] = tile;
							tile.neighbors[OPPOSITES[d]] = this;
							trace(id + ">" + COORDICONS[d] + ">" + t);
						}
					}
				}
			}
			text.x = x;
			text.y = y;
			parent.addChild(text);
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		
		private function _onUpdate( e:Event ):void
		{
		}
	}
}
