package com.tamina.bikewar.ui;
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

    public function new(data:Truck, isRedPlayer:Bool) {
        super();
        this.data = data;
        if (isRedPlayer) {
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

    public function moveTo(target:Point):Void {
        _tween = new Tween(this);
        var targetStation = new BikeStation();
        targetStation.position = target;
        _tween.addEventListener("change", moveChangeHandler);
        _tween.to({x:target.x - 8, y:target.y - 8}, GameUtils.getTravelDuration(data, targetStation) * Game.GAME_SPEED);
        _tween.call(moveEndedHandler);
//_tween = Tween.get(this).to( new Point(_data.target.x, _data.target.y), _data.travelDuration * Game.GAME_SPEED).call(tweenCompleteHandler);
    }

    private function moveChangeHandler(event:Event):Void {
        data.position.x = this.x;
        data.position.y = this.y;
    }

    private function moveEndedHandler():Void {
        QuickLogger.info('move ended');
        data.currentStation = new BikeStation();
    }
}
