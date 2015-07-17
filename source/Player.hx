package;
import flixel.FlxSprite;

/**
 * ...
 * @author Shalmezad
 */
class Player extends FlxSprite
{

	public function new() 
	{
		super(0,0);
		makeGraphic(20, 20, 0xFFFF0000);
	}
	
}