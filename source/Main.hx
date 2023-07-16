package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.PlayState;

class Main extends Sprite
{
	public static inline var SHOW_INTRO:Bool = false;

	public function new()
	{
		super();
		addChild(new FlxGame(320, 180, PlayState, 60, 60, !SHOW_INTRO));
	}
}
