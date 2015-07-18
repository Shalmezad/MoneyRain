package;
import flixel.effects.particles.FlxParticle;
/**
 * ...
 * @author Shalmezad
 */
class SilverCoin extends FlxParticle
{

	public function new() 
	{
        super();
		loadGraphic("assets/images/silver_coin.png");
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