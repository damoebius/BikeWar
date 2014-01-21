package com.tamina.bikewar.data;
import org.tamina.geom.Point;
import com.tamina.bikewar.game.GameUtils;
class Mock {

    public static function getMap(width:Int, height:Int, players:Array<Player>):MapData {
        var result:MapData = new MapData();
        result.currentTime = GameUtils.getCurrentRoundedDate();
// Players
        result.players = players;

// Stations
        for (i in 0...50) {
            result.stations.push(getStation(width, height));
        }
// Camions
        result.trucks.push(new Truck(result.players[0], new Point(100, 100)));
        return result;
    }

    public static function getStation(width:Int, height:Int):BikeStation {
        var result:BikeStation = new BikeStation();
        result.position = new Point( Math.round(Math.random() * width), Math.round(Math.random() * height));
        result.slotNum = Math.round(Math.random() * 30);
        result.bikeNum = Math.round(Math.random() * result.slotNum);
        for (i in 0...96) {
            result.profile.push(Math.round(Math.random() * result.slotNum));
        }
        return result;
    }
}
