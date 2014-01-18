package com.tamina.bikewar.data;
import msignal.Signal;


interface IIA {

    function init():Void;
    function send(data:MapData):Void;
    function isRunning():Bool;
    function dispose():Void;

    var turnOrders(get_turnOrders, null):Array<Order>;
    var playerId(get_playerId, null):String;

    var turnMaxDuration_reachSignal:Signal1<String>;
    var turnResult_completeSignal:Signal1<TurnResult>;
    var turnResult_errorSignal:Signal1<String>;
}

