package  {
	import HFSM.HFSM;
	import flash.display.MovieClip;
	
	public class GameScreen extends HFSM{
		protected var scene:String;
		public function GameScreen(n:String = "root", s:String = "scene", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) {
			super(n,p,c, makeInitial);
			scene = s;
			setEntryAction(_onEntry);
			setExitAction(_onExit);
		}

		protected function _onEntry():void{
			trace("Entering Game Screen");
			clip.gotoAndStop(1,"Start");
			clip.stop();
		}
		
		protected function _onExit():void{
			trace("Exiting Game Screen");
			clip.gotoAndStop(1,"Game");
			clip.stop();
		}
	}
	
}
