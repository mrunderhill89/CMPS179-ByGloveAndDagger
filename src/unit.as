package {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class unit extends SimpleButton{
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		public var facingA:Array = new Array();
		public var facing:int = 0;
		public function unit(){
			instances.push(this);
			tile = null;
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		private function _onUpdate():void
		{
			
			if (this.facing == 0) {
				this.facingA[0];
				
			}
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
