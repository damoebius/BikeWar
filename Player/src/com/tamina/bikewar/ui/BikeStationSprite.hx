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

    private var _defaultBackgroundBitmap:Bitmap;
    private var _outBackgroundBitmap:Bitmap;
    private var _label:Text;
    private var _backgroundContainer:Container;

    public function new(data:BikeStation, currentTime:Date) {
        super();
        _data = data;
        _currentTime = currentTime;
        _defaultBackgroundBitmap = new Bitmap('images/stationBackground_defaut.png');
        _outBackgroundBitmap = new Bitmap('images/stationBackground_out.png');

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

    public function updateData(currentTime:Date):Void{
        _label.text = Std.string(_data.bikeNum);
        _currentTime = currentTime;
        updateBackground();
    }

    private function updateBackground():Void{
        _backgroundContainer.removeAllChildren();
        var targetBackground:Bitmap = _defaultBackgroundBitmap;
        if(_data.bikeNum < _data.slotNum/4 || _data.bikeNum > _data.slotNum/4*3){
            targetBackground = _outBackgroundBitmap;
        }
        _backgroundContainer.addChild(targetBackground);
    }

}
