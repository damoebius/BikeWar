package com.tamina.bikewar.ui;
import org.tamina.events.CreateJSEvent;
import createjs.easeljs.Ticker;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Stage;
import js.HTMLCanvasElement;

class MapUI extends Stage {

    private var _width:Int;
    private var _height:Int;
    private var _backgroundBitmap:Bitmap;


    public function new(display:HTMLCanvasElement, width:Int, height:Int) {
        super(display);
        _width = width;
        _height = height;
        _backgroundBitmap = new Bitmap("images/map.png");
        this.addChild(_backgroundBitmap);
        Ticker.addEventListener(CreateJSEvent.TICKER_TICK, tickerHandler);
    }

    private function tickerHandler():Void {
        this.update();
    }
}
