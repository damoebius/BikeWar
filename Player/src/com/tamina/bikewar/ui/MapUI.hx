package com.tamina.bikewar.ui;
import com.tamina.bikewar.core.Global;
import createjs.tweenjs.MotionGuidePlugin;
import com.tamina.bikewar.game.GameUtils;
import org.tamina.geom.Junction;
import org.tamina.geom.Junction;
import com.tamina.bikewar.data.BikeStation;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.Truck;
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
    private var _stationsContainer:Group<BikeStationSprite>;
    private var _trucksContainer:Group<TruckSprite>;
    private var _data:MapData;
    private var _dateText:Text;
    private var _resultScreen:ResultScreen;
    private var _roadsSprite:RoadSprite;
    private var _debugMode:Bool;


    public function new(display:HTMLCanvasElement, width:Int, height:Int) {
        super(display);
        MotionGuidePlugin.install();
        _width = width;
        _height = height;
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

        _roadsSprite = new RoadSprite(width, height);
       // this.addChild(_roadsSprite);

        Ticker.addEventListener(CreateJSEvent.TICKER_TICK, tickerHandler);
    }

    public function showResultScreen(winner:String, resultMessage:String):Void {
        _resultScreen = new ResultScreen(winner, resultMessage);
        this.addChild(_resultScreen);
        _resultScreen.x = Math.floor(_width / 2 - _resultScreen.getWidth() / 2);
        _resultScreen.y = Math.floor(_height / 2 - _resultScreen.getHeight() / 2);
    }

    public function init(data:MapData, debugMode:Bool = false):Void {
        _data = data;
        _debugMode = debugMode;
        _dateText.text = _data.currentTime.toString();
        for (i in 0..._data.stations.length) {
            var stationSprite = new BikeStationSprite( _data.stations[i], _data.currentTime );
            stationSprite.x = _data.stations[i].position.x - BikeStationSprite.PADDING_LEFT;
            stationSprite.y = _data.stations[i].position.y - BikeStationSprite.PADDING_TOP;
            _stationsContainer.addElement(stationSprite);
        }
        if (!_debugMode) {
            for (i in 0..._data.trucks.length) {
                var truckData = _data.trucks[i];
                var truckSprite = new TruckSprite( truckData );
                truckSprite.x = _data.trucks[i].position.x;
                truckSprite.y = _data.trucks[i].position.y;
                _trucksContainer.addElement(truckSprite);
            }
        } else {
            _roadsSprite.displayRoads(_data.roads);
        }

// test path finding
        /*var p = GameUtils.getPath(_data.stations[27], _data.stations[61], _data);
        for (i in 0...p.length) {
            for (j in 0..._roadsSprite.junctionGroup.getNumChildren()) {
                var currentJunctionShape:JunctionShape = _roadsSprite.junctionGroup.getElementAt(j);
                if (currentJunctionShape.data.id == p.getItemAt(i).id) {
                    currentJunctionShape.select();
                }
            }
        }  */
    }

    public function updateData():Void {
        _dateText.text = _data.currentTime.toString();
        for (i in 0..._stationsContainer.getNumChildren()) {
            _stationsContainer.getElementAt(i).updateData(_data.currentTime);
        }
        for (i in 0..._trucksContainer.getNumChildren()) {
            _trucksContainer.getElementAt(i).updateData();
        }
    }

    public function moveTruck(truck:Truck, destination:BikeStation):Void {
        var target:TruckSprite = getSpriteByTruck(truck);
        target.moveTo(destination,_data);
    }

    private function getSpriteByTruck(data:Truck):TruckSprite {
        var result:TruckSprite = null;
        for (i in 0..._trucksContainer.getNumChildren()) {
            var p:TruckSprite = _trucksContainer.getElementAt(i);
            if (p.data.id == data.id) {
                result = p;
                break;
            }
        }
        return result;
    }

    private function tickerHandler():Void {
        /*_trucksContainer.alpha -= 0.1;
        if (_trucksContainer.alpha <= 0.0) {
            _trucksContainer.alpha = 1.0;
        }  */
        this.update();
    }
}
