package com.tamina.bikewar;

//import com.tamina.bikewar.core.BattleRenderer;

import com.tamina.bikewar.ui.UIElementId;
import js.Browser;
import js.HTMLCanvasElement;
import org.tamina.log.QuickLogger;
import com.tamina.bikewar.core.BattleRenderer;

@:expose class Player {

    public function new() {
    }

    static function main() {
        Console.start();
        QuickLogger.info("instantiation de l'application ");
    }

    static function init(firstPlayerName:String, firstPlayerScript:String, secondPlayerName:String, secondPlayerScript:String):Void {
        QuickLogger.info("init " + firstPlayerName + " vs " + secondPlayerName);
        var applicationCanvas:HTMLCanvasElement = cast Browser.document.getElementById(UIElementId.APPLICATION_CANVAS);
        applicationCanvas.width = 1353;
        applicationCanvas.height = 549;
        var renderer:BattleRenderer = new BattleRenderer(applicationCanvas, 1353, 549);
    }
}
