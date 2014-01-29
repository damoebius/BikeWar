package ;

/**
 * Model d'IA de base au SDK. Il a le même niveau que le robot de validation des combats
 * @author d.mouton
 */

import com.tamina.bikewar.game.GameUtils;
import com.tamina.bikewar.data.UnLoadingOrder;
import com.tamina.bikewar.game.Game;
import com.tamina.bikewar.data.LoadingOrder;
import com.tamina.bikewar.data.MoveOrder;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.MapData;
class MyIA extends WorkerIA {
/**
	 * @internal
	 */
    public static function main():Void {
        WorkerIA.instance = new MyIA();

    }

    private var _turnNum:Int = 1;
    private var _movingTruckId:Array<Float>;

/**
	 * @inheritDoc
	 */

    override public function getOrders(context:MapData):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        for (i in 0...context.trucks.length) {
            var truck = context.trucks[i];
            if (truck.owner.id == this.id && truck.currentStation != null) {
                debugMessage = "Tour " + _turnNum + ", truck " + truck.id + " : in station with " + truck.bikeNum +" bikes";
                if (Lambda.has(_movingTruckId, truck.id)) {
                    debugMessage += " loading";
                    _movingTruckId.remove(truck.id);
                    if ( truck.currentStation.bikeNum < truck.currentStation.slotNum/4) {
                      if(truck.bikeNum > 0){
                          result.push(new UnLoadingOrder(truck.id, truck.currentStation.id, 1));
                      }
                    } else if(truck.currentStation.bikeNum > truck.currentStation.slotNum/4*3){
                        if(truck.bikeNum < Game.TRUCK_NUM_SLOT){
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    } else if(GameUtils.hasStationEnoughBike(truck.currentStation)){
                        if(truck.bikeNum < Game.TRUCK_NUM_SLOT){
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    }
                } else {
                    debugMessage += " moving";
                    _movingTruckId.push(truck.id);
                    result.push(new MoveOrder( truck.id, context.stations[ Math.round(Math.random() * context.stations.length)].id ));
                }

            }  else {
                debugMessage = "travelling...";
            }

        }
        _turnNum++;
        return result;
    }

    public function new() {
        super();
        _movingTruckId = new Array<Float>();
    }


}