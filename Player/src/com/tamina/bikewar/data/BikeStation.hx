package com.tamina.bikewar.data;
import org.tamina.utils.UID;
import createjs.easeljs.Point;
class BikeStation {

    public var id:Float;
    public var bikeNum:Int;
    public var slotNum:Int;
    public var position:Point;
    public var owner:Player;
    public var profile:Array<Int>;

    public function new() {
        profile = new Array<Int>();
        this.id = UID.getUID();
    }
}
