package com.tamina.bikewar.game;
import com.tamina.bikewar.data.BikeStation;
import com.tamina.bikewar.data.Trend;
class GameUtils {

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
