import flixel.*;
import flixel.FlxG in Flixel;
import flixel.effects.particles.*;
class Person extends FlxSprite {
	var emitter:FlxEmitter;
	var hasBeenAdded:Bool;
	var isDead:Bool;
	public function new(asset:String) {
		super(0, 0, asset);
		this.emitter = new FlxEmitter();
		this.emitter.gravity = 200;
		this.emitter.makeParticles(new flash.display.BitmapData(7, 7, false, 0xFFFFFFFF));
		this.emitter.width = this.width;
		this.emitter.height = this.height;
		hasBeenAdded = false;
		emitter.setColor(0xFFFF0000, 0xFF00FF00);
		this.health = 100;
		this.width = 32;
		this.height = 48;
		this.solid = true;
		this.acceleration.y = this.width * this.height * ySpeed();
		this.maxVelocity.x = this.width * 8;
		this.maxVelocity.y = this.height * 7;
		this.drag.x = this.maxVelocity.x * 0.9;
		this.y = FlxG.height - this.height - Platform.HEIGHT;
		isDead = false;
	}
	public override function update() {
		if(this.isTouching(flixel.FlxObject.FLOOR)) {
			this.velocity.y = 0;
			this.drag.y = 0;
			this.acceleration.y = 0;
		} else
			this.acceleration.y = this.width * this.height * ySpeed();
		this.scale.set(this.facing == FlxObject.LEFT ? -1 : 1, 1);
		super.update();
	}
	public function ySpeed()
		return 0.18;
	public function loseHealth(a:Float) {
		if(!hasBeenAdded) {
			var ps:PlayState = cast FlxG.state;
			ps.emitters.add(this.emitter);
		}
		FlxG.sound.play("assets/hurt.wav", a * 0.01, false, true).amplitude = this.x / FlxG.width;
		this.health -= a;
		emitter.at(this);
		this.emitter.setXSpeed(this.velocity.x * 0.2, this.velocity.x);
		this.emitter.setYSpeed(this.velocity.y * 0.2, this.velocity.y);
		emitter.start(true, a, a * 0.1, Std.int(a * 0.15), a);
		if(this.health < 0) {
			this.isDead = true;
			this.die();
		}
	}
	public function die() {
		this.visible = false;
	}
	public function jump() {
		this.acceleration.y = this.width * this.height * ySpeed();
		this.velocity.y = -this.height * 10;
	}
	static inline function square(n)
		return n * n;
}