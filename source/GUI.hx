package;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Shalmezad
 */
class GUI extends FlxGroup
{
	var scoreText:FlxText;
	
	public function new() 
	{
		super();
		scoreText = new FlxText(10, 10);
		add(scoreText);
	}
	
	override public function update():Void
	{
		super.update();
		scoreText.text = "Score: " + Std.string(Reg.score);
	}
	
}