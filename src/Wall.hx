import flixel.*;

class Wall extends FlxSprite {
	var cx:Float;
	var cy:Float;
	public function new(x:Float, y:Float, w:Int, h:Int):Void {
		super(cx = x, cy = y);
		this.solid = true;
		this.makeGraphic(w, h, 0xFF121314);
	}
	public function at(x:Float, y:Float):Wall {
		this.setPosition(cx = x, cy = y);
		return this;
	}
	public override function update() {
		this.velocity.set(0, 0);
		this.setPosition(cx, cy);
		super.update();
	}
}