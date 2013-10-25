package  {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flashx.textLayout.formats.Float;
	import flashx.textLayout.elements.ListElement;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import DataStructures.PriorityQueue.PriorityQueue;
	
	public class tile_default extends SimpleButton {
		
		//Indices start from the top and go clockwise.
		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;
		public static const COORDS:Array = [[0,-1],[1,0],[0,1],[-1,0]];
		public static const OPPOSITES:Array = [DOWN,LEFT,UP,RIGHT];
		public static const COORDICONS:Array = ['U','R','D','L'];

		public static const X_SIZE:Number = 50.0;
		public static const Y_SIZE:Number = 50.0;		
		public static const X_SNAP:Number = 0.1;
		public static const Y_SNAP:Number = 0.1;
		protected static var tile_index:int = 0;
		protected static var tiles:Array = new Array();
		public static function getInstances():Array {
			return tiles;
		}

		protected var neighbors:Array;
		protected var elements:Array;
		protected var flags:Dictionary;
		public function setFlag(name:String, value:int = 1):void{
			this.flags[name] = value;
		}
		public function getFlag(name:String):Boolean{
			if (this.flags[name] != null && this.flags[name] != 0)
				return true;
			return false;
		}
				
		//For distance calculations. If dist <= this, we can't get there.
		protected var dist:Number = Infinity;
		protected var previous:tile_default = null;
		public var selecting:Boolean = false;
		public var un:unit = null;
		public static var currUnit:unit = null;
		public static var highlighting:Boolean = true;
		
		protected var id:int;
		
		protected var text:TextField;
		
				
		protected static var currentTile:tile_default = null;
		public static function getCurrentTile():tile_default {
			return currentTile;
		}

		public function tile_default() {
			id = tile_index;
			tile_index++;
			neighbors = new Array();
			elements = new Array();
			flags = new Dictionary();
			tiles.push(this);
			if (stage) {
				initialize();
			} else {
				addEventListener(Event.ADDED_TO_STAGE,initialize);
			}
		}
		
		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			var x_dist:Number;
			var y_dist:Number;
			//Find tile elements and store them here.
			for (var ei:String in tile_element.getInstances()){
				var el:tile_element = tile_element.getInstances()[ei];
				if (el != null){
					x_dist = el.x - this.x;
					y_dist = el.y - this.y;
					if (Math.abs(x_dist) < X_SNAP && Math.abs(y_dist) < Y_SNAP){
						el.setTile(this);
						elements.push(el);
						//trace("Adding tile element:"+ el.name + " to tile:" + id); 
					}
				}
			}
			
			//Find units and attach to this tile if appropriate.
			for (var ui:String in unit.getInstances()){
				var u:unit = unit.getInstances()[ui];
				if (u != null){
					x_dist = u.x - this.x;
					y_dist = u.y - this.y;
					if (Math.abs(x_dist) < X_SNAP && Math.abs(y_dist) < Y_SNAP){
						u.setTile(this);
						this.un = u;
					}
				}
			}

			//Generate debug text on each tile
			text = new TextField();
			text.text = this.id.toString();
			
			//Find neighboring tiles
			for (var t:String in tiles){
				var tile:tile_default = tiles[t];
				if (tile.id != this.id){
					x_dist = tile.x - this.x;
					y_dist = tile.y - this.y;
					
					//Horizontal
					if (Math.abs(y_dist) < Y_SNAP){
						if (Math.abs(x_dist) <= X_SIZE + X_SNAP){
							if (x_dist > 0){
								this.neighbors[RIGHT] = tile;
								tile.neighbors[LEFT] = this;
								//trace(this.id + ">" + COORDICONS[RIGHT] + ">" + tile.id);
							} else {
								this.neighbors[LEFT] = tile;
								tile.neighbors[RIGHT] = this;
								//trace(this.id + ">" + COORDICONS[LEFT] + ">" + tile.id);
							}
						}
					} else if (Math.abs(x_dist) < X_SNAP){
						if (Math.abs(y_dist) <= Y_SIZE + Y_SNAP){
							if (y_dist > 0){
								this.neighbors[DOWN] = tile;
								tile.neighbors[UP] = this;
								//trace(this.id + ">" + COORDICONS[DOWN] + ">" + tile.id);
							} else {
								this.neighbors[UP] = tile;
								tile.neighbors[DOWN] = this;
								//trace(this.id + ">" + COORDICONS[UP] + ">" + tile.id);
							}
						}
					}
				}
			}
			text.x = x;
			text.y = y;
			text.selectable = false;
			//parent.addChild(text);
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
			addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, _mouseOut );
			addEventListener( MouseEvent.CLICK, _mouseClick);
		}
		
		public function _mouseOver( e:MouseEvent): void
		{
			//trace("Tile Selected:" + id);
			dispatchEvent(new TileEvent(TileEvent.TILE_MOUSEOVER, true, false, this));
			currentTile = this;
		}
		
		public function _mouseOut( e:MouseEvent): void
		{
			//trace("Tile Deselected:" + id);
			dispatchEvent(new TileEvent(TileEvent.TILE_MOUSEOUT, true, false, this));
		}

		public function _mouseClick ( e:MouseEvent): void
		{
			trace("Tile Clicked:" + text.text);
			dispatchEvent(new TileEvent(TileEvent.TILE_CLICKED, true, false, this));
			if (this.un != null) {
				if (currUnit != null) {
					currUnit.selecting = false;
				}
				currUnit = this.un;
				calculateMovementRange(this);
				if (!this.un.moved) {
					currUnit = this.un;
					calculateMovementRange(this);
					this.un.dispatchEvent(new UnitEvent(UnitEvent.UNIT_CLICKED,true,false,this.un));
				}
				else {
					trace("This unit has already moved");
				}
			} else {
				if (currUnit != null) {
					currUnit.move(this);
					clearMovementRange();
					currUnit = null;
				}
			}
		}
		
				
		public function dehighlight(): void {
			this.transform.colorTransform = new ColorTransform();
		}

		public function highlight(): void {
			var myColorTransform:ColorTransform = new ColorTransform();
			if (getFlag("mouseCursor")){
				myColorTransform.color = 0x11FF33;
			} else if (getFlag("movementRange")) {
				myColorTransform.color = 0x1133FF;
			} else if (getFlag("attackRange")) {
				myColorTransform.color = 0xFF1133;
			} else if (getFlag("visualRange")) {
				myColorTransform.color = 0xFF9933;
			}
			this.transform.colorTransform = myColorTransform;			
		}
		
		public function _onUpdate( e:Event ):void
		{
			text.text = this.id.toString();
			for (var d:int = 0; d < 4; d++){
				if (this.neighbors[d] != null){
					text.appendText(COORDICONS[d]);
				}
			}
			if (this.un!= null) {
				text.appendText("<" + un.name + ">");
			}
			if (elements.length > 0) {
				for (var el:String in elements) {
					var element:tile_element = elements[el];
					text.appendText("("+ element.name +")");
				}
			}
			if (currentTile == this && highlighting) {
				setFlag("mouseCursor", 1);
			} else {
				setFlag("mouseCursor",0);
			}
			highlight();
		}
		public function setUnit(u:unit):void
		{
			un = u;
		}
		public function getUnit():unit
		{
			return un;
		}

		/* Use Dijkstra's algorithm to build the shortest path
		/* From "from" to "to". Returns the distance between them,
		 * or INFINITE_DISTANCE if there's no available path between them.
		 * More importantly, it creates a reversed path from 
		 */
		public function pathfind(to:tile_default, graph:Array, vertDist:Function, maxRange:int = Infinity):int {
			var queue:PriorityQueue = new PriorityQueue();
			var vt:tile_default;
			var d:Number = 0.0;
			for (var v:String in graph) {
				vt = graph[v];
				vt.previous = null;
				vt.dist = Infinity;
				queue.insert(vt, vt.dist);
			}
			//Source is always distance 0.
			this.dist = 0;
			queue.decreaseKey(queue.find(this), 0);
			while (queue.getLength() > 0){
				vt = queue.getMin() as tile_default;
				queue.removeMin();
				if (vt.dist == Infinity){
					break ;                                           
				}
				for (var ni:int = 0; ni < 4; ni++ ) {
					var n:tile_default = vt.neighbors[ni];
					if (n != null){
						d = vt.dist + Math.max(vertDist.apply(n, [n]), 0.0);
						if (d < n.dist && d < maxRange){
							n.dist = d;
							n.previous = vt;
							queue.decreaseKey(queue.find(n), d);
						}
					}
				}
			}
			if (to == null)
				return Infinity; //We don't have a goal, just calculate distances.
			return to.dist;
		}
		
		//For normal movement, each edge has a distance of just 1.
		public static function constantVert(t:tile_default):Number {
			return 1;
		}
		
		public static function clearMovementRange():void {
			var tl:tile_default;
			for (var ti:String in tiles) {
				tl = tiles[ti];
				tl.setFlag("movementRange", 0);
				tl.setFlag("attackRange", 0);
				tl.setFlag("visibleRange", 0);
			}
		}
		
		public static function calculateMovementRange(center:tile_default):void {
			center.pathfind(null, tiles, constantVert, 5);
			var tl:tile_default;
			clearMovementRange();
			for (var ti:String in tiles) {
				tl = tiles[ti];
				if (tl.dist < Infinity){
						tl.setFlag("visibleRange");
						if (tl.dist < 4) {
							tl.setFlag("attackRange");
							if (tl.dist < 3) {
								tl.setFlag("movementRange");
							}
						}
				}
			}
		}
		
		public override function toString():String {
			return "Tile #"+id.toString();
		}
	}
}
