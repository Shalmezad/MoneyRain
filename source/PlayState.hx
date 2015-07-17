package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var player:Player;
	var floor:FlxSprite;
	
	public function new()
	{
		super();
		//Will need this for seed later.
	}
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		trace("PlayState::create()");
		super.create();
		
		floor = new FlxSprite(0, Main.gameHeight - Constants.FLOOR_HEIGHT);
		floor.makeGraphic(Main.gameWidth, Constants.FLOOR_HEIGHT, 0xFF5555FF);
		floor.immovable = true;
		floor.moves = false;
		add(floor);
		player = new Player();
		add(player);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(player, floor);
	}	
}