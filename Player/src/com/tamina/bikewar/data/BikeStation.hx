package com.tamina.bikewar.data;
import org.tamina.geom.Junction;
import org.tamina.geom.Point;
import org.tamina.utils.UID;
class BikeStation {

    public var id:Float;
    public var bikeNum:Int;
    public var slotNum:Int;
    public var position:Junction;
    public var owner:Player;
    public var profile:Array<Int>;

    public function new() {
        profile = new Array<Int>();
        this.id = UID.getUID();
    }

}
