package com.tamina.bikewar.data.vo;
import org.tamina.geom.Point;
class BikeStationVO {
    public var id:String;
    public var name:String;
    public var numSlot:Int;
    public var latitude:Float;
    public var longitude:Float;
    public var type:String;
    public var CB:String;
    public var zone:Int;
    public var riveDroite:String;
    public var rocade:String;

    public static var northEastGPS:Point;
    public static var southWestGPS:Point;


    public function new(id:String,name:String,numSlot:String,latitude:String,longitude:String,type:String,CB:String,zone:String,riveDroite:String,rocade:String="In") {
        this.id = id;
        this.name = name;
        this.numSlot = Std.parseInt( numSlot );
        this.latitude = Std.parseFloat(latitude);
        this.longitude = Std.parseFloat(longitude);
        this.type = type;
        this.CB = CB;
        this.zone = Std.parseInt(zone);
        this.riveDroite = riveDroite;
        this.rocade = rocade;
        northEastGPS = new Point(-0.618948,44.862166);
        southWestGPS = new Point(-0.508407,44.829026);

    }

    public function toBikeStation(width:Int, height:Int):BikeStation{
        var result:BikeStation = new BikeStation();
        result.position = new Point( Math.round(width * ( this.longitude - northEastGPS.x ) / ( southWestGPS.x - northEastGPS.x ))-17, Math.round( height * ( northEastGPS.y - this.latitude ) / ( northEastGPS.y - southWestGPS.y ))-25 );
        result.slotNum = this.numSlot;
        result.bikeNum = Math.round(Math.random() * result.slotNum);
        for (i in 0...96) {
            result.profile.push(Math.round(Math.random() * result.slotNum));
        }
        return result;
    }
}
