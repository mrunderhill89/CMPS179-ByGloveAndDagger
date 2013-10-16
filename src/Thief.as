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
			//graphic = s;
			//addChild(s);
		}
		public function Thief(t1:Tile, f:Faction): void {
			this.currTile = t;
			//f.addThief(this);
			
		}
		public function setTile(t:Tile):void
		{
		this.currTile = t;
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
		public function getTile(): Tile {
			return this.currTile;
		}
		public function setHealth(h:int): void
		{
			this.health = h;			
		}
		public function getHealth(): int {
			return this.health;
		}
		public function attack(g:Guard): void
		{
			var temp:int = g.health;
			temp = temp - 2;
			g.setHealth(temp);
		}
		public function canAttack(g:Guard):Boolean
		{
			return true;
		}
	}
}
	
