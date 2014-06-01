package com.tamina.bikewar.server;

import haxe.Log;
import js.Node;
import haxe.PosInfos;
class Server {

    private static var _instance:Server;
    private static var req:Dynamic;

    public function new( ) {
        Node.console.info('init application');
        Node.require('http');
        Node.require('fs');
        var router:ServerHttpRequestRouter = new ServerHttpRequestRouter();
        router.add('/START', startUpdate);
        var server:NodeHttpServer = Node.http.createServer(router.handler);

        if (Node.process.env.PORT != null) {
            SERVER_PORT = Node.process.env.PORT;
        }
        Node.console.info('using port ' + SERVER_PORT);
        server.listen(SERVER_PORT);

        engine = new NodeGameEngine();
    }

    static function log( v:Dynamic, ?inf:PosInfos ):Void {
        Node.console.info(v);
    }


    static function main( ) {
        Log.trace = log;
        req = untyped __js__('require');
        _instance = new Server();
    }
}
