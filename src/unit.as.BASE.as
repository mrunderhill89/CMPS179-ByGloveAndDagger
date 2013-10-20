package {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	public class unit extends SimpleButton{
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		
		public function unit(){
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
		
		public function _mouseDown( e:MouseEvent ):void {
			if (tile != null) {
				tile._mouseDown(e);
			}
		}
	}
	
}
