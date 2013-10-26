package HFSM 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * ...
	 * @author Kevin
	 */
	public class EventTransition implements iTransition 
	{
		protected var target:HFSM;
		protected var host:HFSM;
		public function getTarget():HFSM {
			return target;
		}
		protected var action:Function;
		protected var condition:String;
		protected var triggered:Boolean;
		protected var level:int;
		//Should the previous machine remember its current state?
		protected var memory:Boolean;
		
		public function EventTransition(from:HFSM, to:HFSM, dispatcher:IEventDispatcher, c:String , a:Function = null, m:Boolean = false) {
			target = to;
			host = from;
			action = a;
			condition = c;
			memory = m;
			level = from.getLevel();
			if (to != null)
			 level -= to.getLevel();
			from.addTransition(this);
			dispatcher.addEventListener(condition, trigger);
		}

		public function getAction():Function {
			return action;
		}

		public function setCondition(c:String):void {
			this.condition = c;
		}

		public function isTriggered(thisArg:Object = null, argArray:Array = null):Boolean {
			var tempTrigger:Boolean = triggered;
			triggered = false; //Prevent trigger from repeating
			return tempTrigger;
		}
		
		public function trigger( e:Event ):void {
			if (target != null && host.isActive()){
				triggered = true;
			}
		}
			
		public function rememberState():Boolean {
			return memory;
		}
		
		public function getLevel():int{
			return level;
		}
	}		
}