package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;

   public class Main extends Sprite
   {
	
      public function Main():void
      {
         if (stage) init();
         else addEventListener(Event.ADDED_TO_STAGE, init);
      }
      
      private function init(e:Event = null):void
      {
         removeEventListener(Event.ADDED_TO_STAGE, init);
         // entry point
		 var greeting:TextField = new TextField();
		 greeting.text = "Hello World!";
		 greeting.x = 100;
		 greeting.y = 100;
		 addChild(greeting);
		 //Set up factions.
		 var player:Faction = new Faction();
		 var guards:Faction = new Faction();
		 var current:Faction = player;
		 //Main loop:
	}
	
	
   }
}