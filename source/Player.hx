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
		this.maxVelocity.x = Constants.PLAYER_HORIZONTAL_MAX_VELOCITY;
		this.drag.x = Constants.PLAYER_HORIZONTAL_DRAG;
	}
	
	
	override public function update():Void
	{
		super.update();
		
		this.acceleration.x = 0;
		if (InputUtil.LEFT_PRESSED() && !InputUtil.RIGHT_PRESSED())
		{
			this.acceleration.x = -1 * Constants.PLAYER_HORIZONTAL_ACCELERATION;
		}
		else if (InputUtil.RIGHT_PRESSED() && !InputUtil.LEFT_PRESSED())
		{
			this.acceleration.x = Constants.PLAYER_HORIZONTAL_ACCELERATION;
		}
		
		keepOnScreen();
	}
	
	private function keepOnScreen():Void
	{
		if (this.x < 0)
		{
			this.x = 0;
		}
		if (this.x + this.width > Main.gameWidth)
		{
			this.x = Main.gameWidth - this.width;
		}
	}
	
}