package com.tamina.bikewar.services;

/**
 * ...
 * @author David Mouton
 */

class ServiceError 
{

	public var ErrorCode:Int;
	public var Message:String;
	
	public function new(Code:Int = 0, Message:String = '')
	{
		this.ErrorCode = Code;
		this.Message = Message;
	}
	
}