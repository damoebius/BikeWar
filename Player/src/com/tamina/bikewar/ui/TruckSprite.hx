package com.tamina.bikewar.ui;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Text;
import com.tamina.bikewar.data.Truck;
import createjs.easeljs.Container;

class TruckSprite extends Container {

    private var _data:Truck;
    private var _label:Text;
    private var _backgroundContainer:Container;
    private var _backgroundBitmap:Bitmap;

    public function new(data:Truck) {
        super();
        _data = data;
        _backgroundBitmap = new Bitmap('images/truck_bg_0.png');
        _backgroundContainer = new Container();
        _backgroundContainer.addChild(_backgroundBitmap);
        this.addChild(_backgroundContainer);
        _label = new Text();
        _label.x = 27;
        _label.y = 24;
        _label.textAlign = 'center';
        _label.color = '#000000';
        _label.font = "08px Pixel01";
        _label.text = Std.string(_data.bikeNum);
        this.addChild(_label);
    }
}
