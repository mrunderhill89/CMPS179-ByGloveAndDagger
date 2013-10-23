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
			length++;
			values.push(new Entry(data, p));
			decreaseKey(length, p);
		}
		
		public function find(data:Object):int {
			var entry:Entry = null;
			//Find where object is in the queue
			for (var e:int = 0; e < values.length; e++) {
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
					var p:int = Math.floor(e / 2);
					while (p > 0 && values[p].priority > values[e].priority) {
						swap(p, e);
						e = p;
						p = Math.floor(e / 2);
					}
				}
			}
		}
		
		public function increaseKey(e:int, priority:Number):void {
			var entry:Entry = values[e];
			if (entry != null) {
				if (entry.priority < priority) {
					entry.priority = priority;
					var c:int = minKey(e);
					while (c < length && values[c].priority < values[e].priority) {
						swap(c, e);
						e = c;
						c = minKey(e);
					}
				}
			}
		}
		
		public function getMin():Object {
			return values[0].data;
		}
		
		public function removeMin():void {
			swap(0, length - 1);
			if (length > 0){
				length--;
				increaseKey(0, values[0].priority);
			}
		}
		
		protected function minKey(p:int):int {
			var left:int = 2 * p;
			var right:int = left + 1;
			if (left >= length) {
				return length;
			} else if (right >= length || values[left].priority < values[right].priority) {
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
    }
}
