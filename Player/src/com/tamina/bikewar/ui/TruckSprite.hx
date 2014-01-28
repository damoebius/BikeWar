package com.tamina.bikewar.ui;
import com.tamina.bikewar.data.PlayerColor;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.BikeStation;
import createjs.easeljs.Event;
import org.tamina.log.QuickLogger;
import createjs.tweenjs.Tween;
import org.tamina.geom.Point;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Text;
import com.tamina.bikewar.data.Truck;
import createjs.easeljs.Container;

class TruckSprite extends Container {

    public var data:Truck;

    private var _label:Text;
    private var _backgroundContainer:Container;
    private var _backgroundBitmap:Bitmap;
    private var _tween:Tween;
    private var _targetStation:BikeStation;

    public function new(data:Truck) {
        super();
        this.data = data;
        if (data.owner.color == PlayerColor.RED) {
            _backgroundBitmap = new Bitmap('images/truck_bg_0.png');
        } else {
            _backgroundBitmap = new Bitmap('images/truck_bg_1.png');
        }
        _backgroundContainer = new Container();
        _backgroundContainer.addChild(_backgroundBitmap);
        this.addChild(_backgroundContainer);
        _label = new Text();
        _label.x = 27;
        _label.y = 24;
        _label.textAlign = 'center';
        _label.color = '#000000';
        _label.font = "08px Pixel01";
        _label.text = Std.string(this.data.bikeNum);
        this.addChild(_label);
    }

    public function updateData():Void{
        _label.text = Std.string(this.data.bikeNum);
    }

    public function moveTo(target:BikeStation):Void {
        _targetStation = target;
        if(_tween != null){
            Tween.removeTweens(this);
        }
        _tween = new Tween(this);
        _tween.addEventListener("change", moveChangeHandler);
        _tween.to({x:_targetStation.position.x - 8, y:_targetStation.position.y - 8}, GameUtils.getTravelDuration(data, _targetStation) * Game.GAME_SPEED);
        _tween.call(moveEndedHandler);
    }

    private function moveChangeHandler(event:Event):Void {
        data.position.x = this.x;
        data.position.y = this.y;
    }

    private function moveEndedHandler():Void {
        QuickLogger.info('move ended');
        data.currentStation = _targetStation;
    }
}
