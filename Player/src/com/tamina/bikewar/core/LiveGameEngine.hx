package com.tamina.bikewar.core;
import com.tamina.bikewar.data.IA;
import com.tamina.bikewar.data.IIA;
import com.tamina.bikewar.data.Player;
import js.html.Worker;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.data.BattleResult;
import haxe.Timer;
class LiveGameEngine extends BaseGameEngine{

    private var _turnTimer:Timer;

    public function new() {
        super();
    }

    override public function getBattleResult(data:MapData, turnSpeed:Int = 1):Void {
        _IAList = new Array<IIA>();
        _IAList.push( new IA( new Worker( data.players[0].script ), data.players[0].id) );
        _IAList.push( new IA( new Worker( data.players[1].script ), data.players[1].id) );
        super.getBattleResult( data, turnSpeed);
        _turnTimer = new Timer( turnSpeed );
        _turnTimer.run = retrieveIAOrders;

    }

    override private function endBattle(result:BattleResult):Player {
        _turnTimer.stop();
        return super.endBattle(result);
    }

}
