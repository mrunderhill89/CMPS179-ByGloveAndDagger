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
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;

	/**
	 * ...
	 * @author Kevin
	 */
	public class Player extends Faction 
	{
		protected var cameraVelocity:Point = new Point(0, 0);
		protected var cameraBounds:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var currentUnit:unit = null;
		protected var treasureCollected:int = 0;
		protected var initialUnits:int = 0;
		
		public function addTreasure( v:int = 1){
			treasureCollected += v;
		}
		public function getTreasure():int{
			return treasureCollected;
		}
		
		public function getRemainingUnits():int{
			var out:int = 0;
			var un:unit;
			for (var ui:String in units){
				un = units[ui];
				if (un != null && un.isAlive()){
					out++;
				}
			}
			return out;
		}

		public function getInitialUnits():int{
			return initialUnits;
		}
		
		public function Player(n:String = "Player", p:HFSM = null, c:MovieClip = null, makeInitial:Boolean = false) 
		{
			super(n, p, c, makeInitial);
			setEntryAction(entry);
			setExitAction(exit);
			select.setEntryAction(selectEntry);
			select.setUpdateAction(selectUpdate);
			select.setExitAction(selectExit);
			
			var selectToMove:Transition = new Transition(select, move, function():Boolean { return currentUnit !=  null; } );
			var moveToAttack:Transition = new Transition(move, unitAction, function():Boolean { return currentUnit.selecting == false; } );
			var attackToSelect:Transition = new Transition(unitAction, select, function():Boolean { return currentUnit.attacking == false; } );
			
			move.setEntryAction(moveEntry);
			move.setUpdateAction(moveUpdate);
			move.setExitAction(moveExit);

			unitAction.setEntryAction(unitEntry);
			unitAction.setUpdateAction(unitUpdate);
			unitAction.setExitAction(unitExit);
			
			clip.addEventListener(UnitEvent.UNIT_CLICKED, _selectUnit);
			clip.addEventListener(TileEvent.TILE_CLICKED, _selectTile);
			clip.addEventListener(KeyboardEvent.KEY_DOWN, _handleKeyboard);
			initialUnits = getRemainingUnits();
		}
		
		public function selectEntry():void {
			trace("Select Unit");
			currentUnit = null;
			this.updateVisibilities();
		}
		
		public function selectUpdate():void {
			scrollCamera();
		}

		protected function _selectUnit(ue:UnitEvent):void {
			if (currentUnit == null && select.isActive() && ue.un != null) {
				if (ue.un.factionName == this.name) {
					if (!ue.un.hasMoved()) {
						currentUnit = ue.un;
						currentUnit.selecting = true;
					} else {
						trace("This unit has already moved");
					}
				} else {
					trace("Unit "+ue.un.name+" does not belong to "+name);
				}
			}else if (unitAction.isActive() && ue.un != null) {
					if (ue.un.getTile().getFlag("attackRange")) {
						if(ue.un.getTile().getUnit() != currentUnit && ue.un.factionName!= currentUnit.factionName){
							trace("Attacking Unit");
							ue.un.health -= 1;
							if(!ue.un.isAlive()){ue.un.deadExile();}
							currentUnit.attacking = false;
						}
						else{
							trace("No Attack");
							currentUnit.attacking = false;
						}
					}
				}				
			}
		

		protected function _selectTile(te:TileEvent):void {
			if (move.isActive()) {
				if (te.getTile().getUnit() == null) {
					if (te.getTile().getFlag("movementRange")){
						currentUnit.move(te.tile);
						this.updateVisibilities();
					} else {
						trace("Tile is too far away.");
					}
				} else {
					trace("Tile isn't empty.");
				}
				currentUnit.selecting = false;
			}
			else if (unitAction.isActive()) {
				if(te.getTile().getUnit() != null){
					trace("Unit != null");
				}
				else {
				trace("no attack");
				currentUnit.attacking = false;
				}
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
				if (mouseX < clip.stage.stageWidth * 0.1 && mouseX > 0) {
					cameraVelocity.x = +10;
				} else if (mouseX > (clip.stage.stageWidth * 0.9) && mouseX < clip.stage.stageWidth) {
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
			currentUnit.calculateMovementRange();
			this.updateVisibilities();
		}
		
		public function moveUpdate():void {
			scrollCamera();
		}

		public function moveExit():void {
			trace("Done Moving");
			//tile_default.clearMovementRange();
			this.updateVisibilities();
		}

		public function unitEntry():void {
			trace("Unit Action");
			currentUnit.calculateAttackRange();
			currentUnit.attacking = true;
		}
		
		public function unitUpdate():void {
			scrollCamera();
			
		}

		public function unitExit():void {
			tile_default.clearMovementRange();
			this.updateVisibilities();
			currentUnit = null;
		}
		
		public function entry():void{
			super.startTurn();
			this.updateVisibilities();
		}
		
		public function exit():void {
			currentUnit = null;
			tile_default.clearMovementRange();
			trace("End "+name+" Phase");
		}
		
		public function _handleKeyboard(ke:KeyboardEvent){
			if (ke.keyCode == 36){
				//Center Camera
				clip.x = 0;
				clip.y = 0;
			}
		}
	}

}