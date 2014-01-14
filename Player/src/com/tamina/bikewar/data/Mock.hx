package com.tamina.bikewar.data;
import createjs.easeljs.Point;
class Mock {

    public static function getMap(width:Int, height:Int):MapData {
        var result:MapData = new MapData();
        result.currentTime = Date.now();
// Players
        result.players.push(new Player('IA 1', 'js/ia1.js'));
        result.players.push(new Player('IA 2', 'js/ia2.js'));

        // Stations
        for(i in 0...50){
            result.stations.push( getStation(width,height) );
        }
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
