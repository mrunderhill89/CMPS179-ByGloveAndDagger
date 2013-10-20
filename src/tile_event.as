package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kevin
	 */
	[Event(name = "tile_on", type = "tile_on")]
	[Event(name="tile_off", type="tile_off")]
	[Event(name="tile_clicked", type="tile_clicked")]
	public class tile_event extends Event 
	{
		public var tile:tile_default;
		public var mouseEvent:MouseEvent;
		
		public static var TILE_ON:tile_event = new tile_event("tile_on");
		public static var TILE_OFF:tile_event = new tile_event("tile_off");		
		public static var TILE_CLICKED:tile_event = new tile_event("tile_clicked");
		
		public function tile_event(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			tile = null;
			mouseEvent = null;
		}
	}
}