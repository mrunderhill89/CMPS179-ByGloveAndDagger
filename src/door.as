package  {
	import Factions.Player;
	public class door extends tile_element{

		public function door(){
			super();
		}

		public override function _unitApproach(ue:UnitEvent):void{
			if (ue.un != null && ue.un is unit_thief){
				var thief:unit_thief = ue.un as unit_thief;
				if (thief != null){
					trace("Dropped off "+thief.getTreasure()+" treasure.");
					if (thief is unit_hero && thief.getTreasure()>0){
						Level1.getInstance().dispatchEvent(
							new FactionEvent(Level1.getInstance().getFaction("Player"), 
											 FactionEvent.FACTION_VICTORY)
							);
					}
					thief.setTreasure(0);
				} else {
					trace("Couldn't identify "+ue.un+" as a thief.");
				}
			}
		}
	}
	
}
