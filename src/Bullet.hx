import flixel.*;

class Bullet extends FlxSprite {
	public static inline var BID = 28;
	public function new(p:Player) {
		var dir = p.dir;
		var width = 30;
		super(0, 0);
		this.ID = BID;
		this.solid = false;
		this.makeGraphic(width, 8, 0xFF573264);
		this.maxVelocity.x = width * 20;
		this.maxVelocity.y = width * 20;
		switch(dir) {
			case 0: //left
				setPosition(p.x - width, p.y + p.height * 0.3);
				this.velocity.x = -this.maxVelocity.x;
				this.maxVelocity.y = 0;
			case 1: //right
				setPosition(p.x + p.width, p.y + p.height * 0.3);
				this.velocity.x = this.maxVelocity.x;
				this.maxVelocity.y = 0;
			case 2: //up
				setPosition(p.x + (p.width - this.width) * 0.5, p.y - this.height);
				this.velocity.y = -this.maxVelocity.y;
				this.angle = 90;
				this.maxVelocity.x = 0;
			case 3: //down
				setPosition(p.x + (p.width - this.width) * 0.5, p.y + p.height);
				this.velocity.y = this.maxVelocity.y;
				this.angle = 90;
				this.maxVelocity.x = 0;
			default:
		}
		FlxG.sound.play("assets/shoot.wav", 0.5, false, true);
	}
	public override function update() {
		this.velocity.x = this.velocity.x > 0 ? this.maxVelocity.x : -this.maxVelocity.x;
		this.velocity.y = this.velocity.y > 0 ? this.maxVelocity.y : -this.maxVelocity.y;
		super.update();
	}
}