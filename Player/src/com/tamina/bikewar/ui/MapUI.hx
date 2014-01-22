package com.tamina.bikewar.ui;
import createjs.easeljs.Shape;
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
    private var _trucksContainer:Group<TruckSprite>;
    private var _data:MapData;
    private var _dateText:Text;


    public function new(display:HTMLCanvasElement, width:Int, height:Int) {
        super(display);
        _width = width;
        _height = height;
        _backgroundBitmap = new Bitmap("images/map.png");
        this.addChild(_backgroundBitmap);
        _stationsContainer = new Group<BikeStationSprite>();
        _trucksContainer = new Group<TruckSprite>();
        this.addChild(_stationsContainer);
        this.addChild(_trucksContainer);
        var textBackgroundShape:Shape = new Shape();
        textBackgroundShape.graphics.beginFill('#FFFF00');
        textBackgroundShape.graphics.drawRect(0, 0, 285, 35);
        textBackgroundShape.graphics.endFill();
        this.addChild(textBackgroundShape);
        _dateText = new Text();
        _dateText.color = '#000000';
        _dateText.font = "30px Arial";
        _dateText.textAlign = 'left';
        this.addChild(_dateText);
        Ticker.addEventListener(CreateJSEvent.TICKER_TICK, tickerHandler);
    }

    public function init(data:MapData):Void {
        _data = data;
        _dateText.text = _data.currentTime.toString();
        trace(_data.stations.length);
        for (i in 0..._data.stations.length) {
            var stationSprite = new BikeStationSprite( _data.stations[i], _data.currentTime );
            stationSprite.x = _data.stations[i].position.x;
            stationSprite.y = _data.stations[i].position.y;
            _stationsContainer.addElement(stationSprite);
        }
        for (i in 0..._data.trucks.length) {
            var truckSprite = new TruckSprite( _data.trucks[i] );
            truckSprite.x = _data.trucks[i].position.x;
            truckSprite.y = _data.trucks[i].position.y;
            _trucksContainer.addElement(truckSprite);
        }
    }

    public function updateData():Void {
        _dateText.text = _data.currentTime.toString();
        for (i in 0..._stationsContainer.getNumChildren()) {
            _stationsContainer.getElementAt(i).updateData(_data.currentTime);
        }
    }

    private function tickerHandler():Void {
        _trucksContainer.alpha -= 0.1;
        if (_trucksContainer.alpha <= 0.0) {
            _trucksContainer.alpha = 1.0;
        }
        this.update();
    }
}
