package com.tamina.bikewar.server;
class URLUtil {


    public static function getFileName(url:String):String{
        return url.substr(url.lastIndexOf("/") + 1);
    }
}
