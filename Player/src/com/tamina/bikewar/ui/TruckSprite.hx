package com.tamina.bikewar.ui;
import createjs.easeljs.Shape;
import com.tamina.bikewar.core.Global;
import com.tamina.bikewar.tween.AnimatePath;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.data.Path;
import com.tamina.bikewar.data.PlayerColor;
import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.BikeStation;
import org.tamina.log.QuickLogger;
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
    private var _motion:AnimatePath;
    private var _gaugeShape:Shape;

    public function new(data:Truck) {
        super();
        this.data = data;
        _gaugeShape = new Shape();

        _gaugeShape.y = 5;
        if (data.owner.color == PlayerColor.RED) {
            _backgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/truck_bg_0.png');
            _gaugeShape.x = -21;
        } else {
            _backgroundBitmap = new Bitmap(Global.IMG_BASE_PATH + 'images/truck_bg_1.png');
            _gaugeShape.x = 13;
        }
        _backgroundContainer = new Container();
        _backgroundContainer.x = -28;
        _backgroundContainer.y = -23;
        _backgroundContainer.addChild(_backgroundBitmap);
        this.addChild(_backgroundContainer);

        this.addChild(_gaugeShape);

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
        _gaugeShape.graphics.clear();
        _gaugeShape.graphics.beginFill('#fef54d');
        var numGaugeBar = Math.round(this.data.bikeNum * 4 / 10);
        for(i in 0...numGaugeBar){
            _gaugeShape.graphics.drawRect(0,0 - i* 3,7,2);
        }
        _gaugeShape.graphics.endFill();
    }

    public function moveTo(target:BikeStation, map:MapData):Path {
        var path:Path = GameUtils.getPath(data.currentStation,data.destination,map);
        _motion.animate(path);
        return path;
    }

    private function moveChangeHandler():Void {
        data.position.x = this.x;
        data.position.y = this.y;
    }

    private function moveEndedHandler():Void {
        QuickLogger.info('move ended');
    }
}
