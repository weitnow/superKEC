package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxBaseTilemap;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var map:FlxTilemap;
	var player:FlxSprite;
	var mapData:Array<Int> = [
		1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	];

	override public function create():Void
	{
		map = new FlxTilemap();
		map.loadMapFromArray(mapData, 20, 12, AssetPaths.tiles__png, 16, 16);
		add(map);

		player = new FlxSprite(64, 0);
		player.makeGraphic(16, 16, FlxColor.RED);
		player.acceleration.y = 420;
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(map, player);
		movePlayer();
	}

	private function movePlayer():Void
	{
		player.velocity.x = 0;

		if (FlxG.keys.pressed.A)
			player.velocity.x -= 80;

		if (FlxG.keys.pressed.D)
			player.velocity.x += 80;

		if (FlxG.keys.justPressed.C && player.isTouching(FLOOR))
			player.velocity.y = -200;
	}
}
