package HFSM 
{
	/**
	 * ...
	 * @author Kevin
	 */
	public class Result 
	{
		
		public function Result() 
		{
			public var actions:Array;
			public var trans:Transition;
			public var level:int;
			
			public function Result(){
				actions = new Array();
				initialize();
			}
			
			public function initialize():void{
				actions.clear();
				trans = null;
			}
			
			public function getActions():Array {
				return actions;
			}

			public function addAction(a:Function):void{
				if (a != null){
					actions.add(a);
				}
			}
			
			public function addActions(as:Array):void{
				for (IAction a: as){
					addAction(a);
				}
			}
		}
		
	}

}