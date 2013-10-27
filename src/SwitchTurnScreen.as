package  {
	import Factions.Faction;
	import HFSM.HFSM;
	import flash.display.MovieClip;
	
	public class SwitchTurnScreen extends GameScreen {
		protected var factionTo:Faction;
		public function SwitchTurnScreen(to:Faction, n:String = "Switch", s:String = "Scene", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) {
			super(n,s,p,c,makeInitial);
			factionTo = to;
		}
	}
	
}
