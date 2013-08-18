import flixel.*;
import flixel.system.*;
class Player extends Person {
	static inline var BULLET_TIME = 0.3;
	public var dir:Int;
	var bulletTimer:Float;
	public override function new() {
		super("assets/person.png");
		this.width = 50;
		this.height = 67;
		this.x = (FlxG.width - this.width) * 0.5;
		this.y = 0;
		this.bulletTimer = -1;
	}
	public override function update() {
		this.acceleration.x = 0;
		if(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A) {
			this.acceleration.x = -this.maxVelocity.x;
			dir = 0;
			this.facing = FlxObject.LEFT;
		} else if(FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) {
			this.acceleration.x = this.maxVelocity.x;
			dir = 1;
			this.facing = FlxObject.RIGHT;
		} else if(FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
			dir = 2;
		else if(FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
			dir = 3;
		if(FlxG.keys.justPressed.X || FlxG.keys.justPressed.ALT) {
			this.shoot();
			bulletTimer = FlxG.elapsed;
		}
		else if(FlxG.keys.pressed.X || FlxG.keys.pressed.ALT) {
			bulletTimer += FlxG.elapsed;
			if(bulletTimer > BULLET_TIME) {
				bulletTimer -= BULLET_TIME;
				this.shoot();
			}
		}
		if((FlxG.keys.pressed.SPACE || FlxG.keys.pressed.Z) && this.velocity.y == 0)
			this.jump();
		super.update();
	}
	public function shoot() {
		cast(FlxG.state, PlayState).bullets.add(new Bullet(this));
	}
	public function hitZombie() {
		if(deathTimer == null) {
			this.loseHealth(50);
			FlxG.state.add(new ScoreEarn(-10).on(this));
		}
	}
	var deathTimer:flash.utils.Timer = null;
	public override function die() {
		super.die();
		FlxG.state.remove(this);
		var play:PlayState = cast FlxG.state;
		deathTimer = new flash.utils.Timer(1000);
		deathTimer.addEventListener(flash.events.TimerEvent.TIMER, function(_) {
			play.restart();
			deathTimer.stop();
		});
		deathTimer.start();
	}
	public override function jump() {
		super.jump();
		FlxG.sound.play("assets/jump.wav", 0.3, false, true).amplitude = (this.x + this.width * 2) / FlxG.width;
	}
}