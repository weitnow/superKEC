package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class Player extends FlxSprite
{
	private static inline var ACCELERATION:Int = 320;
	private static inline var DRAG:Int = 320;
	private static inline var GRAVITIY:Int = 600;
	private static inline var JUMP_FORCE:Int = -280;
	private static inline var WALK_SPEED:Int = 80;
	private static inline var RUN_SPEED:Int = 140;
	private static inline var FALLING_SPEED:Int = 300;

	public var direction:Int = 1;

	public function new()
	{
		super();
		loadGraphic(AssetPaths.player__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3, 2], 12);
		animation.add("skid", [4]);
		animation.add("jump", [5]);
		animation.add("fall", [5]);
		animation.add("dead", [12]);

		setSize(8, 12);
		offset.set(4, 4);

		drag.x = DRAG;
		acceleration.y = GRAVITIY;
		maxVelocity.set(WALK_SPEED, FALLING_SPEED);
	}

	override public function update(elapsed:Float):Void
	{
		move();
		animate();

		super.update(elapsed);
	}

	private function move()
	{
		acceleration.x = 0;

		if (FlxG.keys.pressed.A)
		{
			flipX = true;
			direction = -1;
			acceleration.x -= ACCELERATION;
		}
		else if (FlxG.keys.pressed.D)
		{
			flipX = false;
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if (FlxG.keys.justPressed.W && isTouching(FLOOR))
				velocity.y = JUMP_FORCE;

			if (FlxG.keys.pressed.H)
				maxVelocity.x = RUN_SPEED;
			else
				maxVelocity.x = WALK_SPEED;
		}

		if ((velocity.y < 0) && (FlxG.keys.justReleased.W))
			velocity.y = velocity.y * 0.5;

		if (x < 0)
			x = 0;
	}

	private function animate()
	{
		if ((velocity.y <= 0) && (!isTouching(FLOOR)))
			animation.play("jump");
		else if (velocity.y > 0)
			animation.play("fall");
		else if (velocity.x == 0)
			animation.play("idle");
		else
		{
			if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction))
				animation.play("skid");
			else
				animation.play("walk");
		}
	}
}
