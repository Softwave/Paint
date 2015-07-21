package; 

//FLIXEL
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.group.FlxGroup; 
import flixel.group.FlxTypedGroup; 
import flixel.group.FlxSpriteGroup; 
import flash.display.BlendMode;
import flixel.tweens.FlxTween; 
import flixel.tweens.FlxEase;
import flixel.effects.particles.FlxEmitter;
import flixel.text.FlxBitmapTextField;
import flixel.text.pxText.PxBitmapFont;
import flixel.text.pxText.PxTextAlign;
import flixel.util.FlxRandom;
import flixel.FlxCamera; 
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;

import flixel.tweens.misc.VarTween;


//FLIXEL ADDONS
import flixel.addons.effects.FlxWaveSprite;
import flixel.addons.effects.FlxGlitchSprite;
import flixel.addons.text.FlxTypeText;
import flixel.addons.plugin.control.FlxControl;



import flash.display.BlendMode;
import flash.display.BitmapDataChannel;
import flash.display.BitmapData;
import flash.utils.ByteArray;
import flash.filters.ShaderFilter;
import flash.display.Shader;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.BitmapData;
import flash.geom.Matrix;


//OPENFL
import openfl.Assets;

//USING
using flixel.util.FlxSpriteUtil;
using StringTools;

class TweenHelper {
	public var y:Float = 0;
	public var x:Float = 0;
	
	public function new() { }
	
	static public function randRange(min:Float, max:Float):Int {
        //var randomNum:Int = Math.floor(Math.random() * (Std.int(max) - Std.int(min) + 1)) + Std.int(min);
        var randomNum:Int = FlxRandom.intRanged(Std.int(min),Std.int(max));
        return randomNum;
    }
	
	static public function distort(img:TweenHelper,min:Float,max:Float):Void
	{
		var opt:TweenOptions = { };
		opt.ease = FlxEase.sineInOut;
		opt.complete = distortx;
		
		FlxTween.tween(img, {
								y: randRange( min, max),	// randomize y shift
								x: randRange(min,max),
								}
							, randRange(1, 2) / 10,
							opt
							);

	}
	
	static public function distortx(flx:FlxTween):Void
	{

	}
}