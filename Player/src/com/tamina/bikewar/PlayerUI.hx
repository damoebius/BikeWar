package com.tamina.bikewar;

//import com.tamina.bikewar.core.BattleRenderer;

import haxe.Http;
import com.tamina.bikewar.data.BattleResult;
import com.tamina.bikewar.core.Global;
import com.tamina.bikewar.data.PlayerColor;
import com.tamina.bikewar.data.Player;
import com.tamina.bikewar.data.Mock;
import com.tamina.bikewar.ui.UIElementId;
import js.Browser;
import js.HTMLCanvasElement;
import org.tamina.log.QuickLogger;
import com.tamina.bikewar.core.BattleRenderer;

@:expose class PlayerUI {

    public static var DEFAULT_WIDTH:Int = 1353;
    public static var DEFAULT_HEIGHT:Int = 549;

    private static var _renderer:BattleRenderer;

    public function new() {
    }

    static function main() {
        Console.start();
        QuickLogger.info("instantiation de l'application ");
    }

    static function setPaths(savePath:String = "", redirectPath:String = "", imgBasePath:String = ""):Void {
        Global.REDIRECT_URL = redirectPath;
        Global.IMG_BASE_PATH = imgBasePath;
        Global.SAVE_URL = savePath;
    }

    static function init(firstPlayerName:String, firstPlayerScript:String, secondPlayerName:String, secondPlayerScript:String, debugMode:Bool = false):Void {
        QuickLogger.info("init " + firstPlayerName + " vs " + secondPlayerName);
        var applicationCanvas:HTMLCanvasElement = cast Browser.document.getElementById(UIElementId.APPLICATION_CANVAS);
        applicationCanvas.width = DEFAULT_WIDTH;
        applicationCanvas.height = DEFAULT_HEIGHT;
        var players:Array<Player> = new Array<Player>();
        players.push(new Player(firstPlayerName, firstPlayerScript, PlayerColor.RED));
        players.push(new Player(secondPlayerName, secondPlayerScript, PlayerColor.BLUE));
        _renderer = new BattleRenderer(applicationCanvas, DEFAULT_WIDTH, DEFAULT_HEIGHT, Mock.getMap(DEFAULT_WIDTH, DEFAULT_HEIGHT, players), debugMode);
        _renderer.battle_completeSignal.add(gameCompleteHandler);
        if (Global.SAVE_URL != "" ) {
            _renderer.start();
        }
    }

    private static function redirect(playerStatus:Int):Void {
        if (Global.REDIRECT_URL != "") {
            Browser.window.location.assign(Global.REDIRECT_URL + "?playerStatus=" + Std.string( playerStatus ) );
        }
    }

    private static function addScore_completeHandler(event:Int):Void {
        trace("status : " + Std.string(event));
        redirect(BattleResult.WIN);
    }

    private static function gameCompleteHandler(r:BattleResult):Void {
        if (Global.SAVE_URL != "" && r.winner.id == _renderer.getData().players[0].id) {
            trace("sauvegarde du score");
            var request:Http = new Http(Global.SAVE_URL);
            request.onStatus = addScore_completeHandler;
            request.setParameter("player", r.winner.name );
            request.setParameter("score", Std.string( (r.playerList[0].score / r.numTurn) * 1000 ) );
            request.request(true);
        } else if(Global.SAVE_URL != "" ) {
            redirect(BattleResult.LOOSE);
        } else {
            redirect(BattleResult.NONE);
        }
    }
}
