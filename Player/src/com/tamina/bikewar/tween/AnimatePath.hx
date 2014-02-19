package com.tamina.bikewar.tween;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.game.GameUtils;
import msignal.Signal;
import createjs.easeljs.Event;
import createjs.tweenjs.Tween;
import createjs.easeljs.DisplayObject;
import com.tamina.bikewar.data.Path;
class AnimatePath {

    public var moveSignal:Signal0;
    public var completeSignal:Signal0;

    private var _target:DisplayObject;
    private var _tween:Tween;

    public function new(target:DisplayObject) {
        _target = target;
        moveSignal = new Signal0();
        completeSignal = new Signal0();
    }

    public function animate(path:Path):Void{
        if(_tween != null){
            Tween.removeTweens(_target);
        }
        _tween = new Tween(_target);
        _tween.addEventListener("change", moveChangeHandler);
        for (i in 1...path.length){
            _tween.to({x:path.getItemAt(i).x,y:path.getItemAt(i).y},Math.ceil( GameUtils.getDistanceBetween( path.getItemAt(i-1), path.getItemAt(i)) / Game.TRUCK_SPEED) * Game.GAME_SPEED);
        }
        _tween.call(moveEndedHandler);
    }


    private function moveChangeHandler(event:Event):Void {
        moveSignal.dispatch();
    }

    private function moveEndedHandler():Void {
        completeSignal.dispatch();
    }
}
