﻿package Factions 
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
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Kevin
	 */
	public class Player extends Faction 
	{
		protected var cameraVelocity:Point = new Point(0, 0);
		protected var cameraBounds:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var currentUnit:unit = null;
		public function Player(n:String = "Player", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) 
		{
			super(n, p, c, makeInitial);
			setExitAction(exit);
			select.setEntryAction(selectEntry);
			select.setUpdateAction(selectUpdate);
			select.setExitAction(selectExit);
			
			var selectToMove:Transition = new Transition(select, move, function():Boolean { return currentUnit !=  null; }, function():void { trace("Unit Selected"); } );
			var moveToSelect:Transition = new Transition(move, select, function():Boolean { return currentUnit ==  null; }, function():void { trace("Unit Deselected"); } );
			
			move.setEntryAction(moveEntry);
			move.setUpdateAction(moveUpdate);
			move.setExitAction(moveExit);

			unitAction.setEntryAction(unitEntry);
			unitAction.setUpdateAction(unitUpdate);
			unitAction.setExitAction(unitExit);
			
			clip.addEventListener(UnitEvent.UNIT_CLICKED, _selectUnit);
			clip.addEventListener(TileEvent.TILE_CLICKED, _selectTile);
			clip.dispatchEvent(new FactionEvent(this,FactionEvent.FACTION_INIT));
		}
		
		public function selectEntry():void {
			trace("Select Unit");
			currentUnit = null;
		}
		
		public function selectUpdate():void {
			scrollCamera();
		}

		protected function _selectUnit(ue:UnitEvent):void {
			if (currentUnit == null && select.isActive() && ue.un != null) {
				if (ue.un.factionName == this.name) {
					if (!ue.un.hasMoved()) {
						currentUnit = ue.un;					
					} else {
						trace("This unit has already moved");
					}
				} else {
					trace("Unit "+ue.un.name+" does not belong to "+name);
				}
			}
		}

		protected function _selectTile(te:TileEvent):void {
			if (move.isActive()) {
				if (te.getTile().getUnit() == null) {
					if (te.getTile().getDistance() <= 2){
						currentUnit.move(te.tile);
					} else {
						trace("Tile is too far away.");
					}
				} else {
					trace("Tile isn't empty.");
				}
				currentUnit = null;
			}
		}
		
		public function selectExit():void {
		}
		
		public function scrollCamera():void {
			if (clip != null) {
				clip.x += cameraVelocity.x;
				clip.y += cameraVelocity.y;
				var mouseX:int = clip.stage.mouseX;
				var mouseY:int = clip.stage.mouseY;
				if (mouseX < clip.stage.stageWidth / 10) {
					cameraVelocity.x = +10;
				} else if (mouseX > (clip.stage.stageWidth * 9) / 10) {
					cameraVelocity.x = -10;
				} else {
					cameraVelocity.x = 0;
				}
				if (mouseY < clip.stage.stageHeight / 10) {
					cameraVelocity.y = +10;
				} else if (mouseY > (clip.stage.stageHeight * 9) / 10) {
					cameraVelocity.y = -10;
				} else {
					cameraVelocity.y = -0;
				}
			}
		}
		
		public function moveEntry():void {
			trace("Move Unit");
			tile_default.calculateMovementRange(currentUnit.getTile());
		}
		
		public function moveUpdate():void {
			scrollCamera();
		}

		public function moveExit():void {
			tile_default.clearMovementRange();			
		}

		public function unitEntry():void {
			trace("Unit Action");
		}
		
		public function unitUpdate():void {
			
		}

		public function unitExit():void {
			
		}
		
		public function exit():void {
			currentUnit = null;
			tile_default.clearMovementRange();
			trace("End "+name+" Phase");
		}
		
	}

}