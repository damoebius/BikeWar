package com.tamina.bikewar.core;
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

    public function new(canvas:HTMLCanvasElement, width:Int, height:Int, data:MapData) {
        _data = data;
        _width = width;
        _height = height;
        _display = new MapUI(canvas, _width, _height);
        _display.init(_data);
        _engine = new LiveGameEngine();
        _engine.turn_completeSignal.add(turnCompleteHandler);
        _engine.truck_moveSignal.add(moveTruckHandler);
        _engine.battle_completeSignal.add(endBattleHandler);
        start();
    }

    public function start():Void {
        if(!_engine.isComputing){
            _engine.getBattleResult( _data, Game.GAME_SPEED);
        } else {
            trace("battle already started");
        }
    }

    private function endBattleHandler(result:BattleResult):Void{
       _display.showResultScreen(result.winner.name,result.message);
    }

    private function moveTruckHandler(truck:Truck,destination:BikeStation):Void{
         _display.moveTruck(truck,destination);
    }

    private function turnCompleteHandler():Void{
        _display.updateData();
    }
}
