﻿package {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class unit extends SimpleButton{
		protected static var instances:Array = new Array();
		protected var tile:tile_default;
<<<<<<< HEAD
		public var facingA:Array = new Array();
		public var facing:int = 0;
		public function unit(){
			instances.push(this);
			tile = null;
			this.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		}
		private function _onUpdate():void
		{
			
			if (this.facing == 0) {
				this.facingA[0];
				
			}
=======
		protected var moved:Boolean;
		public function unit(){
			instances.push(this);
			tile = null;
			moved = false;
			addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
			addEventListener(MouseEvent.CLICK, _mouseOver);
>>>>>>> 766878200ae8f9662101ea3bfa747bf5ee95ada3
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
		
<<<<<<< HEAD
=======
		public function hasMoved():Boolean {
			return moved;
		}
>>>>>>> 766878200ae8f9662101ea3bfa747bf5ee95ada3
	}
	
}
