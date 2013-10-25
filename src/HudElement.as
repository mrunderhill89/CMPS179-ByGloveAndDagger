package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	public class HudElement extends MovieClip {
		
		protected var initialPos:Point;
		public function HudElement() {
			initialPos = new Point(x,y);
			addEventListener(Event.ENTER_FRAME,_update);
			stop();
		}
		
		public function _update( e:Event = null){
			if (this.parent != null){
				x = initialPos.x - parent.x;
				y = initialPos.y - parent.y;
			}
		}
	}
}
