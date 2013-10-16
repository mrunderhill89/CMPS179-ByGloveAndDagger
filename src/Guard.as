package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author AndyDrew
	 */
	public class Guard extends Sprite 
	{
		public var hasMoved:Boolean = false;
		public var treasure:int = 0;
		public var currTile:Tile;
		public var health:int = 5;
		public var targetTiles:Array = new Array();
		
		
		public function Guard(f:Faction, t:Tile):void
		{
			//f.addGuard(this);
			this.currTile = t;
				
		}
		public function getTile():Tile
		{
			return this.tile;
			
		}
		private function init(s:Sprite = null):void {
			//graphic = s;
			//addChild(s);
		}
		public function setTile(t:Tile):void
		{
			this.currTile = t;
		}
		public function setHealth(h:int):void
		{
			this.health = h;
		}
		public function getHealth():int
		{
			return this.health;
			
		}
		public function attack(th:Thief):void
		{
			var temp:int = th.getHealth();
			temp = temp - 2;
			th.setHealth(temp);
		}
	}
}