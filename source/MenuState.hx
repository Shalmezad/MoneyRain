package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.effects.FlxFlicker;
import flixel.effects.particles.FlxEmitter;
//import nme.net.URLRequest;
//import nme.Lib;
import flash.Lib;
import flash.net.URLRequest;

@:file("assets/data/gamejolt_api.privatekey") class GameJoltPrivateKey extends ByteArray { }

class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	var flashText:FlxText;
	var slogo:FlxSprite;
	var clogo:FlxSprite;
	var linkText:FlxText;
	 
	override public function create():Void
	{
		super.create();
		FlxG.sound.muteKeys = ["m", "M"];
		
		var bronzeMoneyEmitter:FlxEmitter;
		var silverMoneyEmitter:FlxEmitter;
		var goldMoneyEmitter:FlxEmitter;
		var enemyEmitter:FlxEmitter;
		

		//BRONZE
		var moneySize:Int = 75;
		bronzeMoneyEmitter = new FlxEmitter(Main.gameWidth/2, -20, moneySize);
		for (i in 0...moneySize)
		{
			bronzeMoneyEmitter.add(new BronzeCoin());
		}
		bronzeMoneyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		bronzeMoneyEmitter.start(false, 0, Constants.BRONZE_FREQUENCY);
		//SILVER
		silverMoneyEmitter = new FlxEmitter(Main.gameWidth/2, -20, moneySize);
		for (i in 0...moneySize)
		{
			silverMoneyEmitter.add(new SilverCoin());
		}
		silverMoneyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		silverMoneyEmitter.start(false, 0, Constants.SILVER_FREQUENCY);
		//GOLD
		goldMoneyEmitter = new FlxEmitter(Main.gameWidth/2, -20, moneySize);
		for (i in 0...moneySize)
		{
			goldMoneyEmitter.add(new GoldCoin());
		}
		goldMoneyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		goldMoneyEmitter.start(false, 0, Constants.GOLD_FREQUENCY);
		
		var enemySize:Int = 50;
		enemyEmitter = new FlxEmitter(Main.gameWidth/2, -20, enemySize);
		for (i in 0...enemySize)
		{
			enemyEmitter.add(new Spike());
		}
		enemyEmitter.gravity = Constants.PARTICLE_GRAVITY;
		enemyEmitter.start(false, 0, .15);
		add(bronzeMoneyEmitter);
		add(silverMoneyEmitter);
		add(goldMoneyEmitter);
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
		
		
		slogo = new FlxSprite(10, Main.gameHeight - 50);
		slogo.loadGraphic("assets/images/s_logo.png");
		add(slogo);
		
		clogo = new FlxSprite(Main.gameWidth - 45, Main.gameHeight - 50);
		clogo.loadGraphic("assets/images/clyde_machine_logo.png");
		add(clogo);
		
		linkText = new FlxText(0, 10, Main.gameWidth);
		linkText.y = Main.gameHeight - 40;
		linkText.alignment = "center";
		add(linkText);
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
		if (InputUtil.JUMP_JUST_PRESSED())
		{
			if (Reg.firstTime)
			{
				FlxG.switchState(new InstructionState());
				Reg.firstTime = false;
			}
			else
			{
				FlxG.switchState(new PlayState());
			}
		}
		
		
		
		if (clogo.overlapsPoint(FlxG.mouse.getScreenPosition()))
		{
			linkText.text = "More music by Clyde Machine";
			if (FlxG.mouse.justPressed)
			{
				Lib.getURL (new URLRequest ("http://clydemachine.com/"));
			}
		
		}
		else if (slogo.overlapsPoint(FlxG.mouse.getScreenPosition()))
		{
			linkText.text = "More games by Shalmezad";
			if (FlxG.mouse.justPressed)
			{
				Lib.getURL (new URLRequest ("http://www.kongregate.com/accounts/Shalmezad"));
			}
		}
		else
		{
			linkText.text = "";
		}
	}	
}