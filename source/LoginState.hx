package;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.ui.FlxButton;
import flixel.addons.api.FlxGameJolt;
import flixel.FlxG;
import flash.text.TextFieldType;
import flash.utils.ByteArray;

/**
 * ...
 * @author Shalmezad
 */
@:file("assets/data/gamejolt_api.privatekey") class GameJoltPrivateKey2 extends ByteArray { }
class LoginState extends FlxState
{
	var txtUserName:FlxTextField;
	var txtToken:FlxTextField;
	var btnLogin:FlxButton;
	var status:FlxText;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void
	{
		super.update();
		
		var title:FlxText = new FlxText(0, 30, Main.gameWidth, "Please log into GameJolt:");
		title.alignment = "center";
		add(title);
		
		var lblUserName:FlxText = new FlxText(50, 100, 0, "Username:");
		var lblToken:FlxText = new FlxText(50, 120, 0, "Token:");
		add(lblUserName);
		add(lblToken);
		
		txtUserName = new FlxTextField(110, 100, 100," ");
		txtToken = new FlxTextField(110, 120, 100, " ");
		
		var bg1:FlxSprite = new FlxSprite(txtUserName.x, txtUserName.y);
		bg1.makeGraphic(Std.int(txtUserName.width), Std.int(18), 0xFF999999);
		add(bg1);
		
		var bg2:FlxSprite = new FlxSprite(txtToken.x, txtToken.y);
		bg2.makeGraphic(Std.int(txtToken.width), Std.int(18), 0xFF999999);
		add(bg2);
		
		txtUserName.color = txtToken.color = 0xFFFFFFFF;
		txtUserName.borderSize = txtToken.borderSize = 2;
		txtUserName.borderColor = txtToken.borderColor = 0xFFFFFFFF;
		txtUserName.textField.selectable = txtToken.textField.selectable = true;
		txtUserName.textField.multiline = txtToken.textField.multiline = false;
		txtUserName.textField.wordWrap = txtToken.textField.wordWrap = false;
		txtUserName.textField.maxChars = txtToken.textField.maxChars = 30;
		txtUserName.textField.type = txtToken.textField.type = TextFieldType.INPUT;
		
		add(txtUserName);
		add(txtToken);
		
		btnLogin =  new FlxButton(120, 150, "Login", login);
		status = new FlxText(0, 180, Main.gameWidth);
		add(btnLogin);
		add(status);
		
		var ba:ByteArray = new GameJoltPrivateKey2();
		if (!FlxGameJolt.initialized) {
			FlxGameJolt.verbose = true;
			var privateKey:String = ba.readUTFBytes(ba.length);
			trace(privateKey);
			FlxGameJolt.init(80244, privateKey, true, null, null, initCallback);
		}
	}
	
	private function login():Void
	{
		btnLogin.visible = false;
		status.text = "Logging in...";
		FlxGameJolt.authUser(StringTools.trim(txtUserName.text), StringTools.trim(txtToken.text), initCallback);
	}
		private function initCallback(Result:Bool):Void
	{
		//if (_connection != null) {
			if (Result) {
				trace("Good to go");
				FlxG.switchState(new MenuState());
			} else {
				trace("Uh-oh.");
				status.text = "Failed to log in";
				btnLogin.visible = true;
				/*
				if (_connection != null) {
					_connection.text = "Unable to verify your information with GameJolt.";
				}
				_login.visible = true;
				_login.active = true;
				*/
			}
		//}
	}
}