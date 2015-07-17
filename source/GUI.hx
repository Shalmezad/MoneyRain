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
	var centerText:FlxText;
	
	public function new() 
	{
		super();
		centerText = new FlxText(0, Main.gameHeight / 2, Main.gameWidth, "");
		centerText.alignment = "center";
		scoreText = new FlxText(10, 10);
		add(scoreText);
		add(centerText);
	}
	
	override public function update():Void
	{
		super.update();
		scoreText.text = "Score: " + Std.string(Reg.score);
		if (!Reg.playState.player.alive)
		{
			centerText.color = 0xFFFF7777;
			centerText.text = "Your score is 0 because you are dead.";
		}
	}
	
}