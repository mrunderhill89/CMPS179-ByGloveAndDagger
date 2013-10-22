package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	public class Level1 extends MovieClip {
		
		public function Level1() {
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
			addEventListener(Event.COMPLETE, reportComplete);
		}
		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		private function reportComplete(e:Event = null):void {
			trace("Load Complete");
			dispatchEvent(new Event(Event.COMPLETE, true));
		}
		// our update function
		private function _onUpdate( e:Event ):void
		{
		}
	}
	
}
