package com.tamina.bikewar;
import nodejs.fs.WriteStream;
import nodejs.NodeJS;
import nodejs.Process;
import nodejs.fs.File;
import com.tamina.bikewar.data.Mock;
import com.tamina.bikewar.data.Player;
import com.tamina.bikewar.server.URLUtil;
import com.tamina.bikewar.services.request.GetScoreByIAListResponse;
import com.tamina.bikewar.server.IADownloader;
import com.tamina.bikewar.services.request.GetScoreByIAListRequest;
import haxe.Json;
import nodejs.http.ServerResponse;
import nodejs.http.HTTPClientRequest;
import nodejs.http.HTTP;
import js.Error;
import com.tamina.bikewar.data.BattleResult;
import com.tamina.bikewar.data.IAInfo;
import com.tamina.bikewar.core.NodeGameEngine;
import haxe.PosInfos;
import haxe.Log;
import nodejs.Console;

class ServerProcess {

    public static var GET_DATA_URL:String = "/sites/all/modules/tamina-online/eo_robot/eo_getialist.task.php";
    public static var UPDATE_DATA_URL:String = "/sites/all/modules/tamina-online/eo_robot/eo_updatescore.task.php";

    private static var _instance:ServerProcess;
    private static var req:Dynamic;

    public var engine:NodeGameEngine;
    private var _iaList:Array<IAInfo>;
    private static var _logf:WriteStream;

    public function new( ) {
        trace('launch process : ' + Date.now().toString());
        engine = new NodeGameEngine();
        engine.battle_completeSignal.add(battleCompleteHandler);
        getRemoteData();
    }

    public function getRemoteData():Void {
        var headers = {
        contentType: "application/json; charset=utf-8",
        dataType: "json"
        };
        var reqOpt:HTTPRequestOptions = cast {};
        reqOpt.host = 'www.codeofwar.net';
        reqOpt.port = 80;
        reqOpt.path = GET_DATA_URL;
        reqOpt.method = 'GET';
        reqOpt.headers = headers;
        var req:HTTPClientRequest = HTTP.request(reqOpt, dataCompleteHandler);
        req.end();
    }

    private function dataCompleteHandler(response:ServerResponse):Void {
        trace('dataCompleteHandler');
        var data:String = '';
        response.on('data', function(chunk:String):Void {
            data += chunk;
        });
        response.on('error', function():Void {
            trace('ERROR : ' + response.statusCode);
            _logf.end();
            NodeJS.process.exit(0);
        });
        response.on('end', function():Void {
            trace('END OF DATA : ' + data);
            try {
                getScoreByIAList(cast Json.parse(data));
            } catch (e:Error) {
                Console.warn("NO JSON DATA");
            }

        });
    }

    private function getUpdateReqOpt():HTTPRequestOptions {
        var headers = {
        contentType: "application/json; charset=utf-8",
        dataType: "json"
        };
        var reqOpt:HTTPRequestOptions = cast {};
        reqOpt.host = 'www.codeofwar.net';
        reqOpt.port = 80;
        reqOpt.path = UPDATE_DATA_URL;
        reqOpt.method = 'POST';
        reqOpt.headers = headers;
        return reqOpt;
    }

    private function removeModule(name:String):Void {
        try {
            var fileName:String = req.resolve(name);
            req.cache[cast fileName] = null;
        } catch (e:Error) {
            Console.warn('impossible de vider le cache pour : ' + name) ;
        }
    }


    public function getScoreByIAList(data:GetScoreByIAListRequest):Void {
        trace('call getScoreByIAList ' + data);
        if (data != null) {
            _iaList = data.IAList;
            for (i in 0..._iaList.length) {
                _iaList[i].score = 0;
            }
            var downloader:IADownloader = new IADownloader();
            downloader.compleSignal.add(iadownloader_completeHandler);
            downloader.download(_iaList);
        }
    }

    private function iadownloader_completeHandler():Void {
        trace('DOWNLOAD COMPLETE ');
        for (i in 0..._iaList.length) {
            var targetIA = _iaList[i];
            var p1 = new Player(targetIA.name,  './' + URLUtil.getFileName(targetIA.url));
            for (j in 0... _iaList.length) {
                var p2 = new Player(_iaList[j].name,  './' + URLUtil.getFileName(_iaList[j].url));
                if (targetIA.id != _iaList[j].id ) {
                    engine.dispose();
                    engine.getBattleResult(Mock.getMap(PlayerUI.DEFAULT_WIDTH,PlayerUI.DEFAULT_HEIGHT, [p1,p2]));
                    removeModule(p1.script);
                    removeModule(p2.script);
                }
            }
        }

        var req = HTTP.request(getUpdateReqOpt(), sendResultHandler);
        var data:GetScoreByIAListResponse = new GetScoreByIAListResponse();
        data.IAList = _iaList;
        req.write(Json.stringify(data));
        req.end();


    }

    private function sendResultHandler(response:ServerResponse):Void {
        Console.info('sendResultHandler ' + response.statusCode);
        var data:String = '';
        response.on('data', function(chunk:String):Void {
            trace('data recieved');
            data += chunk;
        });
        response.on('error', function(error):Void {
            trace('ERROR : ' + response.statusCode);
            _logf.end();
            NodeJS.process.exit(0);
        });
        response.on('end', function():Void {
            trace('END OF DATA : ' + data);
            _logf.end();
            NodeJS.process.exit(0);
        });
    }

    private function battleCompleteHandler(result:BattleResult) {
        if (result.winner != null) {
            try {
                getIAInfoByName(result.winner.name).score++;
            } catch (e:Error) {
                Console.warn('Impossible de retrouver ' + result.winner);
            }
        }
    }

    private function getIAInfoByName(name:String):IAInfo {
        for (i in 0..._iaList.length) {
            if (_iaList[i].name == name) {
                return _iaList[i];
            }
        }
        return null;
    }

    static function main( ) {
        req = untyped __js__('require');
        untyped __js__('console.log = function(){};');
        _logf = File.createWriteStream('bikewar.log');
        Log.trace = log;
        _instance = new ServerProcess();
    }

    static function log( v:Dynamic, ?inf:PosInfos ):Void {
        Console.info(v);
        _logf.write(v + '\n');
    }
}
