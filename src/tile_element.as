package  {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class tile_element extends SimpleButton {
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		
		public function tile_element(){
			instances.push(this);
			tile = null;
			addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
			addEventListener(MouseEvent.CLICK, _mouseOver);
			addEventListener(UnitEvent.UNIT_APPROACH_TILE, _unitApproach);
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
		
		public function _mouseOver( me:MouseEvent):void {
			if (tile != null) {
				tile.dispatchEvent(me);
			}
		}
		public function _mouseClick( me:MouseEvent):void {
			if (tile != null) {
				tile.dispatchEvent(me);
			}
		}
		
		public function _unitApproach( ue:UnitEvent ):void{
			trace(name + " approached by " + ue.un.name);
		}
	}
	
}
