package com.tamina.bikewar.server;
import com.tamina.bikewar.data.TurnMessage;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.data.MapData;
import nodejs.Console;
import js.Error;
import nodejs.NodeJS;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.TurnResult;
import com.tamina.bikewar.data.IIA;
import msignal.Signal;

class NodeIA implements IIA {

    public var turnMaxDuration_reachSignal:Signal1<String>;
    public var turnResult_completeSignal:Signal1<TurnResult>;
    public var turnResult_errorSignal:Signal1<String>;

    private var _worker:Dynamic;
    private var _turnOrders:Array<Order>;
    private var _playerId:String;
    private var _startTime:Float;

    public function new(script:String, playerId:String) {
        turnMaxDuration_reachSignal = new Signal1<String>();
        turnResult_completeSignal = new Signal1<TurnResult>();
        turnResult_errorSignal = new Signal1<String>();
        init();
        _playerId = playerId;
        try {
            _worker = NodeJS.require(script);
            _worker.postMessage = worker_messageHandler;
        } catch (exp:Error) {
            trace('BAD ROBOT : ' + exp.message);
            trace(exp.stack);
        }
        _startTime = 0;
    }

    public function init():Void {
        _turnOrders = null;
    }

    public function dispose():Void {
        if (_worker != null) {
            _worker.postMessage = null;
            _worker.onmessage = null;
            _worker = null;
        }
    }

    public function send(data:MapData):Void {
        _startTime = Date.now().getTime();
        //var context:MapData = ObjectUtils.copy(data);
        try {
            _worker.onmessage({ data:new TurnMessage(playerId, data)});
        } catch (e:Error) {
            trace('turn error');
            turnResult_errorSignal.dispatch(playerId);
        }
    }

    public function isRunning():Bool {
        return _startTime > 0;
    }

    private function testTurnDuration():Bool {
        var result:Bool = true;
        if (_startTime > 0) {

            var t0:Float = Date.now().getTime();
            if (t0 - _startTime > Game.MAX_TURN_DURATION) {
                trace("maxDuration_reachHandler");
                turnMaxDuration_reachSignal.dispatch(playerId);
                result = false;
            }
        }
        return result;
    }


    private function worker_messageHandler(message:Dynamic):Void {
        _startTime = 0;
        if (message != null && testTurnDuration() == true) {
            var turnResult:TurnResult = message;
            _turnOrders = turnResult.orders;
            turnResult_completeSignal.dispatch(turnResult) ;
        } else {
            turnResult_errorSignal.dispatch(playerId) ;
        }
    }

    private function get_turnOrders():Array<Order> {
        return _turnOrders;
    }

    public var turnOrders(get_turnOrders, null):Array<Order>;

    private function get_playerId():String {
        return _playerId;
    }

    public var playerId(get_playerId, null):String;
}
