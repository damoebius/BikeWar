package ;

/**
 * Model d'IA de base au SDK. Il a le même niveau que le robot de validation des combats
 * @author d.mouton
 */

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

/**
	 * @inheritDoc
	 */

    override public function getOrders(context:MapData):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        if (_turnNum == 1) {
            for (i in 0...context.trucks.length) {
                var truck = context.trucks[i];
                if (truck.owner.id == this.id) {
                    result.push(new MoveOrder( truck.id, context.stations[ Math.round(Math.random() * context.stations.length)].id ));
                }
            }

        }
        _turnNum++;
        return result;
    }


}