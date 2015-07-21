package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;


class MenuState extends FlxState {

	override public function create():Void {

		FlxG.mouse.visible = false;

		//Title
		var titleText:FlxText;
		titleText = new FlxText(0, FlxG.height / 2 - 20, FlxG.width, "PAINT THING");
		titleText.setFormat(null, 16, 0xffffff, "center");
		add(titleText);

		//Subtitle 
		var subText:FlxText; 
		subText = new FlxText(0, FlxG.height - 30, FlxG.width, "click to paint");
		subText.setFormat(null, 8, 0xffffff, "center");
		add(subText);

        //Adding text 
        add(titleText);
        add(subText);

		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
		if (FlxG.mouse.justPressed) {
			FlxG.switchState(new PlayState());
		}
	}	
}