package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class music extends MovieClip {
		protected var started:Boolean = false;
		
		public function music() {
			//stop();
			parent.addEventListener("start_game", _start);
		}
		public function _start(e:Event = null):void{
			if (!started){
				this.gotoAndPlay(1);
				started = true;
			}
		}
	}
	
}
