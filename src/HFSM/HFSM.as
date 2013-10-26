package HFSM 
{
	import flash.utils.Dictionary;
	import HFSM.Result;
	import HFSM.Transition;
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Kevin
	 */
	public class HFSM 
	{
		//State attributes
		protected var name:String;
		protected var onEntry:Function;
		public function setEntryAction(f:Function):void{onEntry = f;}
		public function getEntryAction():Function{return onEntry;}
		
		protected var onUpdate:Function;
		public function setUpdateAction(f:Function):void{onUpdate = f;}
		public function getUpdateAction():Function{return onUpdate;}
		
		protected var onExit:Function;
		public function setExitAction(f:Function):void{onExit = f;}
		public function getExitAction():Function{return onExit;}
		
		//Machine attributes
		protected var subStates:Dictionary;
		protected var transitions:Array;
		protected var current:HFSM;
		protected var initial:HFSM;
		protected var parent:HFSM;
		protected var level:int;
		protected var clip:MovieClip;
		//Creates a sub-machine using another HState as a parent
		public function HFSM(n:String = "root", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) {
			subStates = new Dictionary();
			transitions = new Array();
			onEntry = null;
			onUpdate = null;
			onExit = null;
			current = null;
			initial = null;
			parent = null;
			name = n;
			level = 0;			
			name = n;
			clip = c;
			if (p != null){
				//Set parent and level
				parent = p;
				level = p.level + 1;
				if (clip == null){
					clip = parent.clip;
				}
				//If specified or there are no other states, make this one the initial state. 
				if (makeInitial || p.initial == null){
					p.initial = this;
				}
				//Add this state to the parent's children.
				p.subStates[n] = this;
			}
		}
	
		public function getName():String{
			return name;
		}
	//Returns a child state by name
		public function getChild(name:String):HFSM{
			return subStates[name];
		}
		
	//Returns the currently active state
		public function getCurrentState():HFSM{
			return current;
		}
		
	//Forces the HFSM to switch to this state. Better to use transitions most of the time.
		public function setCurrentState(c:HFSM){
			current = c;
		}
		
	public function update(result:Result = null):Result {
		if (result == null) {
			result = new Result();
		}
		//If we're starting from scratch, enter the initial state.
		if (current == null){
			if (isEmpty()){
				//This is a leaf state and has no children, so just return its own update action.
				result.addAction(onUpdate);
			} else if (initial != null){
				current = initial;
				/*We don't have multiple return types, so load the initial
				/*  state's actions into the result and do nothing else.  */
				result.addAction(current.onEntry);
			}
		} else {
			//Try to find a transition in the current state.
			var triggered:iTransition = null;
			for (var t:String in current.transitions) {
				var trans:iTransition = current.transitions[t];
				if (trans.isTriggered()){
					triggered = trans;
					break;
				}
			}
			//If we've found one, load it into the result struct.
			if (triggered != null){
				result.trans = triggered;
				result.level = triggered.getLevel();
			} else {
				//Otherwise recurse down for a result.
				result = current.update();
			}
			//Check if the result contains a transition.
			if (result.trans != null){
				//Act based on its level
				//Note: this is not the same order as in the book.
				if (result.level > 0){
					//Transition destined for higher level.
					result.addAction(current.onExit);
					//Reset the state if the transition calls for it.
					if (!result.trans.rememberState())
						current = null;
					result.level -= 1;
				} else {
					//Both same- and lower-level transitions share some code.
					var target:HFSM = result.trans.getTarget();
					if (result.level == 0){
						//Transition is on the same level.
						result.addAction(current.onExit);
						result.addAction(result.trans.getAction());
						result.addAction(target.onEntry);
						
						current = target;
						result.addAction(target.onUpdate);
					} else {
						//Transition is on lower level.
						var targetMachine:HFSM = target.parent;
						result.addAction(result.trans.getAction());
						result.addActions(targetMachine.updateDown(target, -result.level));
					}
					result.trans = null;
				}
			}
		}
		return result;
	}
	
	public function getActions():Array{
		return update().actions;
	}
	
	public function updateDown(state:HFSM, level:int):Array{
		var actions:Array = new Array();
		//If we're not at the top level, continue recursing
		if (level > 0){
			actions.addAll(parent.updateDown(this, level-1));
		}
		//If we're in a state, exit it.
		if (current != null){
			actions.add(current.onExit);
		}
		current = state;
		actions.add(state.onEntry);
		return actions;
	}
	
	public function getLevel():int{
		return level;
	}
	
	public function addTransition(t:iTransition):void {
		transitions.push(t);
	}
	
	public function isEmpty():Boolean
	{
		for each(var obj:Object in subStates)
		{
			if(obj != null)
			{
			   return false
			}
		}
		return true;
	}
	
	public function isActive():Boolean {
		if (parent == null)
			return true; //root states are always active
		if (parent.current != this)
			return false;
		return parent.isActive();
	}
	}
}