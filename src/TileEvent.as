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

		public var tile:tile_default;
		public function TileEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, t:tile_default =  null)
		{
			super(type, bubbles, cancelable);
			tile = t;
		}	
    }
}