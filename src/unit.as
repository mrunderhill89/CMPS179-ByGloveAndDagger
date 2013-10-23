package {
	import Factions.Faction;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class unit extends MovieClip{
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
		protected var moved:Boolean;
		public var facingA:Array = new Array();
		public var facing:int = 0;
		public var factionName:String = "";
		public var selecting:Boolean = false;

		public function unit(f:String = "") {
			stop();
			instances.push(this);
			tile = null;
			moved = false;
			factionName = f;
			trace("Designating " + name + " under faction " + factionName);
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE,initialize);
			}
		}
		private function initialize(e:Event = null):void {
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
			addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
			addEventListener(MouseEvent.CLICK, _mouseClick);
			addEventListener(UnitEvent.UNIT_CLICKED, _indirectClick);
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
						t.un = this;
						trace("adding" + this.name + "to");
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
			tile = t;
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
			//trace("Unit Clicked:" + name);
			if (!selecting) {
				selecting = true;
				var t:tile_default = this.getTile();
				t.un = null;
				this.tile = null;				
			}
		}
		public function setNewTile():void
		{
			
		}
		
		public function hasMoved():Boolean {
			return moved;
		}
	}
	
}
