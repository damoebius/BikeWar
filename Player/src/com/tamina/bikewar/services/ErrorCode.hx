package com.tamina.bikewar.services;

/**
 * ...
 * @author David Mouton
 */

class ErrorCode 
{

	private static function get_BAD_PASSWORD():Int	{ return 2; }
	private static function get_INSUFFICIENT_PERMISSION():Int	{ return 4; }
	private static function get_SUCCESS():Int	{ return 1; }
	private static function get_TECHNICAL_ERROR():Int	{ return 6; }
	private static function get_UNKNOWN_APPLICATION():Int	{ return 3; }
	private static function get_UNKNOWN_USER():Int	{ return 11; }

	static public var BAD_PASSWORD(get_BAD_PASSWORD, null):Int;
	static public var INSUFFICIENT_PERMISSION(get_INSUFFICIENT_PERMISSION, null):Int;
	static public var SUCCESS(get_SUCCESS, null):Int;
	static public var TECHNICAL_ERROR(get_TECHNICAL_ERROR, null):Int;
	static public var UNKNOWN_APPLICATION(get_UNKNOWN_APPLICATION, null):Int;
	static public var UNKNOWN_USER(get_UNKNOWN_USER, null):Int;
	
}