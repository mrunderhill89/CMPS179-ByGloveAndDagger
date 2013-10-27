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
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	
	public class Level1 extends MovieClip {
		protected var states:HFSM;
		protected var factions:Dictionary = new Dictionary();
		protected var HUD:Loader;
		protected var cameraVelocity:Point = new Point(0,0);
		public static const PLAYER_1_NAME = "Player";
		public static const PLAYER_2_NAME = "Guards";
		public var kongregate:*;
				public function loadComplete(e:Event):void
		{
			kongregate = e.target.content;
			kongregate.services.connect();
		}
		
		public function Level1() {
			if (stage) {
				initialize();
			} else {
				stage.addEventListener(Event.COMPLETE, initialize);
			}
		}
		
		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			//Setup Kongregate API
		
		// Pull the API path from the FlashVars
		var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;

		// The API path. The "shadow" API will load if testing locally. 
		var apiPath:String = paramObj.kongregate_api_path || 
		"http://www.kongregate.com/flash/API_AS3_Local.swf";

		// Allow the API access to this SWF
		Security.allowDomain(apiPath);

		// Load the API
		var request:URLRequest = new URLRequest(apiPath);
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
		loader.load(request);
		this.addChild(loader);
			
			//Set up factions.
			states =  new HFSM("root", null, this);
			var startScreen:GameScreen = new GameScreen("StartScreen","Start",states,this,true);
			factions["Player"] = new Player("Player", states);
			factions["Guards"] = new Player("Guards", states);
			trace("Factions Initialized.");
			var startToGame:EventTransition = new EventTransition(startScreen, factions["Player"], this, "start_game");
			
			var playerToGuards:EventTransition = new EventTransition(factions["Player"], factions["Guards"], this, FactionEvent.FACTION_END_TURN);
			var guardsToPlayer:EventTransition = new EventTransition(factions["Guards"], factions["Player"], this, FactionEvent.FACTION_END_TURN);
			
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
		
		private function _switchPlayer( fe:FactionEvent = null){
			if (fe.faction == factions["Player"]){
				states.setCurrentState(factions["Guards"]);
			} else {
				states.setCurrentState(factions["Player"]);
			}
		}
		
		public function _endTurnButton( me:MouseEvent){
			dispatchEvent(new FactionEvent(states.getCurrentState() as Faction, FactionEvent.FACTION_END_TURN));
		}
		
		public function getFaction(name:String):Faction{
			return factions[name];
		}
	}
}
