package com.tamina.bikewar.core;
import com.tamina.bikewar.data.MapData;
import com.tamina.bikewar.ui.MapUI;
import js.HTMLCanvasElement;


class BattleRenderer {

    private var _display:MapUI;
    private var _engine:LiveGameEngine;
    private var _data:MapData;
    private var _width:Int;
    private var _height:Int;

    public function new(canvas:HTMLCanvasElement, width:Int, height:Int) {
        _width = width;
        _height = height;
        _display = new MapUI(canvas, _width, _height);
        _engine = new LiveGameEngine();
        _data = new MapData();
    }
}
