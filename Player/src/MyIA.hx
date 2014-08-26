package ;

/**
 * Model d'IA de base au SDK. Il a le même niveau que le robot de validation des combats
 * @author d.mouton
 */

import com.tamina.bikewar.data.Trend;
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
    public static function main():Void {
        WorkerIA.instance = new MyIA();

    }

    private var _turnNum:Int = 1;
    private var _movingTruckId:Array<Float>;
    private var _currentContext:MapData;
    private var _defenceTruckId:Float = -1;

/**
	 * @inheritDoc
	 */

    override public function getOrders(context:MapData):Array<Order> {
        var result:Array<Order> = new Array<Order>();
        _currentContext = context;
        var fs = getFewBikeStations();
        fs = fs.concat(getGoodBikeStations());
        var ms = getMuchBikeStations();
        ms = ms.concat(getGoodBikeStations());
        for (i in 0...context.trucks.length) {
            var truck = context.trucks[i];
            if (truck.owner.id == this.id && truck.currentStation != null) {
                if (_defenceTruckId == -1) {
                    _defenceTruckId = truck.id;
                }
                if (Lambda.has(_movingTruckId, truck.id)) {
                    _movingTruckId.remove(truck.id);
                    if (GameUtils.hasStationEnoughBike(truck.currentStation)) {
                        result.push(new LoadingOrder(truck.id, truck.currentStation.id, 0));
                    } else if (truck.currentStation.bikeNum < truck.currentStation.slotNum / 4 && truck.bikeNum > 0) {
                        var num = truck.bikeNum;
                        if (num + truck.currentStation.bikeNum > truck.currentStation.slotNum / 4 * 3) {
                            num = Math.floor(truck.currentStation.slotNum / 4 * 3 - truck.currentStation.bikeNum);
                        }
                        result.push(new UnLoadingOrder(truck.id, truck.currentStation.id, num));
                    } else if (truck.currentStation.bikeNum > truck.currentStation.slotNum / 4 * 3) {
                        debugMessage = "trop de velo";
                        if (truck.bikeNum <= 5) {
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 5));
                        } else if (truck.bikeNum < Game.TRUCK_NUM_SLOT) {
                            result.push(new LoadingOrder(truck.id, truck.currentStation.id, 1));
                        }
                    }
                } else {
                    _movingTruckId.push(truck.id);
                    if (truck.bikeNum == 0 && ms.length > 0) {
                        result.push(new MoveOrder( truck.id, getNearestStations(truck, ms).id ));
                    } else if (truck.bikeNum == Game.TRUCK_NUM_SLOT && fs.length > 0) {
                        result.push(new MoveOrder( truck.id, getNearestStations(truck, fs).id ));
                    }
                    else {
                        result.push(new MoveOrder( truck.id, getNearestStations(truck, getOthersBikeStations()).id ));
                    }

                }

            } else {
//debugMessage = "travelling...";
            }

        }
        _turnNum++;
        return result;
    }

    private function getNearestStations(origin:Truck, stations:Array<BikeStation>):BikeStation {
        var result = stations[0];
        var t = getMyTrucks();
        var currentTravelDuration = GameUtils.getTravelDuration(origin.currentStation, result, _currentContext);
        for (i in 1...stations.length) {
            if ((t[0].destination == null || t[0].destination.id != stations[i].id)
            && (t[1].destination == null || t[1].destination.id != stations[i].id)
            && (origin.currentStation == null || stations[i].id != origin.currentStation.id)
            ) {
                var newDuration = GameUtils.getTravelDuration(origin.currentStation, stations[i], _currentContext);
                if (newDuration < currentTravelDuration) {
                    result = stations[i];
                    currentTravelDuration = newDuration;
                }
            }

        }
        return result;
    }

    private function getSickBikeStations():Array<BikeStation> {
        var result = new Array<BikeStation>();
        for (i in 0..._currentContext.stations.length) {
            if (!GameUtils.hasStationEnoughBike(_currentContext.stations[i])) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getGoodBikeStations():Array<BikeStation> {
        var result = new Array<BikeStation>();
        for (i in 0..._currentContext.stations.length) {
            var s = _currentContext.stations[i];
            if ((s.owner == null || s.owner.id != this.id) && GameUtils.hasStationEnoughBike(s)) {
                if ( hasEnoughBike(s)) {
                    result.push(s);
                }
            }
        }
        return result;
    }

    private function hasEnoughBike(station:BikeStation):Bool{
        return (station.bikeNum >= (station.slotNum/2 - 1) && station.bikeNum <= (station.slotNum/2 + 1) );
    }



    private function isStableFor(s:BikeStation, numTurn:Int):Bool {
        var result:Bool = true;
        var currentIndex:Int = _currentContext.currentTime.getHours() * 4 + Math.floor(_currentContext.currentTime.getMinutes() * 4 / 60) ;
        for (i in 0...numTurn) {
            var nextIndex:Int = currentIndex + i;
            if (nextIndex + 1 > s.profile.length) {
                nextIndex = 0 + i;
            }
            if (Trends.fromInt(s.profile[nextIndex] - s.profile[currentIndex]) != Trend.STABLE) {
                result = false;
            }
        }
        return result;
    }

    private function getFewBikeStations():Array<BikeStation> {
        var result = new Array<BikeStation>();
        for (i in 0..._currentContext.stations.length) {
            if (!GameUtils.hasStationEnoughBike(_currentContext.stations[i]) && _currentContext.stations[i].bikeNum < 9) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getMyTrucks():Array<Truck> {
        var result = new Array<Truck>();
        for (i in 0..._currentContext.trucks.length) {
            if (_currentContext.trucks[i].owner.id == this.id) {
                result.push(_currentContext.trucks[i]);
            }
        }
        return result;
    }

    private function getOthersBikeStations():Array<BikeStation> {
        var result = new Array<BikeStation>();
        for (i in 0..._currentContext.stations.length) {
            if (_currentContext.stations[i].owner == null || _currentContext.stations[i].owner.id != this.id) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    private function getMuchBikeStations():Array<BikeStation> {
        var result = new Array<BikeStation>();
        for (i in 0..._currentContext.stations.length) {
            if (!GameUtils.hasStationEnoughBike(_currentContext.stations[i]) && _currentContext.stations[i].bikeNum > 12) {
                result.push(_currentContext.stations[i]);
            }
        }
        return result;
    }

    public function new() {
        super();
        _movingTruckId = new Array<Float>();
    }


}