package
{
   import flash.display.LoaderInfo;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   

   [SWF(width='800',height='600',backgroundColor='#111133',frameRate='30')]
   public class Main extends Sprite
   {
	public var startLoader:Loader = new Loader();

      public function Main():void
      {
         if (stage) init();
         else addEventListener(Event.ADDED_TO_STAGE, init);
      }


	  private function playGame(e:Event = null):void
	  {
		 startLoader.removeEventListener(MouseEvent.CLICK, playGame);
		 startLoader.visible = false;
		 removeChild(startLoader);
		 var game:Game = Game.getInstance();
		 addChild(game);
	  }
	  private function startLoaded(e:Event):void
	  {
		 startLoader.addEventListener(MouseEvent.CLICK, playGame);
	  }
      private function init(e:Event = null):void
      {
		 removeEventListener(Event.ADDED_TO_STAGE, init);
		 startLoader = new Loader();
		 startLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, startLoaded);
		 addChild(startLoader);
		 startLoader.load(new URLRequest("../gameScreens/startGameScreen.swf"));
	  }
	}
}