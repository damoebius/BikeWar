package com.tamina.bikewar.data;
import org.tamina.utils.UID;
import createjs.easeljs.Point;
class Truck {

    public var id:Float;
    public var owner:Player;
    public var bikeNum:Int;
    public var position:Point;

    public function new() {
        this.id = UID.getUID();
    }
}
