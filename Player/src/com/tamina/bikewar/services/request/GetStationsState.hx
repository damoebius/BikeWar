package com.tamina.bikewar.services.request;
import org.tamina.log.QuickLogger;
import org.tamina.net.URL;
import js.html.XMLHttpRequestProgressEvent;
class GetStationsState extends HTTPRequest {

    private static var PROXY_URL:String="http://www.tamina-online.com/request-proxy.php?url=";
    private static var WS_URL:String="http%3A%2F%2Fdata.lacub.fr%2Fwfs%3Fkey%3DXE8PIF0GPT%26REQUEST%3DGetFeature%26SERVICE%3DWFS%26SRSNAME%3DEPSG%253A3945%26TYPENAME%3DCI_VCUB_P%26VERSION%3D1.1.0%26Filter%3D%253CFilter%253E%253CBBOX%253E%253CPropertyName%253ENAME%253C%252FPropertyName%253E%253CBox%2520srsName%253D%2527EPSG%253A3945%2527%253E%253Ccoordinates%253E1365861.3264043%252C4149211.3264043%25201455938.6735957%252C4239288.6735957%253C%252Fcoordinates%253E%253C%252FBox%253E%253C%252FBBOX%253E%253C%252FFilter%253E";

    public function new(successCallBack:XMLHttpRequestProgressEvent -> Void) {
        super( new URL(PROXY_URL +  WS_URL),successCallBack,_errorHandler);
    }

    private function _errorHandler(error:ServiceError):Void{
        QuickLogger.info('Impossible de recuperer les données du webservice');
    }

}
