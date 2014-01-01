package com.tamina.bikewar;

import com.tamina.bikewar.ui.UIElementId;
import js.Browser;
import js.HTMLCanvasElement;
import com.tamina.bikewar.log.QuickLogger;

@:expose class Player {

    private static var _instance:Player;


    public function new() {
    }

    static function main() {
        Console.start();
        QuickLogger.info("instantiation de l'application ");
        _instance = new Player();

    }

    static function init(firstPlayerName:String, firstPlayerScript:String, secondPlayerName:String, secondPlayerScript:String):Void {
        QuickLogger.info("init " + firstPlayerName + " vs " + secondPlayerName);
        var applicationCanvas:HTMLCanvasElement = cast Browser.document.getElementById(UIElementId.APPLICATION_CANVAS);
    }
}
