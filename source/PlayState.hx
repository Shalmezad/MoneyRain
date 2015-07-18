package;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player:Player;
	var floor:FlxSprite;
	var gui:GUI;
	var bronzeMoneyEmitter:FlxEmitter;
	var silverMoneyEmitter:FlxEmitter;
	var goldMoneyEmitter:FlxEmitter;
	var enemyEmitter:FlxEmitter;
	
	var seed:Int;
	var runBar:FlxBar;
	
	public function new(seed:Int = 90210)
	{
		super();
		//Will need this for seed later.
		this.seed = seed;
		Reg.playState = this;
		Reg.score = 0;
		//DO NOT PUT ANY FLX STUFF IN HERE!!!
	}
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		trace("PlayState::create()");
		super.create();
		FlxRandom.globalSeed = seed;
		
		createEntities();
		
		add(floor);
		add(player);
		add(bronzeMoneyEmitter);
		add(silverMoneyEmitter);
		add(goldMoneyEmitter);
		add(enemyEmitter);
		add(gui);
		add(runBar);
	}
	
	private function createEntities():Void
	{
		floor = new FlxSprite(0, Main.gameHeight - Constants.FLOOR_HEIGHT);
		floor.makeGraphic(Main.gameWidth, Constants.FLOOR_HEIGHT, 0xFF5555FF);
		floor.immovable = true;
		floor.moves = false;
		
		player = new Player();
		
		gui = new GUI();
		
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
		
		runBar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 30, 6, null, "", 0, 30, true);
		runBar.visible = false;
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
		FlxG.collide(player, floor);
		FlxG.overlap(player, enemyEmitter,  playerEnemyOverlap);
		FlxG.overlap(player, bronzeMoneyEmitter, playerBronzeMoneyOverlap);
		FlxG.overlap(player, silverMoneyEmitter, playerSilverMoneyOverlap);
		FlxG.overlap(player, goldMoneyEmitter, playerGoldMoneyOverlap);
		if (player.alive && player.visible && InputUtil.RUN_PRESSED() && (player.x < Constants.RUN_BORDER || player.x + player.width >  Main.gameWidth - Constants.RUN_BORDER))
		{
			runBar.currentValue += .25;
			runBar.visible = true;
			runBar.x = player.x;
			runBar.y = player.y - runBar.height - 5;
			if (runBar.currentValue >= 30)
			{
				//ESCAPE!
				new FlxTimer(Constants.GAME_OVER_TEXT_TIME, endGame, 1);
				player.visible = false;
			}
		}
		else
		{
			runBar.percent = 0;
			runBar.visible = false;
		}
	}	
	
	private function playerEnemyOverlap(player:FlxObject, enemy:FlxObject):Void
	{
		if (player.alive && player.visible)
		{
			player.kill();
			Reg.score = 0;
			new FlxTimer(Constants.GAME_OVER_TEXT_TIME, endGame, 1);
		}
	}
	
	private function playerBronzeMoneyOverlap(player:FlxObject, money:FlxObject):Void
	{
		if (player.alive && player.visible)
		{
			money.kill();
			Reg.score += Constants.BRONZE_VALUE;
		}
	}	
	private function playerSilverMoneyOverlap(player:FlxObject, money:FlxObject):Void
	{
		if (player.alive && player.visible)
		{
			money.kill();
			Reg.score += Constants.SILVER_VALUE;
		}
	}
	private function playerGoldMoneyOverlap(player:FlxObject, money:FlxObject):Void
	{
		if (player.alive && player.visible)
		{
			money.kill();
			Reg.score += Constants.GOLD_VALUE;
		}
	}
	
	private function endGame(f:FlxTimer):Void
	{
		FlxG.switchState(new MenuState());
	}
}