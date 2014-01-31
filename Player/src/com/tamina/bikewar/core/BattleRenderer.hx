package com.tamina.bikewar.core;
import org.tamina.log.QuickLogger;
import js.html.Element;
import com.tamina.bikewar.ui.UIElementId;
import js.Browser;
import com.tamina.bikewar.data.BattleResult;
import com.tamina.bikewar.data.BikeStation;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.Truck;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.ui.MapUI;
import js.HTMLCanvasElement;


class BattleRenderer {

    private var _display:MapUI;
    private var _engine:LiveGameEngine;
    private var _data:MapData;
    private var _width:Int;
    private var _height:Int;
    private var _debugMode:Bool;

    public function new(canvas:HTMLCanvasElement, width:Int, height:Int, data:MapData, debugMode=false) {
        _debugMode = debugMode;
        _data = data;
        _width = width;
        _height = height;
        _display = new MapUI(canvas, _width, _height);
        _display.init(_data,debugMode);
        _engine = new LiveGameEngine();
        _engine.turn_completeSignal.add(turnCompleteHandler);
        _engine.truck_moveSignal.add(moveTruckHandler);
        _engine.battle_completeSignal.add(endBattleHandler);
        Browser.document.getElementById(UIElementId.PLAYER_ONE_NAME).innerHTML = _data.players[0].name;
        Browser.document.getElementById(UIElementId.PLAYER_TWO_NAME).innerHTML = _data.players[1].name;
        var fightButton:Element = Browser.document.getElementById(UIElementId.FIGHT_BUTTON);
        fightButton.addEventListener('click',fightHandler);
    }

    public function start():Void {
        if(!_engine.isComputing){
            _engine.getBattleResult( _data, Game.GAME_SPEED);
        } else {
            trace("battle already started");
        }
    }

    private function fightHandler(event):Void {
        QuickLogger.info('FIGHT');
        start();
    }

    private function endBattleHandler(result:BattleResult):Void{
       _display.showResultScreen(result.winner.name,result.message);
    }

    private function moveTruckHandler(truck:Truck,destination:BikeStation):Void{
         _display.moveTruck(truck,destination);
    }

    private function turnCompleteHandler():Void{
        Browser.document.getElementById(UIElementId.PLAYER_ONE_SCORE).innerHTML = Std.string(_engine.playerList[0].score);
        Browser.document.getElementById(UIElementId.PLAYER_TWO_SCORE).innerHTML = Std.string(_engine.playerList[1].score);
        _display.updateData();
    }
}
