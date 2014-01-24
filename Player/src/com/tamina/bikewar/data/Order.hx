package com.tamina.bikewar.data;
class Order {

    public var truckId:Float;
    public var targetStationId:Float;

    public function new(truckId:Float,targetStationId:Float) {
        this.truckId = truckId;
        this.targetStationId = targetStationId;
    }
}
