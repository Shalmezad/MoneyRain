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
		this.width = 14;
		this.height = 14;
		this.centerOffsets();
	}
	
	override public function update():Void
	{
		super.update();
		if ((x + this.width < 0 || x > Main.gameWidth) && y > 10)
		{
			kill();
		}
	}
	
}