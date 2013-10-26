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
		public var selecting:Boolean = false;

		public function unit(f:String = "") {
			stop();
			instances.push(this);
			tile = null;
			moved = false;
			factionName = f;
			if (stage) {
				initialize();
			} else {
				stage.addEventListener(Event.COMPLETE,initialize);
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
		
		public function setTile(t:tile_default):void{
			if (tile != null)
				tile.setUnit(null);
			tile = t;
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
			selecting = false;
			setHasMoved(true);
		}
		
		private function _registerFaction(fe:FactionEvent){
			var f:Faction = fe.faction;
			if (f != null && f.getName() == this.factionName){
				trace("Adding "+name+" to "+f.getName());
				f.addUnit(this);
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
	}
	
}
