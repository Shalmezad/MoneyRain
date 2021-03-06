package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import flixel.addons.api.FlxGameJolt;

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
	
	var blood:FlxEmitter;
		
	var seed:Int;
	var runBar:FlxBar;
	
	var timeLeft:Int = 3;
	
	public function new(seed:Int = 88)
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
		
		FlxG.sound.muteKeys = ["m", "M"];
		
		createEntities();
		
		add(floor);
		add(player);
		add(bronzeMoneyEmitter);
		add(silverMoneyEmitter);
		add(goldMoneyEmitter);
		add(enemyEmitter);
		add(gui);
		add(runBar);
		#if flash
		FlxG.sound.playMusic(AssetPaths.gameloop__mp3);
		#else
		FlxG.sound.playMusic(AssetPaths.gameloop__ogg);
		#end
		new FlxTimer(Constants.CHANGE_THEME_TIME-3, changeThemeTick, 1);
	}
	
	private function changeThemeTick(f:FlxTimer):Void
	{
		//Look at this.timeLeft:
		if (this.timeLeft > 0)
		{
			gui.playText = Std.string(this.timeLeft);
			this.timeLeft -= 1;
			new FlxTimer(1, changeThemeTick, 1);
		}
		else
		{
			if (player.alive && player.visible)
			{
				this.timeLeft = 3;
				new FlxTimer(Constants.CHANGE_THEME_TIME-3, changeThemeTick, 1);
				changeTheme();
			}
		}
	}
	
	private function changeTheme():Void
	{
		//RESET EVERYTHING FIRST!
		bronzeMoneyEmitter.start(false, 0, Constants.BRONZE_FREQUENCY);
		silverMoneyEmitter.start(false, 0, Constants.SILVER_FREQUENCY);
		goldMoneyEmitter.start(false, 0, Constants.GOLD_FREQUENCY);
		bronzeMoneyEmitter.setAlpha(1,1,1,1);
		silverMoneyEmitter.setAlpha(1,1,1,1);
		goldMoneyEmitter.setAlpha(1,1,1,1);
		enemyEmitter.setAlpha(1,1,1,1);
		player.alpha = 1;
		
		//THEN, set the theme
		switch(FlxRandom.intRanged(0, 4))
		{
			case 0:
				gui.playText = "\"Nothing\"\n(No, seriously)";
			case 1:
				gui.playText = "\"Greed is Good\"\n(10 free coins)";
				Reg.score += 10;
			case 2: 
				gui.playText = "\"Sunny day\"\n(no moneycloud in sight)";
				bronzeMoneyEmitter.on = false;
				silverMoneyEmitter.on = false;
				goldMoneyEmitter.on = false;
				//bronzeMoneyEmitter.start(false, 0, 0);
				//silverMoneyEmitter.start(false, 0, 0);
				//goldMoneyEmitter.start(false, 0, 0);
			case 3:
				gui.playText = "\"Pay day!\"\n(More moolah)";
				bronzeMoneyEmitter.start(false, 0, Constants.BRONZE_FREQUENCY/2);
				silverMoneyEmitter.start(false, 0, Constants.SILVER_FREQUENCY/2);
				goldMoneyEmitter.start(false, 0, Constants.GOLD_FREQUENCY / 2);
			case 4:
				gui.playText = "\"Low power\"\n(Need moar power!)";
				bronzeMoneyEmitter.setAlpha(.5, .5, .5, .5);
				silverMoneyEmitter.setAlpha(.5, .5, .5, .5);
				goldMoneyEmitter.setAlpha(.5, .5, .5, .5);
				enemyEmitter.setAlpha(.5, .5, .5, .5);
				player.alpha = .5;
				
		}
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
		
		blood = new FlxEmitter(player.x + player.width / 2, player.y + player.height / 2, 40);
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
		FlxG.collide(blood, floor);
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
				FlxGameJolt.addScore(Std.string(Reg.score), Reg.score);
				
			}
		}
		else
		{
			runBar.percent = 0;
			runBar.visible = false;
		}
		
		
		if (!player.visible || !player.alive)
		{
			if (InputUtil.JUMP_JUST_PRESSED())
			{
				endGame(null);
			}
		}
	}	
	
	private function killPlayer():Void
	{
		player.kill();
		//Store what they did have, we'll need it for later...
		var tempScore:Int = Reg.score;
		Reg.score = 0;
		new FlxTimer(Constants.GAME_OVER_TEXT_TIME, endGame, 1);
		
		blood.setColor(0xffaa0000, 0xffff0000);		
		blood.gravity = 200;
		blood.setXSpeed(-40, 40);
		blood.setPosition(player.x + player.width / 2, player.y + player.height / 2);
		for (i in 0...(Std.int(blood.maxSize / 2))) 
		{
			var _whitePixel:FlxParticle = new FlxParticle();
			_whitePixel.makeGraphic(3, 3, 0xffcc0000);
			// Make sure the particle doesn't show up at (0, 0)
			_whitePixel.visible = false; 
			blood.add(_whitePixel);
			_whitePixel = new FlxParticle();
			_whitePixel.makeGraphic(2, 2, 0xffcc0000);
			_whitePixel.visible = false;
			blood.add(_whitePixel);
		}
		blood.bounce = .8;
		add(blood);
		blood.start(true);
		FlxG.sound.music.fadeOut(2, 0);
	}
	
	private function playerEnemyOverlap(player:FlxObject, enemy:FlxObject):Void
	{
		if (player.alive && player.visible)
		{
			killPlayer();
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
		FlxG.sound.music.volume = 0;
		FlxG.switchState(new MenuState());
	}
}