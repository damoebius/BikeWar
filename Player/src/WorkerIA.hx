package ;

/**
 * @internal Classe Abstratite, utilisée pour toutes les IA
 * @author David Mouton
 */

import com.tamina.bikewar.data.TurnResult;
import com.tamina.bikewar.data.TurnMessage;
import com.tamina.bikewar.data.Order;
import com.tamina.bikewar.data.MapData;
class WorkerIA
{

	public static var instance:WorkerIA;
	
	public var id:String;
	public var name:String;
	/**
	 * Message renvoyé à la fin du tour par l'IA est affiché dans la console.
	 */
	public var debugMessage:String;
	public var script:String;
	
	/**
	 * Contructeur
	 * @param	name
	 * @param	color
	 */
	public function new(name:String = "")
	{
		this.name = name;
		this.debugMessage = "";
	}
	
	public static function __init__(){
	   untyped __js__("onmessage = WorkerIA.prototype.messageHandler");
	}
	
	/**
	 * Principale méthode de l'IA: invoquée à chaques tour par le systeme pour récupéré les ordres à exécuter.
	 * @param	context : La Galaxy en l'etat
	 * @return la liste des ordres à executer
	 */
	public function getOrders( context:MapData ):Array<Order>
	{
		var result:Array<Order> = new Array<Order>();
		return result;
	}
	
	private function messageHandler( event : Dynamic ) : Void {
		if (event.data != null) {
			var turnMessage:TurnMessage = event.data;
			instance.id = turnMessage.playerId;
            var orders:Array<Order> = null;
            var msg:String = instance.debugMessage;
            try{
                orders =  instance.getOrders( turnMessage.data );
            } catch (e:Dynamic) {
                msg = Std.string(e + ' ' + e.stack);
            }
			this.postMessage( new TurnResult(orders, msg) );
		} else {
			this.postMessage("data null");
		}
		
	}
	
	private function postMessage( message : Dynamic ) : Void {
		
	}
	
}