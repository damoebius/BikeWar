package com.tamina.bikewar.ui;
import createjs.easeljs.Container;
import com.tamina.bikewar.data.BikeStation;
import createjs.easeljs.Sprite;
class BikeStationSprite extends Container {

    private var _data:BikeStation;

    public function new(data:BikeStation) {
        super();
        _data = data;
    }
}
