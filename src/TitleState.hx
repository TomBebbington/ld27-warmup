import flixel.FlxState;
import flixel.FlxG.*;
import flixel.text.*;
import flixel.util.*;
class TitleState extends FlxState {
	static inline var BG_COLOR = 0xFF020100;
	var title:FlxText;
	var play:FlxText;
	var highScore:FlxText;
	public override function create() {
		this.bgColor = BG_COLOR;
		super.create();
		title = new FlxText(width * 0.1,0, Math.ceil(width * 0.8), "Zombeh!", Math.ceil(width * 0.1));
		title.alignment = "center";
		title.color = 0xFFD6F5D8;
		this.add(title);
		this.add(play = new FlxText(width * 0.25, height * 0.8, Math.ceil(width * 0.5), "Play", 40));
		play.color = 0xFFC0C0C0;
		play.alignment = "center";
		var scoreSave = new FlxSave();
		scoreSave.bind("zombeh");
		var score:Float = scoreSave.data.score != null ? Std.parseFloat(scoreSave.data.score) : 0;
		this.add(highScore = new FlxText(width * 0.25, height * 0.5, Math.ceil(width * 0.5), 'High score: $score', 30));
		highScore.alignment = "center";
	}
	public function triggerPlay() {
		switchState(new PlayState());
	}
	public override function update() {
		if(keys.pressed.SPACE || keys.pressed.X || keys.pressed.Z || (mouse.justPressed && play.overlapsPoint(new FlxPoint(mouse.x, mouse.y))))
			triggerPlay();
		#if sys
		if(keys.justPressed.ESCAPE)
			Sys.exit(0);
		#end
		super.update();
	}
}