package  {
	
	import Factions.Faction;
	import Factions.Player;
	import flash.automation.StageCaptureEvent;
	import flash.display.Loader;
	import flash.display.Sprite;
    import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
    import flash.text.TextField;
    import flash.text.TextFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.events.Event;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.system.Capabilities;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import HFSM.EventTransition;
	import HFSM.HFSM;
	
	public class Level1 extends MovieClip {
		protected var states:HFSM;
		protected var HUD:Loader;
		protected var cameraVelocity:Point = new Point(0,0);
		protected var debug:TextField;
	
		public function Level1() {
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
		}
		
		private function initialize(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, initialize);
		
			
		//Debug text field allows us to see what's going on.
		debug = new TextField();
		debug.text = "Debug Text";
		debug.x = 0;
		debug.y = 0;
		addChild(debug);
		
		//Set up factions.
		states =  new HFSM("root", null, this);
		var player:Player = new Player(states);
		var guards:Faction = new Faction("Enemy", states);
		
		var continueGame:Boolean = true;
		this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		
		private function _onUpdate( e:Event ):void
		{
			//Handle state machine
			var stateActions:Array = states.update().getActions();
			for (var ai:String in stateActions) {
				var a:Function = stateActions[ai];
				a.apply();
			}
		}
	}
	
}
