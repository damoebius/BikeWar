package com.tamina.bikewar.data;
class MapData {

    public var players:Array<Player>;
    public var stations:Array<BikeStation>;
    public var trucks:Array<Truck>;
    public var currentTime:Date;

    public function new() {
        players = new Array<Player>();
        stations = new Array<BikeStation>();
        trucks = new Array<Truck>();
    }
}
