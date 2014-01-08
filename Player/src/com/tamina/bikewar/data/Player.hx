package com.tamina.bikewar.data;

import org.tamina.utils.UID;
/**
 * Model : IA
 */
class Player {
	

	/**
	 * le nom du robot
	 * @internal
	 */
	public var name:String;
	/**
	 * identifiant unique
	 * @internal
	 */
	public var id:String;
	/**
	 * le script JS
	 * @internal
	 */
	public var script:String;
	
	/**
	 * Constructeur
	 * @param	name
	 * @param	color
	 * @param	script
	 */
	public function new(name:String = "", script:String="")
	{
		this.name = name;
		this.script = script;
		this.id = Std.string( UID.getUID() );
	}
	
	/**
	 * @inheritDoc
	 * @param	context
	 * @return
	 */
	public function getOrders( map:MapData ):Array<Order>
	{
		var result:Array<Order> = new Array<Order>();
		return result;
	}
		
}
