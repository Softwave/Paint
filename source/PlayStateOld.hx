package;

//FLIXEL
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
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

//FLIXEL ADDONS
import flixel.addons.effects.FlxWaveSprite;
import flixel.addons.effects.FlxGlitchSprite;

//FLASH
import flash.display.BitmapDataChannel;
import flash.display.BlendMode;
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

@:file("assets/shaders/Col.pbj") class Splitter extends ByteArray { }

class PlayState extends FlxState {
    /* VARIABLES GO HERE */

    //BACKGROUND
    public var bg:FlxSprite;

    //BRUSH
    public var brush:FlxSprite;

    //EFFECTS AND SHADER STUFF
    public var effectsOn:Bool = false; 
    public var weirdMode:Bool = false; 
    public var s:ShaderFilter;
    public var r:TweenHelper; 
    public var g:TweenHelper;
    public var b:TweenHelper;

    override public function create():Void {
        FlxG.cameras.bgColor = 0x00e76498;

        bg = new FlxSprite(0, 0);
        bg.loadGraphic("assets/images/bg.png");

        brush = new FlxSprite(0,0);
        brush.loadGraphic("assets/images/brush.png");

        //EFFECTS AND SHADER STUFF
        r = new TweenHelper();
        g = new TweenHelper();
        b = new TweenHelper();
        var _s:Shader = new Shader(new Splitter());
        s = new ShaderFilter(_s);

        add(bg);
        add(brush);

        //CAMERA EFFECTS
        FlxG.camera.useBgAlphaBlending = true;

        //
        //brush.blend = BlendMode.ADD;
        //bg.alpha = 0.6;

        super.create();
    }

    override public function update():Void {
        //MOVE BRUSH TO MOUSE
        brush.x = FlxG.mouse.x;
        brush.y = FlxG.mouse.y;

        

        super.update();
    }

    override public function draw():Void {
        super.draw();

        s.shader.data.or.value = [r.x, r.y];
        s.shader.data.og.value = [g.x, g.y];
        s.shader.data.ob.value = [b.x, b.y];
        
        FlxG.camera.buffer.applyFilter(FlxG.camera.buffer,
            new Rectangle(0, 0, FlxG.width, FlxG.height),
            new Point(0, 0),
            s);
    }

    override public function destroy():Void {
        super.destroy();
    }

    public function drawOn(Obj1:BitmapData):Void {
        //Obj1.framePixels.draw(brush.framePixels, new Matrix(7, 0, 0, 1, 8, 0));
        Obj1.copyPixels(brush.framePixels, brush.framePixels.rect, new Point(brush.x, brush.y));
    }
    /* SPECIAL EFFECTS FUNCTIONS */
    //random colour 
    public function rCol(Obj1:FlxSprite):Void {
        var w:Int = Std.int(Obj1.width);
        var h:Int = Std.int(Obj1.height);
        var randCol = new BitmapData(w,h,false,0);
        randCol = Obj1.framePixels; 

        for (i in 0...h) {
            for (j in 0...w) {
                randCol.setPixel(j,i, FlxRandom.color(10, 255) );
            }
        }
    } //end r col

    public function rNoise(Obj1:FlxSprite):Void {
        var w:Int = Std.int(Obj1.width);
        var h:Int = Std.int(Obj1.height);
        var randNoise = new BitmapData(5,10,false,0xFFFFFFFF);
        randNoise = Obj1.framePixels; 

        randNoise.noise( FlxRandom.int() , 0 , 255 , BitmapDataChannel.BLUE | BitmapDataChannel.GREEN | BitmapDataChannel.RED, false);
        Obj1.framePixels = randNoise; 
    } //end r noise 

    public function pNoise(Obj1:FlxSprite):Void {
        var w:Int = Std.int(Obj1.width);
        var h:Int = Std.int(Obj1.height);
        var perlinNoise = new BitmapData(5,10,false,0xFFFF00AA);
        perlinNoise = Obj1.framePixels;

        perlinNoise.perlinNoise(10,h,6,FlxRandom.int(),false,false,BitmapDataChannel.BLUE| BitmapDataChannel.RED | BitmapDataChannel.GREEN | BitmapDataChannel.ALPHA,false);
        Obj1.framePixels = perlinNoise;
    } //end p noise

}