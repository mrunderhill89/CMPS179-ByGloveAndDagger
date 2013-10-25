package DataStructures.PriorityQueue 
{
	/**
	 * ...
	 * @author Kevin
	 */
	internal class Entry
	{
		public var priority:Number;
		public var data:Object;
		public function Entry(d:Object, p:Number) {
			priority = p;
			data = d;
		}
		public function toString():String {
			return "Data:" + data.toString() + "\nPriority:" + priority.toString();
		}
	}
}