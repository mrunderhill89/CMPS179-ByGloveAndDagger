package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class EndTurnButton extends HudElement {
		protected var clicked:Boolean = false;
		public function EndTurnButton() {
			super();
			addEventListener(MouseEvent.CLICK, _press);
			addEventListener(MouseEvent.MOUSE_UP, _release);
			addEventListener(FactionEvent.FACTION_START_TURN, _updateIcon);
		}
		
		public override function _update( e:Event = null){
			super._update(e);
		}
		
		protected function _press(me:MouseEvent):void{
			if (!clicked){
				(parent as Level1)._endTurnButton(me);
				clicked = true;
			}
		}
		protected function _release(me:MouseEvent):void{
			clicked = false;
		}
		protected function _updateIcon(fe:FactionEvent):void{
			if (fe.faction.getName() == "Player"){
				this.gotoAndStop(0);
			} else {
				this.gotoAndStop(1);
			}
		}
	}
	
}
