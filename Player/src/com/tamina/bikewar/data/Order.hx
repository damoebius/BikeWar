package com.tamina.bikewar.data;
class Order {

    public var truckId:Float;
    public var targetStationId:Float;

    public var type:String;

    public function new(truckId:Float,targetStationId:Float,type:String) {
        this.truckId = truckId;
        this.targetStationId = targetStationId;
        this.type = type;
    }
}
