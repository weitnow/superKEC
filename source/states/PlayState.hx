package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxBaseTilemap;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import objects.Coin;
import objects.Enemy;
import objects.Player;
import utils.LevelLoader;

class PlayState extends FlxState
{
	public var map:FlxTilemap;
	public var player(default, null):Player;
	public var items:FlxTypedGroup<FlxSprite>;
	public var enemies:FlxTypedGroup<Enemy>;

	private var _hud:HUD;

	override public function create():Void
	{
		items = new FlxTypedGroup<FlxSprite>();
		player = new Player();
		_hud = new HUD();
		enemies = new FlxTypedGroup<Enemy>();

		LevelLoader.loadLevel(this, "playground");

		add(player);
		add(items);
		add(_hud);
		add(enemies);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(map, player);
		FlxG.overlap(items, player, collideItems);
	}

	function collideItems(coin:Coin, player:Player):Void
	{
		coin.collect();
	}
}
