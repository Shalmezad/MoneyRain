package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.effects.FlxFlicker;
import flixel.effects.particles.FlxEmitter;
/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	var flashText:FlxText;
	 
	override public function create():Void
	{
		super.create();
		
		var moneyEmitter:FlxEmitter;
		var enemyEmitter:FlxEmitter;
		
		var moneySize:Int = 75;
		moneyEmitter = new FlxEmitter(Main.gameWidth/2, -20, moneySize);
		for (i in 0...moneySize)
		{
			moneyEmitter.add(new Coin());
		}
		moneyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		moneyEmitter.start(false, 0, .10);
		
		var enemySize:Int = 50;
		enemyEmitter = new FlxEmitter(Main.gameWidth/2, -20, enemySize);
		for (i in 0...enemySize)
		{
			enemyEmitter.add(new Spike());
		}
		enemyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		enemyEmitter.start(false, 0, .15);
		add(moneyEmitter);
		add(enemyEmitter);
		
		var titleText:FlxText = new FlxText(0, 10, Main.gameWidth, "Money Rain", 16);
		titleText.alignment = "center";
		//titleText.color = 0xFFFFFF00;
		add(titleText);
		
		var subTitleText:FlxText = new FlxText(0, titleText.y + titleText.height + 5,Main.gameWidth ,"A game of greed and death", 8);
		subTitleText.alignment = "center";
		//subTitleText.color = 0xFFFFFF00;
		add(subTitleText);
		
		flashText = new FlxText(0, Main.gameHeight / 2, Main.gameWidth, "Insert Coin to Continue", 8);
		//flashText.color = 0xFFFFFF00;
		flashText.alignment = "center";
		add(flashText);
		
		FlxFlicker.flicker(flashText, 0, 0.5, false, false);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}