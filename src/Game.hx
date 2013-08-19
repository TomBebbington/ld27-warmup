import flash.display.*;
import flash.events.*;
import flash.Lib.*;
import flixel.*;
import flixel.system.*;
import openfl.Assets;
class Game extends FlxGame {
	//var music:FlxSound;
	public function new() {
		super(current.stage.stageWidth, current.stage.stageHeight, TitleState);
		this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	function onAdded(_) {
		this.stage.addEventListener(Event.RESIZE, onResized);
		FlxG.sound.playMusic("assets/zombies-are-coming.ogg", 0.5);
	}
	function onResized(_) {
		FlxG.width = Math.ceil(FlxG.stage.stageWidth / FlxCamera.defaultZoom);
		FlxG.height = Math.ceil(FlxG.stage.stageHeight / FlxCamera.defaultZoom);
	}
}