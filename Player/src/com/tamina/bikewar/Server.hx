package com.tamina.bikewar;

import nodejs.ChildProcess;
import nodejs.Process;
import nodejs.http.HTTPServer;
import nodejs.http.HTTP;
import com.tamina.bikewar.server.ServerHttpRequestRouter;
import nodejs.Console;
import nodejs.NodeJS;
import haxe.Log;
import haxe.PosInfos;

class Server {

    public static var SERVER_PORT:Int = 5000;
    private static var _instance:Server;

    public function new( ) {
        trace('init launcher');
        var router:ServerHttpRequestRouter = new ServerHttpRequestRouter();
        router.add('/START', startUpdate);
        var server:HTTPServer =  HTTP.createServer(router.handler);

        if (NodeJS.process.env.PORT != null) {
            SERVER_PORT = NodeJS.process.env.PORT;
        }
        Console.info('using port ' + SERVER_PORT);
        server.listen(SERVER_PORT);

    }

    public function startUpdate(data:String):Void {
        trace('call startUpdate ');
        ChildProcessTool.exec('nodejs ServerProcess.js',execHandler);
    }

    private function execHandler(error:String, stdout:String, stderr:String):Void{
       trace(error + stdout + stderr);
    }

    static function log( v:Dynamic, ?inf:PosInfos ):Void {
        Console.info(v);
    }

    static function main( ) {
        Log.trace = log;
        _instance = new Server();
    }
}
