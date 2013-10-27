package {
	
	import flash.display.SimpleButton;
	
	
	public class unit_thief extends unit{
		
		protected var treasure:int = 0;
		public function setTreasure(v:int):void{
			treasure = v;
		}
		public function addTreasure(v:int = 1):void{
			treasure += v;
		}
		public function getTreasure():int{
			return treasure;
		}

		public function unit_thief() {
			super("Player");
			movementRange = 9000;
		}
	}
	
}
