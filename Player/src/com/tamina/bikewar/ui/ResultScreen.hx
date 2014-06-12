package com.tamina.bikewar.ui;
import com.tamina.bikewar.core.Global;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Container;
import createjs.easeljs.Shape;
import createjs.easeljs.Text;

/**
 * ...
 * @author d.mouton
 */

class ResultScreen extends Container
{

	private var _width:Float = 400.0;
	private var _height:Float = 250.0;
	
	private var _backgroundShape:Shape;
	private var _trophyBitmap:Bitmap;
	private var _winnerText:Text;
	private var _messageText:Text;
	
	public function new(winner:String,message:String, width:Float, height:Float)
	{
		super();
        _width = width;
        _height = height;
		_backgroundShape = new Shape();
		this.addChild(_backgroundShape);
		_backgroundShape.graphics.clear();
		_backgroundShape.graphics.beginFill("#000000");
		_backgroundShape.graphics.drawRoundRect(0.0, 0.0, _width, _height, 0.0);
		_backgroundShape.graphics.endFill();
        _backgroundShape.alpha = 0.5;
		_trophyBitmap = new Bitmap( Global.IMG_BASE_PATH +  "images/trophy.png" );
		this.addChild(_trophyBitmap);
        _trophyBitmap.x = Math.floor(_width / 2 - 66);
        _trophyBitmap.y = Math.floor(_height / 2 - 80);
		_winnerText = new Text( winner, "14px Silom");
        _winnerText.color = '#ed1b38';
		_winnerText.maxWidth = _width;
		_winnerText.textAlign = "center";
		_winnerText.x = _width / 2 ;
		_winnerText.y = _trophyBitmap.y + 105.0;
		this.addChild(_winnerText);
		_messageText = new Text( message, "10px Silom" );
        _messageText.color = '#ed1b38';
		_messageText.lineWidth = _width - 180;
		_messageText.lineHeight = 20.0;
		_messageText.x = _width / 2 ;
		_messageText.y = _winnerText.y + 14;
		//this.addChild(_messageText);
	}
	
	public function getWidth():Float {
		return _width;
	}
	
	public function getHeight():Float {
		return _height;
	}
	
}