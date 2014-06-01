package com.tamina.bikewar.services;
import org.tamina.log.QuickLogger;
import haxe.Json;
import org.tamina.events.XMLHttpRequestEvent;
import msignal.Signal;
import org.tamina.html.Global;
import org.tamina.net.URL;
import js.html.XMLHttpRequestProgressEvent;
import js.html.XMLHttpRequest;
class HTTPRequest {
    private var _httpRequest:XMLHttpRequest;

    private var _successCallBack:XMLHttpRequestProgressEvent -> Void;
    private var _errorCallBack:ServiceError -> Void;

    public var _progressSignal:Signal1<Progress>;

    public function new(remoteUrl:URL, successCallBack:XMLHttpRequestProgressEvent -> Void, errorCallBack:ServiceError -> Void) {
        _progressSignal = new Signal1<Progress>();
        _successCallBack = successCallBack;
        _errorCallBack = errorCallBack;
        _httpRequest = new XMLHttpRequest();
        _httpRequest.upload.addEventListener(XMLHttpRequestEvent.PROGRESS, uploadHandler) ;
        _httpRequest.addEventListener(XMLHttpRequestEvent.LOAD, successHandler);
        _httpRequest.addEventListener(XMLHttpRequestEvent.ERROR, errorHandler);
        _httpRequest.addEventListener(XMLHttpRequestEvent.PROGRESS, progressHandler);
        _httpRequest.open("POST", remoteUrl.path, true);
        _httpRequest.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    }

    public function send():Void {
        _httpRequest.send(Json.stringify(getRequestContent()));
    }

    private function uploadHandler(progress:XMLHttpRequestProgressEvent):Void {
        QuickLogger.info('uploading ' + progress.loaded + "/" + progress.total);
        _progressSignal.dispatch(new Progress(progress.loaded,progress.total));
    }

    private function getRequestContent():Dynamic {
        var data:Dynamic = { };
        return data;
    }

    private function successHandler(result:XMLHttpRequestProgressEvent):Void {
        _progressSignal.dispatch(new Progress(0,0));
        var req:XMLHttpRequest = cast result.target;
        QuickLogger.info(req.responseText);
        _successCallBack(result);

    }

    private function progressHandler(progress:XMLHttpRequestProgressEvent):Void {
        QuickLogger.info('downloading ' + progress.loaded + "/" + progress.total);
        _progressSignal.dispatch(new Progress(progress.loaded,progress.total));
    }

    private function errorHandler(error:Dynamic):Void {
        QuickLogger.error(error);
        _errorCallBack(new ServiceError(ErrorCode.TECHNICAL_ERROR, Std.string(error) ));
        _progressSignal.dispatch(new Progress(0,0));
    }
}
