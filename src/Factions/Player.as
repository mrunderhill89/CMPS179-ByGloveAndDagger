package Factions 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import HFSM.EventTransition;
	import HFSM.HFSM;
	import HFSM.Transition;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Loader;
	import tile_default;
	/**
	 * ...
	 * @author Kevin
	 */
	public class Player extends Faction 
	{
		protected var cameraVelocity:Point = new Point(0, 0);
		protected var cameraBounds:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var currentUnit:unit = null;
		public function Player(p:HFSM, makeInitial:Boolean = false) 
		{
			super("Player", p, makeInitial);
			setExitAction(exit);
			select.setEntryAction(selectEntry);
			select.setUpdateAction(selectUpdate);
			select.setExitAction(selectExit);
			
			var selectToMove:Transition = new Transition(select, move, function():Boolean { return currentUnit !=  null; }, function():void { trace("Unit Selected"); } );
			var moveToSelect:Transition = new Transition(move, select, function():Boolean { return currentUnit ==  null; }, function():void { trace("Unit Deselected"); } );
			/*
			var unitSelected:EventTransition = new EventTransition(select, move, UnitEvent.UNIT_CLICKED
															, function(): void { trace("Unit Selected"); } ); 
			var allUnitsExhausted:Transition = new Transition(select, parent.getChild("Enemy"), noAvailableUnits
															, function():void {trace("All Units Exhausted");} );
			var endTurnManually:EventTransition = new EventTransition(select, parent.getChild("Enemy"), Game.END_TURN);
			*/
			move.setEntryAction(moveEntry);
			move.setUpdateAction(moveUpdate);
			move.setExitAction(moveExit);

			unitAction.setEntryAction(unitEntry);
			unitAction.setUpdateAction(unitUpdate);
			unitAction.setExitAction(unitExit);
			
			Game.getInstance().getLevel().addEventListener(Event.ADDED_TO_STAGE, loadUnits);
			//Game.getInstance().addEventListener(UnitEvent.UNIT_CLICKED, _selectUnit);
			//Game.getInstance().addEventListener(TileEvent.TILE_CLICKED, _selectTile);
			
		}
		
		public function loadUnits( e:Event):void {
			trace ("Player loading units");
			for (var u:String in unit.getInstances()) {
				var un:unit = unit.getInstances()[u];
				if (un.factionName == "thief") {
					this.units.push(un);
					trace("Adding thief unit:" + un.name);
				}
			}
			if (units.length <= 0) {
				trace("Warning, no Player units found");
			}
		}
		
		public function selectEntry():void {
			trace("Select Unit");
		}
		
		public function selectUpdate():void {
		}

		protected function _selectUnit(ue:UnitEvent):void {
			if (currentUnit == null && select.isActive()) {
				if (ue.un.factionName == name) {
					currentUnit = ue.un;
				}
			}
		}

		protected function _selectTile(te:TileEvent):void {
			if (move.isActive()) {
				if (te.getTile().getUnit() == null) {
					currentUnit.move(te.tile);
					currentUnit = null;
				}
			}
		}
		
		public function selectExit():void {
		}
		
		public function scrollCamera():void {
			var game:Game = Game.getInstance();
			var gameLevel:Loader = game.getLevel();
			if (gameLevel != null) {
				gameLevel.x = Math.max(gameLevel.x + cameraVelocity.x, 0);
				gameLevel.y = Math.max(gameLevel.y + cameraVelocity.y, 0);
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
		
		public function moveEntry():void {
			trace("Move Unit");
		}
		
		public function moveUpdate():void {
			scrollCamera();
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
		
		public function exit():void {
			trace("End Player Phase");
		}
		
	}

}