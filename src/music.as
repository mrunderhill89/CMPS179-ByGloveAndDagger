package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class music extends MovieClip {
		
		
		public function music() {
			//stop();
			parent.addEventListener("start_game", _start);
		}
		public function _start(e:Event = null):void{
			trace("Playing music");
			this.gotoAndPlay(1);
		}
	}
	
}
