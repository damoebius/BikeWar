package com.tamina.bikewar.server;
import haxe.Json;
import js.Error;
import nodejs.Console;
import nodejs.http.ServerResponse;
import nodejs.http.IncomingMessage;
import haxe.ds.StringMap;
class ServerHttpRequestRouter {

    private var routes:StringMap<Dynamic -> Void>;

    public function new() {
        routes = new StringMap<Dynamic -> Void>();
    }

    public function add(url:String, callback:Dynamic -> Void):Void {
        routes.set(url, callback);
    }

    public function handler(request:IncomingMessage, response:ServerResponse):Void {
        Console.info( "url invoked" + request.url);
        var callback = routes.get(request.url);
        if (callback != null) {
            Console.info("callback found");
            var data = '';
            request.on('data', function(chunk) {
                data += chunk;
            });
            request.on('end', function(chunk) {
                Console.info("DATA END :" + data);
                var result:Dynamic;
                try {
                    result = Json.parse(data);
                } catch (e:Error) {
                    Console.warn("NO JSON DATA");
                    result = null;
                }
                callback(result);
            });
        }
        response.end();
    }
}
