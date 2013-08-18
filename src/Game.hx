import flash.display.*;
import flash.events.*;
import flash.Lib.*;
import flixel.*;
class Game extends FlxGame {
	public function new() {
		super(current.stage.stageWidth, current.stage.stageHeight, TitleState);
		this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	function onAdded(_) {
		this.stage.addEventListener(Event.RESIZE, onResized);
	}
	function onResized(_) {
		FlxG.width = Math.ceil(FlxG.stage.stageWidth / FlxCamera.defaultZoom);
		FlxG.height = Math.ceil(FlxG.stage.stageHeight / FlxCamera.defaultZoom);
	}
}