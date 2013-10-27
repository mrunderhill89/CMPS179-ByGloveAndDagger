package  {
	
	import flash.display.SimpleButton;
	
	
	public class treasure extends tile_element {
		protected var collected:Boolean = false;
		public function treasure() {
			super();
		}
		
		public override function _unitApproach(ue:UnitEvent):void {
			if (collected == false && ue.un is unit_thief){
				trace("Treasure Get");
				collected = true;
				(ue.un as unit_thief).addTreasure();
			}
		}
	}
	
}
