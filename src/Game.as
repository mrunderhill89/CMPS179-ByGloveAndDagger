package 
{
	
	/**
	 * ...
	 * @author Kevin
	 */
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
	public class Game extends Sprite
   {
    public function Main():void
		{
			//Debug text field allows us to see what's going on.
			var debug:TextField = new TextField();
			debug.text = "Debug Text";
			debug.x = 0;
			debug.y = 0;
			addChild(debug);
			//Set up level.
			//Set up tiles.
			
			//Set up factions.
			var player:Faction = new Faction();
			var guards:Faction = new Faction();
			var current:Faction = player;

			//Set up units


			//Main loop:
			//Call startTurn on current faction
			//Continuously call updateTurn on current faction until false
			//Check for win/loss conditions
			//If win/lose: break loop
			//Switch factions (player->guards->player, etc.)
			var continueGame:Boolean = true;
			while (continueGame) {
				current.startTurn();
				while (current.updateTurn()) {
				}
				current.endTurn();
				continueGame = false; //Replace with win/loss checking function later.
				if (continueGame) {
					if (current == player) {
						current = guards;
					} else {
						current = player;
					}
				}
			}
		}
	}
}