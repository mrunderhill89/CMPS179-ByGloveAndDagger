package
    {
    import flash.events.Event;
     
	/**
	 * ...
	 * @author Kevin
	 */
    public class TileEvent extends Event
    {
		public static const TILE_MOUSEOVER:String = "tile_mouseover";
		public static const TILE_MOUSEOUT:String = "tile_mouseout";
		public static const TILE_CLICKED:String = "tile_clicked";
		public static const TILE_RIGHT_CLICKED:String = "tile_rclicked";
		public static const TILE_ADDED:String = "tile_added";
		
		public var tile:tile_default;
		public function TileEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, t:tile_default =  null)
		{
			super(type, bubbles, cancelable);
			tile = t;
		}	
		
		public function getTile():tile_default {
			return tile;
		}
    }
}