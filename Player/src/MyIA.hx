package ;

/**
 * Model d'IA de base au SDK. Il a le même niveau que le robot de validation des combats
 * @author d.mouton
 */

import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.MapData;
class MyIA extends WorkerIA
{
	/**
	 * @internal
	 */
	public static function main():Void {
		WorkerIA.instance = new MyIA();
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function getOrders( context:MapData ):Array<Order>
	{
		var result:Array<Order> = new Array<Order>();

		return result;
	}
	

	
}