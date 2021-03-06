package com.tamina.bikewar.game;
import org.tamina.geom.Point;
class Game {
    public static var GAME_MAX_NUM_TURN:Int = 250;
    public static var GAME_SPEED:Int = 1000;
    public static var TRUCK_SPEED:Int = 60;
    public static var TRUCK_NUM_SLOT:Int = 10;
    public static var MAX_TURN_DURATION:Int = 1000;
    public static var TURN_TIME:Int = 1000*30*15;
    public static var MAX_SCORE:Int = 2500;

    private static function get_START_POINTS():Array<Point> {
        var result:Array<Point> = new Array<Point>();
        result.push( new Point(100,100) );
        result.push( new Point(100,500) );
        return result;
    }

    static public var START_POINTS(get_START_POINTS, null):Array<Point>;
}
