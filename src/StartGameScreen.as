package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class StartGameScreen extends MovieClip {
		
		
		public function StartGameScreen() {
			stop();
			addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		private function _onClick(me:MouseEvent=null){
			stop();
			(parent as MovieClip).gotoAndStop(1, "Game");
		}
	}
	
}
