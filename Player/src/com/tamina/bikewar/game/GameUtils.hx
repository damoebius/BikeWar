package com.tamina.bikewar.game;
import com.tamina.bikewar.data.Truck;
import org.tamina.geom.Point;
import com.tamina.bikewar.data.BikeStation;
import com.tamina.bikewar.data.Trend;
class GameUtils {

    public static function getTravelDuration(source:Truck, target:BikeStation):Int{
        var result:Int = 1000;
        result = Math.ceil( getDistanceBetween( source.position, target.position) / Game.TRUCK_SPEED);
        trace(result);
        return result;
    }

    public static function getDistanceBetween( p1:Point, p2:Point ):Float
    {
        return Math.sqrt( Math.pow( ( p2.x - p1.x ), 2 ) + Math.pow( ( p2.y - p1.y ), 2 ) );
    }

    public static function getCurrentRoundedDate():Date{
        var now = Date.now();
        var minutes = now.getMinutes();
        minutes = Math.floor(  minutes * 4 / 60 ) * 15;
        trace(now.getMinutes());
        trace(minutes);
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
