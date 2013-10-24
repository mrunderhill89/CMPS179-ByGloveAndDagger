package
    {
    import flash.events.Event;
     
	/**
	 * ...
	 * @author Kevin
	 */
    public class UnitEvent extends Event
    {
		public static const UNIT_MOUSEOVER:String = "unit_mouseover";
		public static const UNIT_MOUSEOUT:String = "unit_mouseout";
		public static const UNIT_CLICKED:String = "unit_clicked";
		public static const UNIT_RIGHT_CLICKED:String = "unit_rclicked";
		public static const UNIT_APPROACH_TILE:String = "unit_approach_tile";
		public var un:unit;
		public function UnitEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, u:unit = null)
		{
			super(type, bubbles, cancelable);
			un = u;
		}	
    }
}