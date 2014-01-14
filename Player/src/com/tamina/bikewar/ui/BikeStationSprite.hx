package com.tamina.bikewar.ui;
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

    public function new(data:BikeStation, currentTime:Date) {
        super();
        _data = data;
        _currentTime = currentTime;
        _upBackgroundBitmap = new Bitmap('stationBackground_up.png');
        _downBackgroundBitmap = new Bitmap('stationBackground_up.png');
        _normalBackgroundBitmap = new Bitmap('stationBackground_up.png');

        this.addChild(_upBackgroundBitmap);

        _label = new Text();
        _label.text = Std.string(_data.bikeNum);
        _label.color = '#000000';
        _label.font = "10px 04b";
        _label.textAlign = 'center';
        this.addChild(_label);
    }


    public function getTrend():Trend{
        var currentIndex:Int = 0;
        return Trends.fromInt( _data.profile[currentIndex + 1] - _data.profile[currentIndex] );
    }
}
