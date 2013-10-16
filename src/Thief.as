package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author AndyDrew
	 */
	public class  Thief extends Sprite
	{
		
		public var hasMoved:Boolean = false;
		public var treasure:int = 0;
		public var currTile:Tile;
		public var health:int = 3;
		
		private function init(s:Sprite = null):void {
			graphic = s;
			addChild(s);
		}
		public function Thief(f:Faction, t:Tile): void {
			this.x = t.x;
			this.y = t.y;
			this.currTile = t;
			//f.addThief(this);
			
		}
		public function moveTo(t1:Tile, t2:Tile, end:Boolean): void {
			this.x = t1.x;
			this.y = t1.y;
			this.currTile = t1;
			if (t2 != null) {
				this.x = t2.x;
				this.y = t2.y;
				this.currTile = t2;
			}
			if (end) { 
				hasMoved = true; 
				//f.moveOver(this);
			}
		}
		public function getTile(): int {
			//return this.currTile.ID;
		}
	}
}
	
