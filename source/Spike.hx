package;
import flixel.effects.particles.FlxParticle;

/**
 * ...
 * @author Shalmezad
 */
class Spike extends FlxParticle
{

	public function new() 
	{
        super();
		loadGraphic("assets/images/spike.png");
	}
	
	override public function update():Void
	{
		super.update();
		if ((x < 0 || x > Main.gameWidth) && y > 10)
		{
			kill();
		}
	}
	
}