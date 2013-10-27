package {
	import Factions.Faction;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class unit extends MovieClip{
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		public var moved:Boolean;
		public var facingA:Array = new Array();
		public var facing:int = 0;
		
		public var factionName:String;
		public var faction:Faction = null;
		
		public function getFaction():Faction{
			return faction;
		}
		public function setFaction(f:Faction):void{
			faction = f;
		}
		
		public var selecting:Boolean = false;
		
		public var awareness:int = 25;
		public var maxHealth:int = 2;
		public var health:int = maxHealth;
		public var movementRange:int = 2;
		public var attackRange:int = 1;
		public var attacking:Boolean = false;
		
		public function unit(f:String = "") {
			stop();
			instances.push(this);
			tile = null;
			moved = false;
			factionName = f;
			if (stage) {
				initialize();
			} else {
				stage.addEventListener(Event.ADDED_TO_STAGE,initialize);
			}
		}
		private function initialize(e:Event = null):void {
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
			addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
			addEventListener(MouseEvent.CLICK, _mouseClick);
			addEventListener(UnitEvent.UNIT_CLICKED, _indirectClick);
			parent.addEventListener(FactionEvent.FACTION_INIT, _registerFaction);
			parent.addEventListener(FactionEvent.FACTION_START_TURN, _refresh);
			//Find tile and set its unit to this.
			var x_dist:Number;
			var y_dist:Number;
			for (var ti:String in tile_default.getInstances()){
				var t:tile_default = tile_default.getInstances()[ti];
				if (t != null){
					x_dist = t.x - this.x;
					y_dist = t.y - this.y;
					if (Math.abs(x_dist) < tile_default.X_SNAP && Math.abs(y_dist) < tile_default.Y_SNAP) {
						setTile(t);
					}
				}
			}
		}
		
		private function _onUpdate(e:Event):void
		{
			if (this.facing == 0) {
				this.facingA[0];
			}
		}
		
		public static function getInstances():Array{
			return instances;
		}
		
		public function getTile():tile_default{
			return tile;
		}
		
		public function setTile(t:tile_default):void {
			//Set the old tile to be empty
			if (tile != null)
				tile.setUnit(null);
			tile = t;
			//If the new tile isn't null, set its unit to this
			if (t != null)
				t.setUnit(this);
		}
		
		public function _mouseOver( me:MouseEvent):void {
			if (tile != null) {
				tile._mouseOver(me);
			}
		}
		public function _mouseClick( me:MouseEvent):void {
			if (tile != null) {
				tile._mouseClick(me);
			}
		}
		
		public function _indirectClick(ue:UnitEvent):void {
			trace("Unit Clicked:" + name);
		}
		
		public function move(tile:tile_default):void
		{
			this.tile.setUnit(null);
			tile.setUnit(this);
			setTile(tile);
			this.x = tile.x;
			this.y = tile.y;
			tile.dispatchEvent(new UnitEvent(UnitEvent.UNIT_APPROACH_TILE, true, false, this));
			setHasMoved(true);
		}
		
		public function _registerFaction(fe:FactionEvent = null, f:Faction = null){
			if (f == null && fe.faction != null)
				f = fe.faction;
			if (f != null && f.getName() == this.factionName){
				trace("Adding "+name+" to "+f.getName());
				setFaction(f);
				trace("Resulting faction:"+this.faction);
				f.addUnit(this);
			} else {
				trace("Faction "+f.getName()+" doesn't match the faction of "+name);
			}
		}
		
		private function _refresh(fe:FactionEvent){
			var f:Faction = fe.faction;
			if (f != null && f.getName() == this.factionName){
				setHasMoved(false);
			}
		}
		
		public function setHasMoved(v:Boolean){
			moved = v;
		}
		
		public function hasMoved():Boolean {
			return moved;
		}
		
		public function canSpotUnit(that:unit):Boolean{
			//Idiot check: If two units are next to each other, then they can see each other.
			for (var ni:int = 0; ni < 4; ni++){
				var n:tile_default = this.tile.getNeighbor(ni);
				if (n != null && n == that.tile){
					//Return a shrubbery! ...I mean...
					return true;
				}
			}
			this.tile.pathfind(that.tile, 
									  tile_default.getInstances(), 
									  tile_default.visibility, 
									  this.awareness*2);
			return that.tile.getDistance() < this.awareness;
		}
		
		public function calculateMovementRange():void {
			tile_default.clearMovementRange();
			var center:tile_default = this.getTile();			
			var tiles:Array = tile_default.getInstances();
			center.pathfind(null, 
							tiles, 
							tile_default.visibility, 
							this.awareness*2);
			for (var ti:String in tiles) {
				tl = tiles[ti];
				tl.setLightDistance(tl.getDistance());
				if (tl.getDistance() < this.awareness) {
					tl.setFlag("visibleFar");
				}
			}
			//Handle movement after visibility
			center.pathfind(null, tiles, tile_default.avoidGuards, movementRange + attackRange);
			var tl:tile_default;
			for (ti in tile_default.getInstances()) {
				tl = tiles[ti];
				if (tl.getDistance() <= movementRange + attackRange) {
					tl.setFlag("attackRange");
					if (tl.getDistance() <= movementRange) {
						tl.setFlag("movementRange");
					}
				}
			}
		}
		public function calculateAttackRange():void {
			tile_default.clearMovementRange();
			var center:tile_default = this.getTile();			
			var tiles:Array = tile_default.getInstances();
			
			//Handle movement after visibility
			center.pathfind(null, tiles, tile_default.constantVert, attackRange*2);
			var tl:tile_default;
			for (var ti:String in tiles) {
					tl = tiles[ti];
					if (tl.getDistance() <= attackRange) {
						tl.setFlag("attackRange");
					}
				}
			}
		public function deadExile():void
		{
			if(!isAlive()){
				var t:tile_default = this.getTile();
				t.setUnit(null);
				this.setTile(null);
				this.visible = false;
				this.x = -20000;
				this.y = -20000;
				if (this is unit_hero) {
					//The guards win.
				}
			}
		}
		public function isAlive():Boolean{
			return health > 0;
		}
		}
		
		
	
	
}
