package com.tamina.bikewar.core;
import com.tamina.bikewar.data.UnLoadingOrder;
import com.tamina.bikewar.data.OrderType;
import com.tamina.bikewar.data.LoadingOrder;
import com.tamina.bikewar.data.MoveOrder;
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
    public var truck_moveSignal:Signal2<Truck, BikeStation>;
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
        truck_moveSignal = new Signal2<Truck, BikeStation>();
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

    private function executeIAOrders(ordersOwner:IIA):Void {
        var orders:Array<Order> = ordersOwner.turnOrders;
        if (orders.length > 2) {
            if (ordersOwner.playerId == _playerList[0].player.id) {
                _playerList[0].score = 0;
                endBattle(new BattleResult( _playerList, _currentTurn, _playerList[1].player, "Son adversaire a dépassé le nombre d'ordre authorisé" ));
            }
            else {
                _playerList[1].score = 0;
                endBattle(new BattleResult( _playerList, _currentTurn, _playerList[0].player, "Son adversaire a dépassé le nombre d'ordre authorisé" ));
            }
        } else {
            for (i in 0...orders.length) {
                var element:Order = orders[ i ];
                if (isValidOrder(element, ordersOwner.playerId)) {
                    var source:Truck = getTruckByID(element.truckId);
                    var target:BikeStation = getStationByID(element.targetStationId);
                    if (element.type == OrderType.MOVE) {
                        source.currentStation = null;
                        truck_moveSignal.dispatch(source, target);
                        QuickLogger.info('move truck ' + source.id);
                    } else if (element.type == OrderType.LOAD) {
                        var lo:LoadingOrder = cast element;
                        source.bikeNum += lo.bikeNum;
                        target.bikeNum -= lo.bikeNum;
                        target.owner = source.owner;
                        QuickLogger.info('load bike ' + source.id);
                    } else if (element.type == OrderType.UNLOAD) {
                        var lo:UnLoadingOrder = cast element;
                        source.bikeNum -= lo.bikeNum;
                        target.bikeNum += lo.bikeNum;
                        target.owner = source.owner;
                        QuickLogger.info('unload bike ' + source.id);
                    } else {
                        QuickLogger.error("order type inconnu");
                    }
                } else {
                    if (ordersOwner.playerId == _playerList[0].player.id) {
                        _playerList[0].score = 0;
                        endBattle(new BattleResult( _playerList, _currentTurn, _playerList[1].player, "Son adversaire a construit un ordre invalide" ));
                    }
                    else {
                        _playerList[1].score = 0;
                        endBattle(new BattleResult( _playerList, _currentTurn, _playerList[0].player, "Son adversaire a construit un ordre invalide" ));
                    }
                }
            }
        }
    }

    private function isValidOrder(order:Order, orderOwnerId:String):Bool {
        var result:Bool = true;
        var source:Truck = getTruckByID(order.truckId);
        var target:BikeStation = getStationByID(order.targetStationId);
        if (source == null) {
            trace("Invalid Order : source inconnue");
            result = false;
        }
        else if (target == null) {
            trace("Invalid Order : target inconnue");
            result = false;
        }
        else if (order.type == OrderType.LOAD) {
            var loadOrder:LoadingOrder = cast order;
            if (loadOrder.bikeNum + source.bikeNum > Game.TRUCK_NUM_SLOT) {
                trace("Invalid Order : pas assez de place dans le camion");
                result = false;
            }
            if (loadOrder.bikeNum > target.bikeNum) {
                trace("Invalid Order : pas assez de vélo en station");
                result = false;
            }

        }
        else if (order.type == OrderType.UNLOAD) {
            var unloadOrder:UnLoadingOrder = cast order;
            if (unloadOrder.bikeNum + source.bikeNum > target.slotNum) {
                trace("Invalid Order : pas assez de place en station");
                result = false;
            }
            if (unloadOrder.bikeNum > target.bikeNum) {
                trace("Invalid Order : pas assez de vélo");
                result = false;
            }

        }
        else if (source.owner.id != orderOwnerId) {
            trace("Invalid Order : le proprietaire du camion n'est pas le meme que celui de l'ordre");
            trace("Order source owner id : " + source.owner.id);
            result = false;
        }
        if (result == false) {
            trace("Order Owner : " + orderOwnerId);
            trace("Order sourceID : " + order.truckId);
            trace("Order targetID : " + order.targetStationId);
        }
        return result;
    }

    private function getTruckByID(truckId:Float):Truck {
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

    private function getStationByID(stationId:Float):BikeStation {
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
            var trendNum:Int = 0;
            switch(trend){
                case Trend.INCREASE : Math.round(Math.random() * 3);
                case Trend.DECREASE : -Math.round(Math.random() * 3);
                case Trend.STABLE : trendNum = Math.round(Math.random() * 2) - 1;
            }
            station.bikeNum += trendNum;
            if (station.bikeNum < 0) {
                station.bikeNum = 0;
            }
            if (station.bikeNum > station.slotNum) {
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
