package  {
	
	import flash.display.SimpleButton;
	import flashx.textLayout.formats.Float;
	import flashx.textLayout.elements.ListElement;
	import flash.geom.Point;
	import flash.text.TextField;
	
	
	public class tile_default extends SimpleButton {
		
		//Indices start from the top and go clockwise.
		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;
		public static const COORDS:Array = [[0,1],[1,0],[0,-1],[-1,0]];

		public static const X_SIZE:Number = 50.0;
		public static const Y_SIZE:Number = 50.0;		
		protected static var index:int = 0;

		protected var neighbors:Array;
		protected var elements:Array;
		
		protected var id:int;
		
		protected var text:TextField;
		
		public function tile_default() {
			id = index;
			index++;
			//Find tile elements and store them here.
			var point:Point = new Point(x, y);			
			/*var myElements:Array = stage.getObjectsUnderPoint(point);
			for (var el in myElements) {
				if (el != null){
					trace(id + el + " => " + myElements[el]);
				}
			}
			*/
			
			//Find Neighboring Tiles
			var n_x:Number;
			var n_y:Number;
			var objectsAt:Array;
			for(var d:int = 0; d < 4; d++){
				n_x = this.x + X_SIZE * COORDS[d][0];
				n_y = this.y + Y_SIZE * COORDS[d][1];
			}
			text = new TextField();
			text.text = this.id.toString();
			text.x = x;
			text.y = y;
		}
	}
	
}
