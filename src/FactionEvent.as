package  {
	import flash.events.Event;
	import Factions.Faction;
	
	public class FactionEvent extends Event{
		public var faction:Faction;
		public static const FACTION_INIT="faction_initialized";
		public static const FACTION_START_TURN="faction_start_turn";
		public static const FACTION_END_TURN="faction_end_turn";
		public static const FACTION_VICTORY="faction_victory";
		
		public function FactionEvent(f:Faction, type:String, bubbles:Boolean = true, cancel:Boolean = false) {
			super(type, bubbles, cancelable);
			faction = f;
		}

	}
	
}
