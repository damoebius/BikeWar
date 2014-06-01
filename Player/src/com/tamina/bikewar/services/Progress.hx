package com.tamina.bikewar.services;
class Progress {

    public var loaded:Float;
    public var total:Float;

    public function new(loaded:Float=0.0,total=1.0) {
        this.loaded = loaded;
        this.total = total;
    }
}
