import flixel.*;
class Zombie extends Person {
	var dySpeed:Float;
	public function new() {
		super("assets/zombeh.png");
		this.width = 50;
		this.height = 67;
		dySpeed = 0.15 + Math.random()*0.1;
		this.solid = true;
	}
	public function on(p:PlayState) {
		var pl:Platform = null;
		while(pl == null || pl == p.spawn || pl.x < 0 || pl.x + pl.width > FlxG.width)
			pl = cast p.platforms.getRandom();
		this.setPosition(pl.x <= 0 ? pl.x : pl.x + pl.width - this.width, pl.y - this.height);
		return this;
	}
	public function atRound(r:Int) {
		this.health = 100 + r * 5;
		this.maxVelocity.x = this.width * Math.min(r, 9) * (0.8 + Math.random() * 0.4);
	}
	public override function update() {
		super.update();
	}
	public override function ySpeed()
		return dySpeed;

	public override function die() {
		super.die();
		var ps:PlayState = cast FlxG.state;
		FlxG.state.add(new ScoreEarn(10).on(this));
		ps.makeZombie();
		ps.zombies.remove(this);
	}
	public function approach(p:Person) {
		var pcx = p.x + p.width * 0.5, zcx = this.x + this.width * 0.5;
		var isLeft = pcx < zcx;
		this.facing = isLeft ? FlxObject.LEFT : FlxObject.RIGHT;
		this.velocity.x = Math.abs(pcx - zcx) < 5 ? 0 : (isLeft ? -this.maxVelocity.x : this.maxVelocity.x);
		if((this.y + this.height > p.y + p.height || (this.overlaps(p) && this.y > p.y)) && this.velocity.y == 0)
			this.jump();
	}
}