package  {
	import Factions.Player;
	public class door {

		public function door() extends tile_event{
			super();
		}

		public override function _unitApproach(ue:UnitEvent){
			if (ue.un is unit_thief){
				var thief:unit_thief = ue.un as unit_thief;
				var player:Player = (parent as Level1).getFaction(ue.un.factionName) as Player;
				player.addTreasure(thief.getTreasure());
				thief.setTreasure(0);
				if (thief is unit_hero){
					//Thieves win.
				}
			}
		}
	}
	
}
