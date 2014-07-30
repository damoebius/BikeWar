package com.tamina.bikewar;

import com.tamina.bikewar.services.request.GetScoreByIAListResponse;
import com.tamina.bikewar.data.Mock;
import nodejs.Process;
import com.tamina.bikewar.server.URLUtil;
import com.tamina.bikewar.data.Player;
import com.tamina.bikewar.server.IADownloader;
import com.tamina.bikewar.data.IAInfo;
import com.tamina.bikewar.services.request.GetScoreByIAListRequest;
import Console;
import haxe.Json;
import js.Error;
import nodejs.http.ServerResponse;
import nodejs.http.HTTPClientRequest;
import com.tamina.bikewar.core.NodeGameEngine;
import nodejs.http.HTTPServer;
import nodejs.http.HTTP;
import com.tamina.bikewar.server.ServerHttpRequestRouter;
import nodejs.Console;
import nodejs.NodeJS;
import haxe.Log;
import haxe.PosInfos;
class Server {

    public static var SERVER_PORT:Int = 5000;
    public static var GET_DATA_URL:String = "/sites/all/modules/tamina-online/eo_robot/eo_getialist.task.php";
    public static var UPDATE_DATA_URL:String = "/sites/all/modules/tamina-online/eo_robot/eo_updatescore.task.php";

    private static var _instance:Server;
    private static var req:Dynamic;

    public var engine:NodeGameEngine;
    private var _iaList:Array<IAInfo>;

    public function new( ) {
        Console.info('init application');
        NodeJS.require('http');
        NodeJS.require('fs');
        var router:ServerHttpRequestRouter = new ServerHttpRequestRouter();
        router.add('/START', startUpdate);
        var server:HTTPServer =  HTTP.createServer(router.handler);

        if (NodeJS.process.env.PORT != null) {
            SERVER_PORT = NodeJS.process.env.PORT;
        }
        Console.info('using port ' + SERVER_PORT);
        server.listen(SERVER_PORT);

        engine = new NodeGameEngine();
    }

    public function startUpdate(data:String):Void {
        Console.info('call startUpdate ');
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
        Console.info('dataCompleteHandler');
        var data:String = '';
        response.on('data', function(chunk:String):Void {
            data += chunk;
        });
        response.on('end', function():Void {
            Console.info('END OF DATA : ' + data);
            try {
                getScoreByIAList(cast Json.parse(data));
            } catch (e:Error) {
                Console.warn("NO JSON DATA");
            }

        });
    }

    public function getScoreByIAList(data:GetScoreByIAListRequest):Void {
        Console.info('call getScoreByIAList ' + data);
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
        Console.info('DOWNLOAD COMPLETE ');
        for (i in 0..._iaList.length) {
            var targetIA = _iaList[i];
            var p1 = new Player(targetIA.name,  './' + URLUtil.getFileName(targetIA.url));
            for (j in 0... _iaList.length) {
                var p2 = new Player(_iaList[j].name,  './' + URLUtil.getFileName(_iaList[j].url));
                if (targetIA.id != _iaList[j].id) {
                    engine.dispose();
                    engine.getBattleResult(Mock.getMap(PlayerUI.DEFAULT_WIDTH,PlayerUI.DEFAULT_HEIGHT, [p1,p2]));
                    removeModule(p1.script);
                    removeModule(p2.script);
                }
            }
        }

        var req = HTTP.request(getUpdateReqOpt(), testServiceResultHandler);
        var data:GetScoreByIAListResponse = new GetScoreByIAListResponse();
        data.IAList = _iaList;
        req.write(Json.stringify(data));
        req.end();


    }

    private function testServiceResultHandler(response:ServerResponse):Void {
        Console.info('testServiceResultHandler ' + response.statusCode);
        var data:String = '';
        response.on('data', function(chunk:String):Void {
            data += chunk;
        });
        response.on('end', function():Void {
            Console.info('END OF DATA : ' + data);
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


    static function log( v:Dynamic, ?inf:PosInfos ):Void {
        Console.info(v);
    }


    static function main( ) {
        Log.trace = log;
        req = untyped __js__('require');
        _instance = new Server();
    }
}
