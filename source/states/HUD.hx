package states;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.actions.FlxAction.FlxActionAnalog;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedSpriteGroup<FlxSprite>
{
	private var _textScore:FlxText;
	private var _textTime:FlxText;
	private var _textCoin:FlxText;
	private var _textWorld:FlxText;

	private var _iconCoin:FlxSprite;

	static inline var OFFSET:Int = 4;

	public function new()
	{
		super();

		_textScore = new FlxText(OFFSET, OFFSET, 0);
		_textCoin = new FlxText(FlxG.width * 0.33, OFFSET + 10, 0);
		_textWorld = new FlxText(FlxG.width * 0.66, OFFSET, 0);
		_textTime = new FlxText(OFFSET, OFFSET, FlxG.width - OFFSET * 2);

		add(_textScore);
		add(_textCoin);
		add(_textWorld);
		add(_textTime);

		forEachOfType(FlxText, function(member)
		{
			member.setFormat(AssetPaths.pixel_font__ttf, 8, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xff005784);
		}, false);

		_textScore.alignment = FlxTextAlign.LEFT;
		_textCoin.alignment = FlxTextAlign.CENTER;
		_textWorld.alignment = FlxTextAlign.CENTER;
		_textTime.alignment = FlxTextAlign.RIGHT;

		_iconCoin = new FlxSprite(FlxG.width * 0.33 - 4, OFFSET + 10 + 4);
		_iconCoin.loadGraphic(AssetPaths.hud__png, true, 8, 8);
		_iconCoin.animation.add("coin", [0], 0);
		_iconCoin.animation.play("coin");

		add(_iconCoin);

		forEach(function(member)
		{
			member.scrollFactor.set(0, 0);
		}, false);
	}

	override public function update(elapsed:Float)
	{
		_textScore.text = "SCORE\n" + StringTools.lpad(Std.string(Reg.score), "0", 5);
		_textCoin.text = "  x " + StringTools.lpad(Std.string(Reg.coins), "0", 2);
		_textTime.text = "TIME\n" + StringTools.lpad(Std.string(Math.floor(Reg.time)), "0", 3);
		_textWorld.text = "STAGE\n" + Reg.level;
		super.update(elapsed);
	}
}
