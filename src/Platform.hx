import flixel.*;

class Platform extends FlxSprite {
	public static inline var HEIGHT = 20;
	var cx:Float;
	var cy:Float;
	public function new(width:Int) {
		super();
		this.makeGraphic(width, HEIGHT, 0xFF121314);
		this.maxVelocity.set(0, 0);
		this.acceleration.set(0, 0);
		this.ID = flixel.FlxObject.FLOOR;
	}
	public function at(x:Float, y:Float):Platform {
		this.setPosition(x, y);
		cx = x;
		cy = y;
		return this;
	}
	public override function update() {
		this.velocity.set(0, 0);
		this.setPosition(cx, cy);
		super.update();
	}
}