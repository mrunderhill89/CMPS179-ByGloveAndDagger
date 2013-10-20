package HFSM 
{
	
	/**
	 * ...
	 * @author Kevin
	 */
	public interface iTransition 
	{
		function getTarget():HFSM;
		function getAction():Function;
		function isTriggered(thisArg:Object = null, argArray:Array = null):Boolean;		
		function rememberState():Boolean;		
		function getLevel():int;
	}
	
}