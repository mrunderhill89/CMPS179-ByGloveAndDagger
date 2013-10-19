package  {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class tile_element extends SimpleButton {
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		
		public function tile_element(){
			instances.push(this);
			tile = null;
		}
		
		public static function getInstances():Array{
			return instances;
		}
		
		public function getTile():tile_default{
			return tile;
		}
		
		public function setTile(t:tile_default):void{
			tile = t;
		}
		
		public function _mouseDown( e:MouseEvent ) {
			if (tile != null) {
				tile._mouseDown();
			}
		}
	}
	
}
