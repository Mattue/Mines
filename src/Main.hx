package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Zergling
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}

	var fon: Sprite;
	var pl: Sprite;
	var mine: Sprite;
	var mines: Array<Sprite> = [];
	var minesWhite: Array<Sprite> = [];

	var whitePlate: Sprite;

	var winPlate: Sprite;
	
	function init() 
	{
		if (inited) return;
		inited = true;

		fon = new Sprite();
		fon.graphics.beginFill(0xff0000);
		fon.graphics.drawRect(0,0,800,480);
		addChild(fon);

		whitePlate = new Sprite();
		whitePlate.graphics.beginFill(0xffffff);
		whitePlate.graphics.drawRect(0,0, 800, 240);
		addChild(whitePlate);

		pl = new Sprite();
		pl.graphics.beginFill(0x00ff00);
		pl.graphics.drawCircle(0,0,10);
		pl.x = 800;
		pl.y = 480;
		addChild(pl);

		winPlate = new Sprite();
		winPlate.graphics.beginFill(0x00ff00);
		winPlate.graphics.drawRect(0,0,800,10);
		addChild(winPlate);

		for (i in 0 ... 100)
		{
			addMineRed();
		}

		for (i in 0 ... 100)
		{
			addMineWhite();
		}

		addEventListener(Event.ENTER_FRAME, onFrame);

		Lib.current.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function mouseMove(e:MouseEvent)
	{
	    pl.x = e.stageX;
	    pl.y = e.stageY;
	}

	public function addMineWhite()
	{
	    var mine = new Sprite();
	    mine.graphics.beginFill(0x0000ff);
	    mine.graphics.drawCircle(0,0,10);
	    mine.x = Math.random() * 800;
	    mine.y = Math.random() * 180 + 25;
	    minesWhite.push(mine);
	    addChild(mine);
	}

	public function addMineRed()
	{
	    var mine = new Sprite();
	    mine.graphics.beginFill(0x0000ff);
	    mine.graphics.drawCircle(0,0,10);
	    mine.x = Math.random() * 800;
	    mine.y = Math.random() * 180 + 250;
	    mine.alpha = 0;
	    mines.push(mine);
	    addChild(mine);
	}

	var frame: Int = 0;
	var col: Float = 0;
	var colWhite: Float = 0;

	public function onFrame(e:Event)
	{
	    frame++;

	   	if (pl.y < winPlate.y + 20)
    	{
    	    trace("WIN");
	    }

	    for (i in 0 ... mines.length)
	    {
	    	col = Math.sqrt(Math.pow(Math.abs(pl.x - mines[i].x),2) + Math.pow(Math.abs(pl.y - mines[i].y),2));

	    	if (col < 20)
	    	{
	    		trace("LOSE");
	    	}

	    	if (col < 100)
	    	{
	    		mines[i].alpha = 10/col;
	    	}
	    	else
	    	{
	    		mines[i].alpha = 0;
	    	}

	    }

	    for (i in 0 ... minesWhite.length)
	    {
	    	col = Math.sqrt(Math.pow(Math.abs(pl.x - minesWhite[i].x),2) + Math.pow(Math.abs(pl.y - minesWhite[i].y),2));

	    	if (col < 20)
	    	{
	    		trace("LOSE");
	    	}

	    	if (col < 100)
	    	{
	    		minesWhite[i].alpha = col/100;
	    	}
	    	else
	    	{
	    		minesWhite[i].alpha = 1;
	    	}

	    }
	}

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
