package;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var player:Player;
	var floor:FlxSprite;
	var gui:GUI;
	var moneyEmitter:FlxEmitter;
	var enemyEmitter:FlxEmitter;
	
	public function new()
	{
		super();
		//Will need this for seed later.
	}
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		trace("PlayState::create()");
		super.create();
		FlxRandom.globalSeed = 10;
		
		createEntities();
		
		add(floor);
		add(player);
		add(moneyEmitter);
		add(enemyEmitter);
		add(gui);
		
	}
	
	private function createEntities():Void
	{
		floor = new FlxSprite(0, Main.gameHeight - Constants.FLOOR_HEIGHT);
		floor.makeGraphic(Main.gameWidth, Constants.FLOOR_HEIGHT, 0xFF5555FF);
		floor.immovable = true;
		floor.moves = false;
		
		player = new Player();
		
		gui = new GUI();
		
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
		FlxG.overlap(player, moneyEmitter, playerMoneyOverlap);
	}	
	
	private function playerEnemyOverlap(player:FlxObject, enemy:FlxObject):Void
	{
		player.kill();
	}
	
	private function playerMoneyOverlap(player:FlxObject, money:FlxObject):Void
	{
		money.kill();
		Reg.score += 1;
	}
}