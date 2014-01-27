package com.tamina.bikewar.data;
class LoadingOrder extends Order {
    public var bikeNum:Int = 0;

    public function new(truckId:Float, targetStationId:Float, bikeNum:Int) {
        super(truckId, targetStationId, OrderType.LOAD);
        this.bikeNum = bikeNum;
    }
}
