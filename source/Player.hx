package;
import flixel.FlxSprite;
import flixel.FlxObject;

/**
 * ...
 * @author Shalmezad
 */
class Player extends FlxSprite
{	
	public function new() 
	{
		super(0, Main.gameHeight - Constants.FLOOR_HEIGHT - 50);
		loadGraphic("assets/images/player.png", true, 15, 28);
		animation.add("walk", [0, 1, 0, 2], 20);
		animation.add("jump", [3]);
		animation.add("skid", [4]);
		animation.add("stand", [0]);
		this.maxVelocity.x = Constants.PLAYER_HORIZONTAL_MAX_VELOCITY;
		this.drag.x = Constants.PLAYER_HORIZONTAL_DRAG;
		this.acceleration.y = Constants.PLAYER_GRAVITY_ACCELERATION;
		this.width = 13;
		this.height = 26;
		this.centerOffsets();
	}
	
	
	override public function update():Void
	{
		this.acceleration.x = 0;
		if (InputUtil.LEFT_PRESSED() && !InputUtil.RIGHT_PRESSED())
		{
			this.acceleration.x = -1 * Constants.PLAYER_HORIZONTAL_ACCELERATION;
			this.flipX = true;
		}
		else if (InputUtil.RIGHT_PRESSED() && !InputUtil.LEFT_PRESSED())
		{
			this.acceleration.x = Constants.PLAYER_HORIZONTAL_ACCELERATION;
			this.flipX = false;
		}
	
		if (InputUtil.JUMP_JUST_PRESSED())
		{
			trace("Jump just pressed");
			if(this.isTouching(FlxObject.FLOOR))
			{
				this.velocity.y = Constants.PLAYER_JUMP_VELOCITY;
				trace("Jump!");
			}
		}
		
		if (velocity.y != 0)
		{
			this.animation.play("jump");
		}
		else if (velocity.x != 0)
		{
			if (this.flipX)	//If we're trying to go left
			{
				if (this.velocity.x < 0)	//And we're going left
				{
					this.animation.play("walk");
				}
				else	//SKID
				{
					this.animation.play("skid");
				}
			}
			else
			{	//We're going right
				if (this.velocity.x > 0)	//And we're going right
				{
					this.animation.play("walk");
				}
				else	//SKID
				{
					this.animation.play("skid");
				}
			}
		}
		else
		{
			this.animation.play("stand");
		}
		
		keepOnScreen();
		super.update();
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