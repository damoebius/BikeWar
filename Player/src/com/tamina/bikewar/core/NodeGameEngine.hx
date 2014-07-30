package com.tamina.bikewar.core;
import com.tamina.bikewar.data.Player;
import com.tamina.bikewar.data.BattleResult;
import com.tamina.bikewar.server.NodeIA;
import com.tamina.bikewar.data.IIA;
import com.tamina.bikewar.data.MapData;
class NodeGameEngine extends BaseGameEngine {
    public function new( ) {
        super();
    }

    override public function getBattleResult(data:MapData, turnSpeed:Int = 1):Void {
        _IAList = new Array<IIA>();
        _IAList.push( new NodeIA(  data.players[0].script , data.players[0].id) );
        _IAList.push( new NodeIA(  data.players[1].script , data.players[1].id) );
        super.getBattleResult(data, turnSpeed);

        retrieveIAOrders();

    }

    public function dispose():Void {
        if (_data != null) {
            _IAList[0].turnResult_completeSignal.remove (IA_ordersResultHandler);
            _IAList[0].turnMaxDuration_reachSignal.remove(maxDuration_reachHandler);
            _IAList[0].turnResult_errorSignal.remove(turnResultErrorHandler);

            _IAList[1].turnResult_completeSignal.remove(IA_ordersResultHandler);
            _IAList[1].turnMaxDuration_reachSignal.remove(maxDuration_reachHandler);
            _IAList[1].turnResult_errorSignal.remove(turnResultErrorHandler);
            _IAList[0].dispose();
            _IAList[1].dispose();
            _IAList = null;
            _data = null;
        }
    }

    override private function computeCurrentTurn():Void {
        super.computeCurrentTurn();
        if (_isComputing == true) {
            retrieveIAOrders();
        }
    }

    override private function endBattle(result:BattleResult):Player {
        return super.endBattle(result);
        trace("P1 " + _IAList[0].playerId + " //P2 " + _IAList[1].playerId + " //Turn " + _currentTurn);
    }
}
