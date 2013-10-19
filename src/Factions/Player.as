package Factions 
{
	import HFSM.HFSM;
	import HFSM.Transition;
	/**
	 * ...
	 * @author Kevin
	 */
	public class Player extends Faction 
	{
		protected var currentUnit:unit;
		public function Player(p:HFSM, makeInitial:Boolean = false) 
		{
			super("Player", p, makeInitial);
			select.setEntryAction(selectEntry);
			select.setUpdateAction(selectUpdate);
			select.setExitAction(selectExit);
			
			var unitSelected:Transition = new Transition(select, move, function() : Boolean { return currentUnit != null;} ); 
			
			move.setEntryAction(moveEntry);
			move.setUpdateAction(moveUpdate);
			move.setExitAction(moveExit);

			unitAction.setEntryAction(unitEntry);
			unitAction.setUpdateAction(unitUpdate);
			unitAction.setExitAction(unitExit);
			
		}
		
		public function selectEntry():void {
			trace("Select Unit");
			currentUnit = null;
		}
		
		public function selectUpdate():void {
		}

		public function selectExit():void {
			
		}

		public function moveEntry():void {
			trace("Move Unit");
		}
		
		public function moveUpdate():void {
			
		}

		public function moveExit():void {
			
		}

		public function unitEntry():void {
			trace("Unit Action");
		}
		
		public function unitUpdate():void {
			
		}

		public function unitExit():void {
			
		}

	}

}