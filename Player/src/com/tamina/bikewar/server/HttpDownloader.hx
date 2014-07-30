package com.tamina.bikewar.server;
import nodejs.fs.File;
import msignal.Signal.Signal0;
import nodejs.NodeJS;
import nodejs.Console;
import nodejs.http.ServerResponse;
import nodejs.http.HTTP;
import nodejs.http.URLData;
class HttpDownloader  {

    public var compleSignal:Signal0;

    private var _url:URLData;

    public function new() {
        compleSignal = new Signal0();
    }

    public function download(url:URLData):Void {
        _url = url;
        HTTP.get(_url.href, downloadHandler);
    }

    private function downloadHandler(response:ServerResponse):Void {
        Console.info('Download : ' + _url.href);
        var data:String = '';
        response.on('data', function(chunk:String):Void {
            data += chunk;
        });
        response.on('end', function():Void {
            Console.info('END OF FILE ' + data.length);
            data = parseData(data);
            File.writeFileSync(URLUtil.getFileName(_url.href), data);
            compleSignal.dispatch();
        });
    }

    private function parseData(data:String):String {
        var result:String = data;
        if (data.indexOf('this.onmessage') > -1) {
            result = StringTools.replace(result, 'this.onmessage', 'exports.onmessage');
        } else {
            result = StringTools.replace(result, 'onmessage', 'exports.onmessage');
        }

        if (data.indexOf('this.postMessage(') > -1) {
            result = StringTools.replace(result, 'this.postMessage(', 'exports.postMessage(');
        } else {
            result = StringTools.replace(result, 'postMessage(', 'exports.postMessage(');
        }
        return result;
    }


}
