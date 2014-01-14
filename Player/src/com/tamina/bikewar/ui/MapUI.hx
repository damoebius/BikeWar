package com.tamina.bikewar.ui;
import createjs.easeljs.Text;
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
    private var _dateText:Text;


    public function new(display:HTMLCanvasElement, width:Int, height:Int) {
        super(display);
        _width = width;
        _height = height;
        _backgroundBitmap = new Bitmap("images/map.png");
        this.addChild(_backgroundBitmap);
        _stationsContainer = new Group<BikeStationSprite>();
        this.addChild(_stationsContainer);
        _dateText = new Text();
        _dateText.color = '#000000';
        _dateText.font = "40px 04b";
        _dateText.textAlign = 'left';
        this.addChild(_dateText);
        Ticker.addEventListener(CreateJSEvent.TICKER_TICK, tickerHandler);
    }

    public function init(data:MapData):Void {
        _data = data;
        _dateText.text = _data.currentTime.toString();
        for (i in 0..._data.stations.length) {
            var stationSprite = new BikeStationSprite( _data.stations[i], _data.currentTime );
            stationSprite.x =  _data.stations[i].position.x;
            stationSprite.y =  _data.stations[i].position.y;
            _stationsContainer.addElement(stationSprite);
        }
    }

    private function tickerHandler():Void {
        this.update();
    }
}
