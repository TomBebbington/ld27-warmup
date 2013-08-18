import flixel.*;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
class PlayState extends FlxState {
	static var maxZombies(get, never):Int;
	static inline function get_maxZombies():Int
		return 4 + Math.ceil(FlxG.height * 0.003);
	static inline var BG_COLOR = 0xFF029000;
	public var numZombies(get, never):Int;
	public var zombieCount:Int;
	public var scoreText:FlxText;
	public var score:Float;
	public var player:Player;
	public var zombies:FlxGroup;
	public var platforms:FlxGroup;
	public var bullets:FlxGroup;
	public var emitters:FlxGroup;
	public var round:Int;
	public var spawn:Platform;
	var camera:flixel.FlxCamera;
	inline function get_numZombies():Int {
		return Std.int(round * 0.15 * 25);
	}
	public override function create() {
		this.score = 0;
		this.round = 1;
		this.zombieCount = numZombies;
		this.bgColor = BG_COLOR;
		this.add(zombies = new FlxGroup());
		this.add(player = new Player());
		this.add(emitters = new FlxGroup());
		this.add(platforms = new FlxGroup());
		this.add(new RoundChange(round));
		platforms.add(new Platform(FlxG.width).at(-0, FlxG.height - Platform.HEIGHT));
		var nplats = Math.floor(FlxG.height / (Platform.HEIGHT * 8));
		for(i in 0...nplats) {
			var oy = Platform.HEIGHT * 8 * i;
			platforms.add(spawn = new Platform(Std.int(FlxG.width * 0.4)).at(FlxG.width * 0.3, FlxG.height - Platform.HEIGHT*6 - oy));
			platforms.add(new Platform(Std.int(FlxG.width * 0.2)).at(0, FlxG.height - Platform.HEIGHT*10 - oy));
			platforms.add(new Platform(Std.int(FlxG.width * 0.2)).at(FlxG.width * 0.8, FlxG.height - Platform.HEIGHT*10 - oy));
		}
		this.add(scoreText = new FlxText(0, 0, FlxG.width, "", 20));
		this.add(bullets = new FlxGroup());
		for(i in 0...maxZombies)
			makeZombie(false);
		this.cameras = [camera = new flixel.FlxCamera(0, 0, FlxG.width, FlxG.height)];
		super.create();
	}
	public function makeZombie(count:Bool = true) {
		var nZombies = 1;
		if(count && zombieCount <= 0) {
			round++;
			this.add(new RoundChange(round));
			zombieCount = numZombies;
			var z = new Zombie();
			z.atRound(round);
			zombies.add(z);
		}
		//for(_ in 0...nZombies) {
			if(count)
				zombieCount--;
			var z = new Zombie();
			z.on(this);
			z.atRound(round);
			zombies.add(z);
		//}
	}
	public function restart() {
		var s = new flixel.util.FlxSave();
		s.bind("zombeh");
		if(!Reflect.hasField(s.data, "score") || Reflect.field(s.data, "score") < this.score)
			Reflect.setField(s.data, "score" , this.score);
		s.flush();
		FlxG.switchState(new TitleState());
	}
	public override function update() {
		this.scoreText.text = 'Score: $score    Round: $round';
		if(FlxG.collide(player, zombies))
			player.hitZombie();
		FlxG.collide(zombies, bullets);
		FlxG.collide(zombies, platforms);
		FlxG.collide(zombies, zombies);
		FlxG.collide(player, platforms);
		FlxG.collide(emitters, platforms);
		for(z in zombies.members) {
			if(z != null) {
				var z:Zombie = cast z;
				z.approach(player);
				for(b in bullets.members) {
					if(b != null) {
						var b:Bullet = cast b;
						if(z.overlaps(b))
							z.loseHealth(50);
					}
				}
			}
		}
		camera.x = player.x;
		if(FlxG.keys.pressed.ESCAPE)
			restart();
		if(FlxG.keys.justPressed.R)
			restart();
		super.update();
	}
}