package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class StartGameScreen extends MovieClip {
		
		
		public function StartGameScreen() {
			stop();
			addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		private function _onClick(me:MouseEvent=null){
			stop();
			//(parent as MovieClip).gotoAndStop(1, "Game");
			parent.dispatchEvent(new Event("start_game",true,false));
		}
	}
	
}
