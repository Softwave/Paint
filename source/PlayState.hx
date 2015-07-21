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
    public var bg2:FlxSprite;

    //BRUSH
    public var brush:FlxSprite;
    //UI
    public var menuBG:FlxSprite;

    //SPRITES

    //EFFECTS AND SHADER STUFF
    public var effectsOn:Bool = false; 
    public var weirdMode:Bool = false; 
    public var s:ShaderFilter;
    public var r:TweenHelper; 
    public var g:TweenHelper;
    public var b:TweenHelper;

    //VARS
    public var brushSize:Int = 6;

    override public function create():Void {
        FlxG.cameras.bgColor = 0x11e76498;

        bg = new FlxSprite(0, 0);
        bg.makeGraphic(128, 128, 0xffffffff);

        bg2 = new FlxSprite(0, 0);
        bg2.makeGraphic(128, 128, 0xffffffff);

        brush = new FlxSprite(0,0);
        brush.makeGraphic(6, 6, 0xff2C3872);

        //

        //EFFECTS AND SHADER STUFF
        r = new TweenHelper();
        g = new TweenHelper();
        b = new TweenHelper();
        var _s:Shader = new Shader(new Splitter());
        s = new ShaderFilter(_s);

        add(bg2);
        add(bg);
        add(brush);
 


        //CAMERA EFFECTS
        FlxG.camera.useBgAlphaBlending = true;
        bg.alpha = 0.1;
        bg2.alpha = 0.1;

        super.create();
    }

    override public function update():Void {
        //MOVE BRUSH TO MOUSE
        brush.x = FlxG.mouse.x;
        brush.y = FlxG.mouse.y;

        //ROW 1
        if (FlxG.keys.pressed.C) {
            bg.framePixels.copyPixels(brush.framePixels, brush.framePixels.rect, new Point(brush.x, brush.y), brush.framePixels);
        }
        if (FlxG.mouse.pressed) {
            bg.framePixels.copyPixels(brush.framePixels, brush.framePixels.rect, new Point(brush.x, brush.y), brush.framePixels);
        }

        //ROW 2
        if(FlxG.keys.justPressed.A) {
            //bg.framePixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point(0, 0), bg2.framePixels);
        }
        if (FlxG.keys.justPressed.S) {
            //bg.framePixels.copyPixels(FlxG.camera.buffer, FlxG.camera.buffer.rect, new Point(0, 0), FlxG.camera.buffer);
        }
        if (FlxG.keys.pressed.D) {
            TweenHelper.distort(r,-1,1);
            TweenHelper.distort(g,-1,1);
            TweenHelper.distort(b,-1,1);
        }
        if (FlxG.keys.pressed.F) {
            TweenHelper.distort(r,0,0);
            TweenHelper.distort(g,0,0);
            TweenHelper.distort(b,0,0);
        }

        if (FlxG.keys.justPressed.G) {
            brushSize += 1;
            brush.makeGraphic(brushSize, brushSize, 0xff2C3872);
        }

        if (FlxG.keys.justPressed.H) {
            brushSize -= 1;
            brush.makeGraphic(brushSize, brushSize, 0xff2C3872);
        }
        
        //ROW 3
        if (FlxG.keys.justPressed.W) {
            //weirdMode = !weirdMode;
        }
        if (FlxG.keys.pressed.R) {
            rColTwo(brush);
        }
        if (FlxG.keys.pressed.T) {
            rColTwo(bg);
            FlxG.camera.screen.color = bg.color;
        }

        if (FlxG.keys.pressed.N) {
            pNoise(brush);
        }


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

    public function rColTwo(Obj1:FlxSprite):Void {
        var w:Int = Std.int(Obj1.width);
        var h:Int = Std.int(Obj1.height);
        var randCol = new BitmapData(w,h,false,0);
        randCol = Obj1.framePixels; 

        var newCol:UInt = FlxRandom.color(10, 255);

        for (i in 0...h) {
            for (j in 0...w) {
                randCol.setPixel(j,i, newCol);
            }
        }
    }

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