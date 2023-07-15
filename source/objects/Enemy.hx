package objects;

import flixel.FlxObject;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	private static inline var GRAVITY:Int = 420;
	private static inline var WALK_SPEED:Int = 40;
	private static inline var FALLING_SPEED:Int = 200;
	private static inline var SCORE_AMOUNT:Int = 100;

	private var _direction:Int = -1; // 1 = right and -1 = left
	private var _appeared:Bool = false; // is enemy visible within the screen?

	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.enemyA__png, true, 16, 16);
		animation.add("walk", [0, 1, 2, 1], 12);
		animation.add("dead", [3], 12);
		animation.play("walk");

		setSize(12, 12);
		offset.set(2, 4);
		acceleration.y = GRAVITY;
		maxVelocity.y = FALLING_SPEED;
	}

	override public function update(elapsed:Float)
	{
		if (!inWorldBounds())
			exists = false;

		if (isOnScreen())
			_appeared = true;

		if (_appeared && alive)
		{
			move();

			if (justTouched(FlxObject.WALL))
				flipDirection();
		}

		super.update(elapsed);
	}

	private function flipDirection()
	{
		flipX = !flipX;
		_direction = -_direction;
	}

	private function move()
	{
		velocity.x = _direction * WALK_SPEED;
	}
}
