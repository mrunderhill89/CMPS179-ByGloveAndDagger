package Factions 
{
	import HFSM.HFSM;
	import HFSM.Transition;
	
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

		public function Faction(n:String = "root", p:HFSM = null, makeInitial:Boolean = false) {
			super(n, p, makeInitial);
			units = new Array();
			this.onEntry = startTurn;
			select = new HFSM("select", this, true);
			move = new HFSM("move", this);
			unitAction = new HFSM("action", this);
			select.setEntryAction(startTurn);
		}
		
		public function startTurn():void {
			trace(name + " Phase");
		}
	}	
}