package com.tamina.bikewar.ui;
import com.tamina.bikewar.data.PlayerColor;
import com.tamina.bikewar.core.Global;
import com.tamina.bikewar.game.GameUtils;
import createjs.easeljs.Text;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import com.tamina.bikewar.data.BikeStation;
class BikeStationSprite extends Container {

    public static var PADDING_LEFT:Int=17;
    public static var PADDING_TOP:Int=25;

    private var _data:BikeStation;
    private var _currentTime:Date;

    private var _defaultBackgroundBitmap:Bitmap;
    private var _outBackgroundBitmap:Bitmap;
    private var _label:Text;
    private var _backgroundContainer:Container;
    private var _ownerFlagContainer:Container;
    private var _player0Bitmap:Bitmap;
    private var _player1Bitmap:Bitmap;

    public function new(data:BikeStation, currentTime:Date) {
        super();
        _data = data;
        _currentTime = currentTime;
        _defaultBackgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationBackground_defaut.png');
        _outBackgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationBackground_out.png');

        _player0Bitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationFlag_0.png');
        _player1Bitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/stationFlag_1.png');

        _backgroundContainer = new Container();
        this.addChild(_backgroundContainer);
        _ownerFlagContainer = new Container();
        this.addChild(_ownerFlagContainer);

        _label = new Text();
        _label.x = 18;
        _label.y = 12;
        _label.textAlign = 'center';
        _label.color = '#FFFFFF';
        _label.font = "08px Pixel01";
        _label.text = Std.string(_data.bikeNum);

        this.addChild(_label);

        updateBackground();
    }

    public function updateData(currentTime:Date):Void {
        _label.text = Std.string(_data.bikeNum);
        _currentTime = currentTime;
        updateOwnerFlag();
        updateBackground();
    }

    private function updateOwnerFlag():Void {

        if (_data.owner != null) {
            _ownerFlagContainer.removeAllChildren();
            var targetFlag:Bitmap = _player0Bitmap;
            if (_data.owner.color == PlayerColor.BLUE) {
                targetFlag = _player1Bitmap;
            }
            _ownerFlagContainer.addChild(targetFlag);
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
