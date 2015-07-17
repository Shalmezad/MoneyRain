package;
import flixel.FlxG;

/**
 * ...
 * @author Shalmezad
 */
class InputUtil
{

	public static function JUMP_JUST_PRESSED():Bool
	{
		return FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W || FlxG.keys.justPressed.SPACE;
	}
	
	public static function LEFT_PRESSED():Bool
	{
		return FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT;
	}
	
	public static function RIGHT_PRESSED():Bool
	{
		return FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT;
	}
	
	public static function RUN_PRESSED():Bool
	{
		return FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN;
	}
}