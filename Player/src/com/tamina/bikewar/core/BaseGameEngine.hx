package com.tamina.bikewar.core;
import org.tamina.log.QuickLogger;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.BikeStation;
import com.tamina.bikewar.data.Truck;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.Trend;
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
    public var truck_moveSignal:Signal2<Truck,Point>;
    public var turn_completeSignal:Signal0;

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

    public function getBattleResult(data:MapData, turnSpeed:Int = 1):Void {
        _currentTurn = 0;
        _isComputing = false;
        _data = data;
        _playerList = new Array<PlayerResult>();
        _playerList.push(new PlayerResult( _data.players[0]));
        _playerList.push(new PlayerResult( _data.players[1]));


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
        turn_completeSignal = new Signal0();
        battle_completeSignal = new Signal1<BattleResult>();
        truck_moveSignal = new Signal2<Truck,Point>();
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
        parseOrder();
        /*moveShips();
        increasePlanetGrowth();
        updatePlayerScore();*/
        updateBikeStations();
        _data.currentTime = Date.fromTime(_data.currentTime.getTime() + Game.TURN_TIME);
        turn_completeSignal.dispatch();
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

    private function parseOrder():Void {

        var delta:Float = Math.random() * 2 - 1;
        if (delta > 0) {
            executeIAOrders(_IAList[0]);
            executeIAOrders(_IAList[1]);
        }
        else {
            executeIAOrders(_IAList[1]);
            executeIAOrders(_IAList[0]);
        }

    }

    private function executeIAOrders(ordersOwner:IIA):Void{
        var orders:Array<Order> = ordersOwner.turnOrders;
        for (i in 0...orders.length) {
            var element:Order = orders[ i ];
            var source:Truck = getTruckByID(element.truckId);
            var target:BikeStation = getStationByID(element.targetStationId);
            source.currentStation = null;
            truck_moveSignal.dispatch(source,target.position);
            QuickLogger.info('move truck ' + source.id);
            /*if (isValidOrder(element, ordersOwner.playerId)) {

                var s:Ship = new Ship( element.numUnits, source, target, _currentTurn );
                _galaxy.fleet.push(s);
                source.population -= element.numUnits;
            }
            else {
                if (ordersOwner.playerId == _player1.id) {
                    playerOneScore = 0;
                    endBattle(new BattleResult( playerOneScore, playerTwoScore, _currentTurn, _player2, "Son adversaire a construit un ordre invalide", _player1, _player2, ErrorCode.INVALID_ORDER ));
                }
                else {
                    playerTwoScore = 0;
                    endBattle(new BattleResult( playerOneScore, playerTwoScore, _currentTurn, _player1, "Son adversaire a construit un ordre invalide", _player1, _player2, ErrorCode.INVALID_ORDER ));
                }
            }    */
        }
    }

    private function getTruckByID(truckId:Float):Truck{
        var result:Truck = null;
        for (i in 0..._data.trucks.length) {
            var p:Truck = _data.trucks[ i ];
            if (p.id == truckId) {
                result = p;
                break;
            }
        }
        return result;
    }

    private function getStationByID(stationId:Float):BikeStation{
        var result:BikeStation = null;
        for (i in 0..._data.stations.length) {
            var p:BikeStation = _data.stations[ i ];
            if (p.id == stationId) {
                result = p;
                break;
            }
        }
        return result;
    }

    private function retrieveIAOrders():Void {
        if (!_IAList[0].isRunning() && !_IAList[1].isRunning()) {
            _IAList[0].init();
            _IAList[1].init();
            _IAList[0].send(_data);
            _IAList[1].send(_data);
        }
    }

    private function updateBikeStations():Void {
        for (i in 0..._data.stations.length) {
            var station = _data.stations[i];
            var trend = GameUtils.getBikeStationTrend(station, _data.currentTime);
            var trendNum:Int=0;
            switch(trend){
                case Trend.INCREASE : Math.round( Math.random()*3 );
                case Trend.DECREASE : -Math.round( Math.random()*3 );
                case Trend.STABLE : trendNum = Math.round( Math.random()*2 ) -1;
            }
            station.bikeNum += trendNum;
            if(station.bikeNum < 0){
                station.bikeNum = 0;
            }
            if(station.bikeNum > station.slotNum){
                station.bikeNum = station.slotNum;
            }
        }
    }

    private function endBattle(result:BattleResult):Player {
        _isComputing = false;
        _endBattleDate = Date.now();
        trace("fin du match : " + _playerList[0].player.name + " = " + _playerList[0].score + "// " + _playerList[1].player.name + " = " + _playerList[1].score + " // WINNER " + result.winner.name);
        trace("battle duration " + ( _endBattleDate.getTime() - _startBattleDate.getTime() ) / 1000 + " sec");
        battle_completeSignal.dispatch(result);
        return result.winner;
    }


}
