package com.tamina.bikewar;

//import com.tamina.bikewar.core.BattleRenderer;

import com.tamina.bikewar.data.PlayerColor;
import com.tamina.bikewar.data.Player;
import com.tamina.bikewar.data.Mock;
import com.tamina.bikewar.ui.UIElementId;
import js.Browser;
import js.HTMLCanvasElement;
import org.tamina.log.QuickLogger;
import com.tamina.bikewar.core.BattleRenderer;

@:expose class PlayerUI {

    public static var DEFAULT_WIDTH:Int=1353;
    public static var DEFAULT_HEIGHT:Int=549;

    public function new() {
    }

    static function main() {
        Console.start();
        QuickLogger.info("instantiation de l'application ");
    }

    static function init(firstPlayerName:String, firstPlayerScript:String, secondPlayerName:String, secondPlayerScript:String,debugMode:Bool=false):Void {
        QuickLogger.info("init " + firstPlayerName + " vs " + secondPlayerName);
        var applicationCanvas:HTMLCanvasElement = cast Browser.document.getElementById(UIElementId.APPLICATION_CANVAS);
        applicationCanvas.width = DEFAULT_WIDTH;
        applicationCanvas.height = DEFAULT_HEIGHT;
        var players:Array<Player> = new Array<Player>();
        players.push(new Player(firstPlayerName, firstPlayerScript, PlayerColor.RED));
        players.push(new Player(secondPlayerName, secondPlayerScript,PlayerColor.BLUE));
        var renderer:BattleRenderer = new BattleRenderer(applicationCanvas, DEFAULT_WIDTH, DEFAULT_HEIGHT, Mock.getMap(DEFAULT_WIDTH, DEFAULT_HEIGHT,players),debugMode);
    }
}
