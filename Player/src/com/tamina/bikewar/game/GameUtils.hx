package com.tamina.bikewar.game;
import com.tamina.bikewar.data.Path;
import com.tamina.bikewar.core.PathFinder;
import com.tamina.bikewar.data.MapData;
import org.tamina.geom.Junction;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.BikeStation;
import com.tamina.bikewar.data.Trend;
class GameUtils {

    public static function getTravelDuration(source:BikeStation, target:BikeStation,map:MapData):Int{
        var result:Int = 0;
        var p = GameUtils.getPath(source,target,map);
        for(i in 0...p.length -1){
            result += Math.ceil( GameUtils.getDistanceBetween( p.getItemAt(i), p.getItemAt(i+1)) / Game.TRUCK_SPEED);
        }
        return result;
    }

    public static function getDistanceBetween( p1:Point, p2:Point ):Float
    {
        return Math.sqrt( Math.pow( ( p2.x - p1.x ), 2 ) + Math.pow( ( p2.y - p1.y ), 2 ) );
    }

    public static function hasStationEnoughBike(station:BikeStation):Bool{
        return (station.bikeNum >= station.slotNum/4 && station.bikeNum <= station.slotNum/4*3);
    }

    public static function getPath(fromStation:BikeStation,toStation:BikeStation, map:MapData):Path{
        var p = new PathFinder();
        return p.getPath(fromStation,toStation,map);
    }

    public static function getCurrentRoundedDate():Date{
        var now = Date.now();
        var minutes = now.getMinutes();
        minutes = Math.floor(  minutes * 4 / 60 ) * 15;
        return Date.fromTime(  now.getTime() - (now.getMinutes() - minutes)*1000*60 - now.getSeconds()*1000);
    }

    public static function getBikeStationTrend(target:BikeStation, time:Date ):Trend{
        var currentIndex:Int = time.getHours() * 4 +  Math.floor(  time.getMinutes() * 4 / 60 ) ;
        var nextIndex:Int = currentIndex + 1;
        if(nextIndex + 1 > target.profile.length){
            nextIndex = 0;
        }
        return Trends.fromInt( target.profile[nextIndex] - target.profile[currentIndex] );
    }

}
