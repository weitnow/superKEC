package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class Coin extends FlxSprite
{
	private static var SCORE_AMOUNT:Int = 20;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.items__png, true, 16, 16);

		animation.add("idle", [0, 1, 2, 3, 4], 16);
		animation.play("idle");
	}

	public function collect()
	{
		Reg.score += SCORE_AMOUNT;
		Reg.coins++;
		if (Reg.coins >= 100)
		{
			Reg.lives++;
			Reg.coins = 0;
		}

		kill();
	}
}
