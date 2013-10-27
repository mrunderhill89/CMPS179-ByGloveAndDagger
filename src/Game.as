package 
{
	
	/**
	 * ...
	 * @author Kevin
	 */
	import Factions.Faction;
	import Factions.Player;
	import flash.automation.StageCaptureEvent;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
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
	import HFSM.EventTransition;
	import HFSM.HFSM;
	
	Security.allowDomain("*");
	Security.allowInsecureDomain("*");

	public class Game extends Sprite
   {
	protected var level:Loader;
	protected var states:HFSM;
	protected var HUD:Loader;
	protected var cameraVelocity:Point = new Point(0,0);
	protected var debug:TextField;
	
	protected static var instance:Game = null;
	public var kongregate:*;
	public static function getInstance():Game {
		if (instance == null)
			instance = new Game();
		return instance;
	}
	public function getLevel():Loader {
		return level;
	}
	public function Game() : void {
		states = new HFSM();
		if(stage) {
			initialize();
		} else {
			addEventListener(Event.ADDED_TO_STAGE,initialize);
		}
	} 
	
	private function _onUpdate( e:Event ):void
		{
			debug.text = "(" + mouseX + "," + mouseY + ")" + "[" + stage.stageWidth + "," + stage.stageHeight + "]";
		}
		
	private function _onEndTurn( e:Event):void 
		{
		}

	
    private function initialize(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, initialize);
		
			
		//Debug text field allows us to see what's going on.
		debug = new TextField();
		debug.text = "Debug Text";
		debug.x = 0;
		debug.y = 0;
		addChild(debug);

		
		//Set up level.
		level = new Loader();
		addChild(level);
		var url:URLRequest = new URLRequest("../levels/level1.swf");
		var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
		level.load(url, loaderContext);
    }
   }	   
}