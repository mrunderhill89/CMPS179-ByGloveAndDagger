package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kevin
	 */
	public class Tile extends Sprite
	{
		protected var graphic:Sprite;
		private function init(s:Sprite = null):void {
			graphic = s;
			addChild(s);
		}
	}
	
}