package com.tamina.bikewar.ui;
import com.tamina.bikewar.core.Global;
import com.tamina.bikewar.tween.AnimatePath;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.data.Path;
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
    private var _targetStation:BikeStation;
    private var _motion:AnimatePath;

    public function new(data:Truck) {
        super();
        this.data = data;
        if (data.owner.color == PlayerColor.RED) {
            _backgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/truck_bg_0.png');
        } else {
            _backgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/truck_bg_1.png');
        }
        _backgroundContainer = new Container();
        _backgroundContainer.x = -28;
        _backgroundContainer.y = -23;
        _backgroundContainer.addChild(_backgroundBitmap);
        this.addChild(_backgroundContainer);
        _label = new Text();
        _label.x = 0;
        _label.y = 0;
        _label.textAlign = 'center';
        _label.color = '#ffffff';
        _label.font = "08px Pixel01";
        _label.text = Std.string(this.data.bikeNum);
        this.addChild(_label);
        _motion = new AnimatePath(this);
        _motion.moveSignal.add(moveChangeHandler);
        _motion.completeSignal.add(moveEndedHandler);
    }

    public function updateData():Void{
        _label.text = Std.string(this.data.bikeNum);
    }

    public function moveTo(target:BikeStation, map:MapData):Void {
        _targetStation = target;
        var path:Path = GameUtils.getPath(data.currentStation,_targetStation,map);
        data.currentStation = null;

        _motion.animate(path);




       /* if(_tween != null){
            Tween.removeTweens(this);
        }
        _tween = new Tween(this);
        _tween.addEventListener("change", moveChangeHandler);
        _tween.to({guide:{ path:path.getGuide() }}, GameUtils.getTravelDuration(data, _targetStation) * Game.GAME_SPEED);
        _tween.call(moveEndedHandler); */
    }

    private function moveChangeHandler():Void {
        data.position.x = this.x;
        data.position.y = this.y;
    }

    private function moveEndedHandler():Void {
        QuickLogger.info('move ended');
        data.currentStation = _targetStation;
    }
}
