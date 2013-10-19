package HFSM 
{
	/**
	 * ...
	 * @author Kevin
	 */
	public class Transition 
	{
		protected var target:HFSM;
		public function getTarget():HFSM {
			return target;
		}
		protected var action:Function;
		protected var condition:Function;
		protected var level:int;
		//Should the previous machine remember its current state?
		protected var memory:Boolean;
		
		public function Transition(from:HFSM, to:HFSM, c:Function , a:Function = null, m:Boolean = false) {
			target = to;
			action = a;
			condition = c;
			memory = m;
			level = from.getLevel() - to.getLevel();
			from.transitions.push(this);
		}

		public function getAction():Function {
			return action;
		}

		public function setCondition(c:Function):void {
			this.condition = c;
		}

		public function isTriggered(thisArg:any = null, argArray:any = null):Boolean{
			if (condition == null)
				return false;
			return condition.apply(thisArg, argArray);
		}
		
		public function getLevel():int{
			return level;
		}
	}
}