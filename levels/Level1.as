﻿package  {
	
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
				addEventListener(Event.ADDED_TO_STAGE,initialize);
			}
		}
		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		// our update function
		private function _onUpdate( e:Event ):void
		{
		}
	}
	
}
