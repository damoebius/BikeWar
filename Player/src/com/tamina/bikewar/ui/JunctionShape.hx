package com.tamina.bikewar.ui;
import org.tamina.geom.Junction;
import createjs.easeljs.Shape;
class JunctionShape extends Shape {

    public var data:Junction;

    public function new(data:Junction) {
        super();
        this.data = data;
        this.x = data.x;
        this.y = data.y;
        this.graphics.beginFill("#FF0000");
        this.graphics.drawRect(-3,-3,6,6);
        this.graphics.endFill();
    }
}
