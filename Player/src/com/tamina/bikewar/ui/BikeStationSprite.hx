package com.tamina.bikewar.ui;
import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.Trend;
import createjs.easeljs.Text;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import com.tamina.bikewar.data.BikeStation;
import createjs.easeljs.Sprite;
class BikeStationSprite extends Container {

    private var _data:BikeStation;
    private var _currentTime:Date;

    private var _upBackgroundBitmap:Bitmap;
    private var _downBackgroundBitmap:Bitmap;
    private var _normalBackgroundBitmap:Bitmap;
    private var _label:Text;
    private var _backgroundContainer:Container;

    public function new(data:BikeStation, currentTime:Date) {
        super();
        _data = data;
        _currentTime = currentTime;
        _upBackgroundBitmap = new Bitmap('images/stationBackground_up.png');
        _downBackgroundBitmap = new Bitmap('images/stationBackground_down.png');
        _normalBackgroundBitmap = new Bitmap('images/stationBackground_normal.png');

        _backgroundContainer = new Container();
        this.addChild(_backgroundContainer);

        _label = new Text();
        _label.x = 18;
        _label.y = 11;
        _label.textAlign = 'center';
        _label.color = '#000000';
        _label.font = "08px Pixel01";
        _label.text = Std.string(_data.bikeNum);


        this.addChild(_label);

        updateBackground();
    }

    private function updateBackground():Void{
        _backgroundContainer.removeAllChildren();
        var targetBackground:Bitmap = _downBackgroundBitmap;
        var trend = GameUtils.getBikeStationTrend(_data,_currentTime);
        switch(trend){
            case Trend.INCREASE : targetBackground = _upBackgroundBitmap;
            case Trend.DECREASE : targetBackground = _downBackgroundBitmap;
            case Trend.STABLE : targetBackground = _normalBackgroundBitmap;
        }
        _backgroundContainer.addChild(targetBackground);
    }

}
