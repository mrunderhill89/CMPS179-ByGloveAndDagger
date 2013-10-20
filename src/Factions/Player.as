package Factions 
{
	import flash.display.Loader;
	import HFSM.HFSM;
	import HFSM.Transition;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Kevin
	 */
	public class Player extends Faction 
	{
		protected var currentUnit:unit;
		protected var cameraVelocity:Point = new Point(0, 0);
		
		public function Player(p:HFSM, makeInitial:Boolean = false) 
		{
			super("Player", p, makeInitial);
			select.setEntryAction(selectEntry);
			select.setUpdateAction(selectUpdate);
			select.setExitAction(selectExit);
			
			var unitSelected:Transition = new Transition(select, move, function() : Boolean { return currentUnit != null;} ); 
			
			move.setEntryAction(moveEntry);
			move.setUpdateAction(moveUpdate);
			move.setExitAction(moveExit);

			unitAction.setEntryAction(unitEntry);
			unitAction.setUpdateAction(unitUpdate);
			unitAction.setExitAction(unitExit);
			
			Game.getInstance().addEventListener("tile_highlight", highlightTile);
			Game.getInstance().addEventListener("tile_dehighlight", dehighlightTile);
		}
		
		public function selectEntry():void {
			trace("Select Unit");
			currentUnit = null;
		}
		
		public function selectUpdate():void {
			scrollCamera();
		}

		public function selectExit():void {
			
		}
		
		public function scrollCamera():void {
			var game:Game = Game.getInstance();
			var gameLevel:Loader = game.getLevel();
			if (gameLevel != null) {
				gameLevel.x += cameraVelocity.x;
				gameLevel.y += cameraVelocity.y;
				if (game.mouseX < game.stage.stageWidth / 10) {
					cameraVelocity.x = +10;
				} else if (game.mouseX > (game.stage.stageWidth * 9) / 10) {
					cameraVelocity.x = -10;
				} else {
					cameraVelocity.x = 0;
				}
				if (game.mouseY < game.stage.stageHeight / 10) {
					cameraVelocity.y = +10;
				} else if (game.mouseY > (game.stage.stageHeight * 9) / 10) {
					cameraVelocity.y = -10;
				} else {
					cameraVelocity.y = -0;
				}
			}
		}
		
		public function highlightTile( te:tile_event):void {
			te.tile.highlight();
		}

		public function dehighlightTile( te:tile_event):void {
			te.tile.dehighlight();
		}
		

		public function moveEntry():void {
			trace("Move Unit");
		}
		
		public function moveUpdate():void {
			
		}

		public function moveExit():void {
			
		}

		public function unitEntry():void {
			trace("Unit Action");
		}
		
		public function unitUpdate():void {
			
		}

		public function unitExit():void {
			
		}

	}

}