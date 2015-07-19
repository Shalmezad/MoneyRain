package;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.effects.FlxFlicker;

/**
 * ...
 * @author Shalmezad
 */
class InstructionState extends FlxState
{
	
	var canContinue:Bool = false;

	public function new() 
	{
		super();
	}
	
	override public function create():Void
	{
		trace("InstructionState::create()");
		super.create();
		var instructionsSprite:FlxSprite = new FlxSprite(0, 0);
		instructionsSprite.loadGraphic("assets/images/instructions.png");
		add(instructionsSprite);
		
		new FlxTimer(3, allowContinue, 1);
	}
	
	override public function update():Void
	{
		super.update();
		if (InputUtil.JUMP_JUST_PRESSED() && canContinue)
		{
			FlxG.switchState(new PlayState());
		}
	}
	
	private function allowContinue(f:FlxTimer):Void
	{		
		var flashText:FlxText = new FlxText(0, Main.gameHeight - 40, Main.gameWidth, "Press Jump to Continue", 8);
		//flashText.color = 0xFFFFFF00;
		flashText.alignment = "center";
		add(flashText);
		
		FlxFlicker.flicker(flashText, 0, 0.5, false, false);
		canContinue = true;
	}
}