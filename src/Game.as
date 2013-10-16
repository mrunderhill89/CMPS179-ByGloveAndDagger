package 
{
	
	/**
	 * ...
	 * @author Kevin
	 */
	import flash.display.Loader;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.events.Event;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	Security.allowDomain("*");
	Security.allowInsecureDomain("*");

	public class Game extends Sprite
   {
 	protected var player:Faction;
	protected var guards:Faction;
	protected var current:Faction;
	
	public function Game() : void {
		if(stage) {
			initialize();
		} else {
			addEventListener(Event.ADDED_TO_STAGE,initialize);
		}
	} 
	
	private function _onUpdate( e:Event ):void
		{
			current.updateTurn();
		}
		
		// call this when a faction has completed their turn
	private function _onEndTurn( e:Event):void 
		{
			if (current == player) {
				current = guards;
			} else {
				current = player;
			}
		}
	
    private function initialize(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, initialize);
					//Debug text field allows us to see what's going on.
			var debug:TextField = new TextField();
			debug.text = "Debug Text";
			debug.x = 0;
			debug.y = 0;
			addChild(debug);
			//Set up level.
			var loader:Loader = new Loader();
			addChild(loader);
			var url:URLRequest = new URLRequest("../levels/level1.swf");
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			loader.load(url, loaderContext);
			//Set up factions.
			player = new Faction();
			guards = new Faction();
			current = player;
			
			//Set up units


			//Main loop:
			//Call startTurn on current faction
			//Continuously call updateTurn on current faction until false
			//Check for win/loss conditions
			//If win/lose: break loop
			//Switch factions (player->guards->player, etc.)
			var continueGame:Boolean = true;
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
			current.startTurn();
    }
   }
}