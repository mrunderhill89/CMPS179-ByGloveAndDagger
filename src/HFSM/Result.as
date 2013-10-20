package HFSM 
{
	/**
	 * ...
	 * @author Kevin
	 */
	public class Result 
	{
		public var actions:Array;
		public var trans:iTransition;
		public var level:int;		
		public function Result(){
			actions = new Array();
			initialize();
		}
		
		public function initialize():void{
			actions.splice(0);
			trans = null;
		}
		
		public function getActions():Array {
			return actions;
		}

		public function addAction(a:Function):void{
			if (a != null){
				actions.push(a);
			}
		}
		
		public function addActions(newActions:Array):void{
			for (var a:String in newActions){
				addAction(newActions[a]);
			}
		}		
	}

}