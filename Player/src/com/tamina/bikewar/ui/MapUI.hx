package com.tamina.bikewar.ui;
import com.tamina.bikewar.data.MapData;
import org.tamina.view.Group;
import org.tamina.events.CreateJSEvent;
import createjs.easeljs.Ticker;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Stage;
import js.HTMLCanvasElement;

class MapUI extends Stage {

    private var _width:Int;
    private var _height:Int;
    private var _backgroundBitmap:Bitmap;
    private var _stationsContainer:Group<BikeStationSprite>;
    private var _data:MapData;


    public function new(display:HTMLCanvasElement, width:Int, height:Int) {
        super(display);
        _width = width;
        _height = height;
        _backgroundBitmap = new Bitmap("images/map.png");
        this.addChild(_backgroundBitmap);
        _stationsContainer = new Group<BikeStationSprite>();
        this.addChild(_stationsContainer);
        Ticker.addEventListener(CreateJSEvent.TICKER_TICK, tickerHandler);
    }

    public function init(data:MapData):Void {
        _data = data;

        for (i in 0..._data.stations.length) {
            var stationSprite = new BikeStationSprite( _data.stations[i] );
            stationSprite.x =  _data.stations[i].position.x;
            stationSprite.y =  _data.stations[i].position.y;
            _stationsContainer.addElement(stationSprite);
        }
    }

    private function tickerHandler():Void {
        this.update();
    }
}
