package com.tamina.bikewar.data;
class MoveOrder extends Order {

    public function new(truckId:Float, targetStationId:Float) {
        super(truckId, targetStationId, OrderType.MOVE);
    }
}
