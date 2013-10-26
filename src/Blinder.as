package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Blinder extends HudElement{
		protected var goalAlpha:Number = 0.0;
		protected static const ALPHA_RATE:Number = 1.0;
		public function Blinder() {
			super();
			(parent as MovieClip).addEventListener(FactionEvent.FACTION_END_TURN,_show);
			(parent as MovieClip).addEventListener(FactionEvent.FACTION_START_TURN,_hide);
			(parent as MovieClip).addEventListener(Event.ENTER_FRAME, _update);
		}
		
		public function _show(e:Event = null){
			goalAlpha = 100.0;
		}
		public function _hide(e:Event = null){
			goalAlpha = 0.0;
		}
		
		public override function _update(e:Event = null){
			super._update(e);
			if (this.alpha < goalAlpha){
				this.alpha = Math.min(this.alpha + ALPHA_RATE, goalAlpha);
			} else if (this.alpha > goalAlpha){
				this.alpha = Math.max(this.alpha - ALPHA_RATE, goalAlpha);
			}
			if (this.alpha < 1.0){
				this.visible = false;
			} else {
				this.visible = true;
			}
		}
	}
	
}
