package com.tamina.bikewar.ui;
import createjs.easeljs.Shape;
import createjs.easeljs.MouseEvent;
import org.tamina.events.CreateJSEvent;
import org.tamina.geom.Junction;
import createjs.easeljs.Container;
class RoadSprite extends Container {

    private var _roads:Array<Junction>;

    public function new(width:Int, height:Int) {
        super();
        var s:Shape = new Shape();
        s.graphics.beginFill("#cccccc");
        s.graphics.drawRect(0,0,width,height);
        s.graphics.endFill();
        s.alpha = 0.10;
        this.addChild(s);
        this.addEventListener(CreateJSEvent.MOUSE_DOWN, mouseDownHandler);
    }

    public function displayRoads(roads:Array<Junction>):Void{
        _roads = roads;
        for(i in 0..._roads.length){
            var s:JunctionShape = new JunctionShape( _roads[i] );
            this.addChild(s);
        }
    }

    private function mouseDownHandler(event:MouseEvent):Void{
        var j:Junction = new Junction(event.rawX,event.rawY);
        var s:JunctionShape = new JunctionShape(j);
        this.addChild(s);
    }
}
