import flixel.text.*;
import flixel.*;
class ScoreEarn extends FlxText {
	public function new(score:Int) {
		cast(FlxG.state, PlayState).score += score;
		super(0, 0, 100, (score > 0 ? "+" : "") + Std.string(score), 15);
		this.alignment = "center";
		this.maxVelocity.y = this.height * 3;
	}
	public function on(o:FlxObject) {
		this.x = o.x + (o.width - this.width) * 0.5;
		this.y = o.y - this.height;
		return this;
	}
	public override function update() {
		this.alpha -= FlxG.elapsed * 1.9;
		this.y -= this.maxVelocity.y * FlxG.elapsed;
		if(this.alpha < 0)
			FlxG.state.remove(this);
		super.update();
	}
}