package com.tamina.bikewar.data;
import org.tamina.geom.Point;
import org.tamina.utils.UID;
class Truck {

    public var id:Float;
    public var owner:Player;
    public var bikeNum:Int;
    public var position:Point;
    public var currentStation:BikeStation;

    public function new(owner:Player,position:Point) {
        this.id = UID.getUID();
        this.owner = owner;
        this.position = position;
        this.bikeNum = 0;
        this.currentStation = new BikeStation();
    }
}
