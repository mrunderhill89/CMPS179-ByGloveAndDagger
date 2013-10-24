package  {
	
	import flash.display.SimpleButton;
	
	
	public class treasure extends tile_element {
		protected var collected:Boolean = false;
		protected static var totalCollected:int = 0;
		public function treasure() {
			super();
		}
		
		public function _onUnitApproach(ue:UnitEvent):void {
			if (ue.un.factionName == "Player"){
				collected = true;
				totalCollected++;
				//(ue.un as unit_thief).addTreasure();
			}
		}
	}
	
}
