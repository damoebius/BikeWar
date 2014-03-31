package com.tamina.bikewar.ui;
import com.tamina.bikewar.core.Global;
import createjs.easeljs.Shape;
import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.Trend;
import createjs.easeljs.Text;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import com.tamina.bikewar.data.BikeStation;
import createjs.easeljs.Sprite;
class BikeStationSprite extends Container {

    public static var PADDING_LEFT:Int=17;
    public static var PADDING_TOP:Int=25;

    private var _data:BikeStation;
    private var _currentTime:Date;

    private var _defaultBackgroundBitmap:Bitmap;
    private var _outBackgroundBitmap:Bitmap;
    private var _label:Text;
    private var _backgroundContainer:Container;
    private var _ownerShape:Shape;

    public function new(data:BikeStation, currentTime:Date) {
        super();
        _data = data;
        _currentTime = currentTime;
        _defaultBackgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationBackground_defaut.png');
        _outBackgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationBackground_out.png');

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

        _ownerShape = new Shape();
        this.addChild(_ownerShape);

        updateBackground();
    }

    public function updateData(currentTime:Date):Void {
        _label.text = Std.string(_data.bikeNum);
        _currentTime = currentTime;
        updateOwnerShape();
        updateBackground();
    }

    private function updateOwnerShape():Void {
        _ownerShape.graphics.clear();
        if (_data.owner != null) {
            _ownerShape.graphics.beginFill(_data.owner.color);
            _ownerShape.graphics.moveTo(25, 10);
            _ownerShape.graphics.lineTo(32, 10);
            _ownerShape.graphics.lineTo(32, 17);
            _ownerShape.graphics.lineTo(25, 10);
            _ownerShape.graphics.endFill();
        }
    }

    private function updateBackground():Void {
        _backgroundContainer.removeAllChildren();
        var targetBackground:Bitmap = _defaultBackgroundBitmap;
        if (!GameUtils.hasStationEnoughBike(_data)) {
            targetBackground = _outBackgroundBitmap;
        }
        _backgroundContainer.addChild(targetBackground);
    }

}
