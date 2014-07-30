package ;

/**
 * Model d'IA de base au SDK. Il a le même niveau que le robot de validation des combats
 * @author d.mouton
 */

import com.tamina.bikewar.data.Truck;
import com.tamina.bikewar.data.BikeStation;
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
    public static function main( ):Void {
        WorkerIA.instance = new MyIA();

    }

    private var _turnNum:Int = 1;
    private var _movingTruckId:Array<Float>;
    private var _currentContext:MapData;
    private var _defenceTruckId:Float = -1;

/**
	 * @inheritDoc
	 */

    override public function getOrders( context:MapData ):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        _currentContext = context;
        for ( i in 0...context.trucks.length ) {
            var truck = context.trucks[i];
            if ( truck.owner.id == this.id && truck.currentStation != null ) {
                if ( _defenceTruckId == -1 ) {
                    _defenceTruckId = truck.id;
                }
                if ( Lambda.has(_movingTruckId, truck.id) ) {
                    _movingTruckId.remove(truck.id);
                    if ( GameUtils.hasStationEnoughBike(truck.currentStation) ) {
                        result.push(new LoadingOrder(truck.id, truck.currentStation.id, 0));
                    } else if ( truck.currentStation.bikeNum < truck.currentStation.slotNum / 4 && truck.bikeNum > 0 ) {
                        result.push(new UnLoadingOrder(truck.id, truck.currentStation.id, truck.bikeNum));
                    } else if ( truck.currentStation.bikeNum > truck.currentStation.slotNum / 4 * 3 ) {
                        debugMessage = "trop de velo";
                        if ( truck.bikeNum <= 5 ) {
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 5));
                        } else if ( truck.bikeNum < Game.TRUCK_NUM_SLOT ) {
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    }
                } else {
                        _movingTruckId.push(truck.id);
                        result.push(new MoveOrder( truck.id, getNearestStations(truck, getOthersBikeStations()).id ));

                }

            } else {
//debugMessage = "travelling...";
            }

        }
        _turnNum++;
        return result;
    }

    private function getNearestStations( origin:Truck, stations:Array<BikeStation> ):BikeStation {
        var result = stations[0];
        for ( i in 1...stations.length ) {
            if ( (origin.currentStation == null || stations[i].id != origin.currentStation.id) && GameUtils.getTravelDuration(origin, stations[i]) < GameUtils.getTravelDuration(origin, result) ) {
                result = stations[i];
            }

        }
        return result;
    }

    private function getSickBikeStations( ):Array<BikeStation> {
        var result = new Array<BikeStation>();
        for ( i in 0..._currentContext.stations.length ) {
            if ( !GameUtils.hasStationEnoughBike(_currentContext.stations[i]) ) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getGoodBikeStations( ):Array<BikeStation> {
        var result = new Array<BikeStation>();
        for ( i in 0..._currentContext.stations.length ) {
            if ( (_currentContext.stations[i].owner == null || _currentContext.stations[i].owner.id != this.id) && GameUtils.hasStationEnoughBike(_currentContext.stations[i]) ) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getFewBikeStations( ):Array<BikeStation> {
        var result = new Array<BikeStation>();
        for ( i in 0..._currentContext.stations.length ) {
            if ( !GameUtils.hasStationEnoughBike(_currentContext.stations[i]) && _currentContext.stations[i].bikeNum < 9 ) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getOthersBikeStations( ):Array<BikeStation> {
        var result = new Array<BikeStation>();
        for ( i in 0..._currentContext.stations.length ) {
            if ( _currentContext.stations[i].owner == null || _currentContext.stations[i].owner.id != this.id ) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getMuchBikeStations( ):Array<BikeStation> {
        var result = new Array<BikeStation>();
        for ( i in 0..._currentContext.stations.length ) {
            if ( !GameUtils.hasStationEnoughBike(_currentContext.stations[i]) && _currentContext.stations[i].bikeNum > 12 ) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    public function new( ) {
        super();
        _movingTruckId = new Array<Float>();
    }


}