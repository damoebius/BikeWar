package com.tamina.bikewar.core;
import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.PlayerResult;
import com.tamina.bikewar.data.BattleResult;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.data.IIA;
import com.tamina.bikewar.data.Player;

import msignal.Signal;
class BaseGameEngine {

    public var battle_completeSignal:Signal1<BattleResult>;

    private var _currentTurn:Int;
    private var _endBattleDate:Date;
    private var _data:MapData;
    private var _isComputing:Bool;
    private var _maxNumTurn:Int;
    private var _startBattleDate:Date;

    private var _IAList:Array<IIA>;
    private var _playerList:Array<PlayerResult>;


    private function get_isComputing():Bool {
        return _isComputing;
    }

    public var isComputing(get_isComputing, null):Bool;

    public function getBattleResult( data:MapData, turnSpeed:Int = 1):Void {
        _currentTurn = 0;
        _isComputing = false;
        _data = data;
        _playerList = new Array<PlayerResult>();
        _playerList.push( new PlayerResult( _data.players[0]));
        _playerList.push( new PlayerResult( _data.players[1]));


        _IAList[0].turnResult_completeSignal.add(IA_ordersResultHandler);
        _IAList[0].turnMaxDuration_reachSignal.add(maxDuration_reachHandler);
        _IAList[0].turnResult_errorSignal.add(turnResultErrorHandler);

        _IAList[1].turnResult_completeSignal.add(IA_ordersResultHandler);
        _IAList[1].turnMaxDuration_reachSignal.add(maxDuration_reachHandler);
        _IAList[1].turnResult_errorSignal.add(turnResultErrorHandler);

        _maxNumTurn = Game.GAME_MAX_NUM_TURN;
        _startBattleDate = Date.now();
        _currentTurn = 0;
        _isComputing = true;

    }


    public function new() {
    }

    private function maxDuration_reachHandler(playerId:String):Void {
        trace("max duration reached");
        if (playerId == _playerList[0].player.id) {
            endBattle(new BattleResult( _playerList, _currentTurn, _playerList[1].player, "DUREE DU TOUR TROP LONGUE" ));
        }
        else {
            endBattle(new BattleResult( _playerList, _currentTurn, _playerList[0].player, "DUREE DU TOUR TROP LONGUE" ));
        }
    }

    private function IA_ordersResultHandler(event):Void {
        if (_IAList[0].turnOrders != null && _IAList[1].turnOrders != null) {
            computeCurrentTurn();
        }
    }

    private function turnResultErrorHandler(playerId:String):Void {
        trace("turn result error");
        if (playerId == _playerList[0].player.id) {
            endBattle(new BattleResult( _playerList, _currentTurn, _playerList[1].player, "RESULTAT DU TOUR INATTENDU" ));
        }
        else {
            endBattle(new BattleResult( _playerList, _currentTurn, _playerList[0].player, "RESULTAT DU TOUR INATTENDU" ));
        }
    }

    private function computeCurrentTurn():Void {
        /*parseOrder();
        moveShips();
        increasePlanetGrowth();
        updatePlayerScore();*/
        updateBikeStations();
        _currentTurn++;
        if (_isComputing && _currentTurn >= _maxNumTurn) {
            if (_playerList[0].score > _playerList[1].score) {
                endBattle(new BattleResult( _playerList, _currentTurn, _playerList[0].player, "DUREE MAX ATTEINTE" ));
            }
            else {
                endBattle(new BattleResult( _playerList, _currentTurn, _playerList[1].player, "DUREE MAX ATTEINTE" ));
            }
        }

    }

    private function retrieveIAOrders():Void {

    }

    private function updateBikeStations():Void{
        for(i in 0..._data.stations.length){
            var station =  _data.stations[i];
            var trend = GameUtils.getBikeStationTrend(station,_data.currentTime);
            _data.stations[i].bikeNum++;
        }
    }

    private function endBattle(result:BattleResult):Player
    {
        _isComputing = false;
        _endBattleDate = Date.now();
        trace("fin du match : "+_playerList[0].player.name+" = " + _playerList[0].score + "// "+_playerList[1].player.name+" = " + _playerList[1].score + " // WINNER " + result.winner.name);
        trace("battle duration " + ( _endBattleDate.getTime() - _startBattleDate.getTime() ) / 1000 + " sec");
        battle_completeSignal.dispatch(result);
        return result.winner;
    }


}
