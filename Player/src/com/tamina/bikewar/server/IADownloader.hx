package com.tamina.bikewar.server;

import nodejs.http.URL;
import msignal.Signal.Signal0;
import com.tamina.bikewar.data.IAInfo;
class IADownloader  {

    public var compleSignal:Signal0;

    private var _numDownloadRemaining:Int;



    public function new() {
        _numDownloadRemaining = 0;
        compleSignal = new Signal0();
    }

    public function download(iaList:Array<IAInfo>):Void {
        _numDownloadRemaining = iaList.length;
        for (i in 0...iaList.length) {
            var httpd:HttpDownloader = new HttpDownloader();
            httpd.compleSignal.add(iaDownloadComplete);
            httpd.download(URL.Parse(iaList[i].url) );
        }
    }

    private function iaDownloadComplete():Void{
        _numDownloadRemaining--;
        if (_numDownloadRemaining == 0) {
            compleSignal.dispatch();
        }
    }
}
