import flixel.*;
import flixel.text.*;
class RoundChange extends FlxText {
	public function new(r:Int) {
		super((FlxG.width - 300) * 0.5, FlxG.height * 0.5, 300, 'Round $r', 40);
		this.color = 0xFFFFFFFF;
		this.alignment = "center";
	}
	public override function update() {
		this.alpha -= FlxG.elapsed * 0.5;
		if(this.alpha < 0)
			FlxG.state.remove(this);
	}
}