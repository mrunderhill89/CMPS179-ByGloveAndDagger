package HFSM 
{
	import flash.utils.Dictionary;
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
	
		//Creates a new root state.
		public HFSM(n:String){
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
		}
	
	//Creates a sub-machine using another HState as a parent
		public function HFSM(n:String, p:HFSM, makeInitial:Boolean){
			this(n);
			//Set parent and level
			parent = p;
			level = p.level + 1;
			//If specified or there are no other states, make this one the initial state. 
			if (makeInitial || p.subStates.isEmpty()){
				p.initial = this;
			}
			//Add this state to the parent's children.
			p.subStates.put(n, this);
		}
	
	//Simplification of the above constructor.
		public function HFSM(n:String, p:HFSM){
			this(n, p, false);
		}
	
	//Returns a child state by name
		public function HFSM getChild(name:String){
			return subStates.get(name);
		}
	
	//Generate a new result for updating.
	public function update():Result{
		Result result = new Result();
		return update(result);
	}
	
	public Result update(Result result){
		//If we're starting from scratch, enter the initial state.
		if (current == null){
			if (subStates.isEmpty()){
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
			HTransition triggered = null;
			for (HTransition trans: current.transitions){
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
					if (!result.trans.memory)
						current = null;
					result.level -= 1;
				} else {
					//Both same- and lower-level transitions share some code.
					HFSMFull target = result.trans.getTarget();
					if (result.level == 0){
						//Transition is on the same level.
						result.addAction(current.onExit);
						result.addAction(result.trans.getAction());
						result.addAction(target.onEntry);
						
						current = target;
						result.addAction(target.onUpdate);
					} else {
						//Transition is on lower level.
						HFSMFull targetMachine = target.parent;
						result.addAction(result.trans.getAction());
						result.addActions(targetMachine.updateDown(target, -result.level));
					}
					result.trans = null;
				}
			}
		}
		return result;
	}
	
	public ArrayList<IAction> getActions(){
		return update().actions;
	}
	
	public ArrayList<IAction> updateDown(HFSMFull state, int level){
		ArrayList<IAction> actions = new ArrayList<IAction>();
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
	
	public int getLevel(){
		return level;
	}
		}
		
	}

}