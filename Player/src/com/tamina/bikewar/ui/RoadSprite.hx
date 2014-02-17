package com.tamina.bikewar.ui;
import haxe.Serializer;
import createjs.easeljs.Shape;
import createjs.easeljs.MouseEvent;
import org.tamina.events.CreateJSEvent;
import org.tamina.geom.Junction;
import createjs.easeljs.Container;
class RoadSprite extends Container {

    private var _roads:Array<Junction>;

    private var _exportButton:Shape;
    private var _backgroundShape:Shape;
    private var _linksShape:Shape;

    private var _selectedJunctionShape:JunctionShape;

    public function new(width:Int, height:Int) {
        super();
        _backgroundShape = new Shape();
        _backgroundShape.graphics.beginFill("#cccccc");
        _backgroundShape.graphics.drawRect(0,0,width,height);
        _backgroundShape.graphics.endFill();
        _backgroundShape.alpha = 0.10;
        this.addChild(_backgroundShape);
        _backgroundShape.addEventListener(CreateJSEvent.MOUSE_DOWN, mouseDownHandler);

        _linksShape = new Shape();
        this.addChild(_linksShape);

        _exportButton = new Shape();
        _exportButton.graphics.beginFill("#FFCC00");
        _exportButton.graphics.drawRect(0,0,20,20);
        _exportButton.graphics.endFill();
        _exportButton.x = 1040;
        this.addChild(_exportButton);
        _exportButton.addEventListener(CreateJSEvent.MOUSE_DOWN, export_mouseDownHandler);
    }

    public function displayRoads(roads:Array<Junction>):Void{
        _roads = roads;
        for(i in 0..._roads.length){
        var r = roads[i];
            var s:JunctionShape = new JunctionShape( r );
            for(j in 0...r.links.length){
                _linksShape.graphics.beginStroke("#FF0000");
                _linksShape.graphics.moveTo(r.x,r.y);
                _linksShape.graphics.lineTo(r.links[j].x,r.links[j].y);
                _linksShape.graphics.endStroke();
            }
            s.addEventListener(CreateJSEvent.MOUSE_DOWN, junction_mouseDownHandler);
            this.addChild(s);
        }
    }

    private function junction_mouseDownHandler(event:MouseEvent):Void{
        var targetJunctionShape:JunctionShape = cast event.target;
        if(_selectedJunctionShape == null){
           _selectedJunctionShape = targetJunctionShape;
        }  else {
            _linksShape.graphics.beginStroke("#FF0000");
            _linksShape.graphics.moveTo(_selectedJunctionShape.x,_selectedJunctionShape.y);
            _linksShape.graphics.lineTo(targetJunctionShape.x,targetJunctionShape.y);
            _linksShape.graphics.endStroke();
            _selectedJunctionShape.data.links.push(targetJunctionShape.data);
            targetJunctionShape.data.links.push(_selectedJunctionShape.data);
            _selectedJunctionShape = null;

        }
    }

    private function export_mouseDownHandler(event:MouseEvent):Void{
        Serializer.USE_CACHE = true;
        var exportData:String = Serializer.run(_roads);
        trace(exportData);
    }

    private function mouseDownHandler(event:MouseEvent):Void{
        _selectedJunctionShape = null;
        var j:Junction = new Junction(event.rawX,event.rawY);
        _roads.push(j);
        var s:JunctionShape = new JunctionShape(j);
        s.addEventListener(CreateJSEvent.MOUSE_DOWN, junction_mouseDownHandler);
        this.addChild(s);
    }
}
