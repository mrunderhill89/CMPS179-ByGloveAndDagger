package DataStructures.PriorityQueue{
	     
	/**
	 * ...
	 * @author Kevin
	 */

    public class PriorityQueue
    {
		protected var values:Array;
		protected var length:int;
		public function PriorityQueue() {
			values = new Array();
			length = 0;
		}
		
		public function clear():void {
			values.splice(0);
			length = 0;
		}
		
		public function insert(data:Object, p:Number):void {
			values[length] = new Entry(data, p);
			decreaseKey(length, p);
			length++;
		}
		
		//Searches the priority queue for a specifc object.
		//This is an O(n) operation, so use sparingly.
		public function find(data:Object):int {
			var entry:Entry = null;
			//Find where object is in the queue
			for (var e:int = 0; e < length; e++) {
				entry = values[e];
				if (entry.data == data)
					break;
			}
			if (entry == null)
				return -1;
			return e;
		}
		
		public function decreaseKey(e:int, priority:Number):void {
			var entry:Entry = values[e];
			if (entry != null) {
				if (entry.priority > priority) {
					entry.priority = priority;
				}
				var p:int = parent(e);
				var f:int = e;
				while (f > 0 && values[p].priority > values[f].priority) {
					swap(p, f);
					f = p;
					p = parent(f);
				}
			}
		}
		
		public function increaseKey(e:int, priority:Number):void {
			var entry:Entry = values[e];
			if (entry != null) {
				if (entry.priority < priority) {
					entry.priority = priority;
				}
				var f:int = e;
				var c:int = minKey(e);
				while (c < length && values[c].priority < values[f].priority) {
					swap(c, f);
					f = c;
					c = minKey(f);
				}
			}
		}
		
		public function getMin():Object {
			if (length <= 0)
				return null;
			return values[0].data;
		}
		
		public function removeMin():void {
			if (length > 0){
				swap(0, length - 1);
				length--;
				increaseKey(0, values[0].priority);
			}
		}
		
		protected function parent(c:int):int{
			return Math.floor((c-1)/2);
		}
		
		protected function leftChild(p:int):int{
			return (p*2)+1;
		}

		protected function rightChild(p:int):int{
			return (p*2)+2;
		}
		
		protected function minKey(p:int):int {
			var left:int = leftChild(p);
			var right:int = rightChild(p);
			if (left >= length) {
				return length;
			} else if (right >= length || values[left].priority <= values[right].priority) {
				return left;
			} else {
				return right;
			}
		}
		
		protected function swap(a:int, b:int):void {
			var c:Entry = values[a];
			values[a] = values[b];
			values[b] = c;
		}
		
		public function getLength():int {
			return length;
		}
		
		public function toString():String{
			var out:String = "";
			for (var e:int = 0; e < values.length; e++) {
				out = out.concat("Entry ",e, ":", values[e],"\n");
				if (e == length){
					out = out.concat("(Inactive)\n");
				}
			}
			return out;
		}
    }
}
