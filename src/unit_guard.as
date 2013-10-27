package {
	
	import flash.display.SimpleButton;
	
	
	public class unit_guard extends unit {
		public function unit_guard() {
			super("Guards");
			awareness = 15;
			maxHealth = 3;
			health = 3;
			movementRange = 1;
		}
	}
	
}
