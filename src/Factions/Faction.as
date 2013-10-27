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
			select = new HFSM("select", this, null, true);
			move = new HFSM("move", this);
			unitAction = new HFSM("action", this);
			setEntryAction(startTurn);
			clip.dispatchEvent(new FactionEvent(this, FactionEvent.FACTION_INIT));
		}
		
		public function startTurn():void {
			trace(name + " Phase");
			clip.dispatchEvent(new FactionEvent(this,FactionEvent.FACTION_START_TURN));
		}
		
		public function addUnit(un:unit):void{
			units.push(un);
		}
		
		public function updateVisibilities(){
			var un:unit;
			for (var ui:String in unit.getInstances()){
				un = unit.getInstances()[ui];
				if (un != null){
					un.visible = this.canSeeUnit(un);
				}
			}
		}
		
		public function canSeeUnit(un:unit){
			//Dead units are never visible. (Unless it's Halloween!)
			if (!un.isAlive()){
				return false;
			}
			//Players can always see their own units.
			if (un.factionName == name)
				return true;
			//Units standing on torches are always visible.
			if (un.getTile().hasTorch())
				return true;
			//If both checks fail, see if any of the faction's units can see the target.
			var mu:unit;
			for (var mui:String in this.units){
				mu = units[mui];
				if (mu.canSpotUnit(un)){
					return true;
				}
			}
			return false;
		}
		
		public function loadUnits(){
			var un:unit;
			for (var ui:String in unit.getInstances()){
				un = unit.getInstances()[ui];
				un._registerFaction(null,this);
			}
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