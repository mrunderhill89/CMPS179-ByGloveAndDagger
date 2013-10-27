package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import Factions.Faction;
	
	public class SwitchTurnScreen extends HudElement {
		public function SwitchTurnScreen() {
			super();
		}
		
		private function _onClick(me:MouseEvent=null){
			stop();
			//(parent as MovieClip).gotoAndStop(1, "Game");
			trace("Switching Turns");
			parent.dispatchEvent(new Event("turn_switch",true,false));
		}
	}
}
