package Factions 
{
	import HFSM.HFSM;
	import HFSM.Transition;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kevin
	 */
	public class Faction extends HFSM
	{
		protected var units:Array;
		protected var select:HFSM;
		protected var move:HFSM;
		protected var unitAction:HFSM;

		public function Faction(n:String = "Faction", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) {
			super(n, p, c, makeInitial);
			units = new Array();
			this.onEntry = startTurn;
			select = new HFSM("select", this, null, true);
			move = new HFSM("move", this);
			unitAction = new HFSM("action", this);
			setEntryAction(startTurn);
		}
		
		public function startTurn():void {
			trace(name + " Phase");
			clip.dispatchEvent(new FactionEvent(this,FactionEvent.FACTION_START_TURN));
		}
		
		public function addUnit(un:unit):void{
			units.push(un);
		}
		
		public function noAvailableUnits():Boolean {
			for (var u:String in units) {
				var un:unit = units[u];
				if (!un.hasMoved()) {
					return false;
				}
			}
			return true;
		}
	}	
}