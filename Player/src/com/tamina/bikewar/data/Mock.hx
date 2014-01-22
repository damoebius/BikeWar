package com.tamina.bikewar.data;
import com.tamina.bikewar.data.vo.BikeStationVO;
import org.tamina.geom.Point;
import com.tamina.bikewar.game.GameUtils;
class Mock {

    public static function getMap(width:Int, height:Int, players:Array<Player>):MapData {
        var result:MapData = new MapData();
        result.currentTime = GameUtils.getCurrentRoundedDate();
// Players
        result.players = players;

// Stations
        var stationsVO = getStationsVO();
        for (i in 0...stationsVO.length) {
            result.stations.push(stationsVO[i].toBikeStation(width,height));
        }
// Camions
        result.trucks.push(new Truck(result.players[0], new Point(100, 100)));
        return result;
    }

    public static function getStation(width:Int, height:Int):BikeStation {
        var result:BikeStation = new BikeStation();
        result.position = new Point( Math.round(Math.random() * width), Math.round(Math.random() * height));
        result.slotNum = Math.round(Math.random() * 30);
        result.bikeNum = Math.round(Math.random() * result.slotNum);
        for (i in 0...96) {
            result.profile.push(Math.round(Math.random() * result.slotNum));
        }
        return result;
    }

    public static function getStationsVO():Array<BikeStationVO> {
        var result:Array<BikeStationVO> = new Array<BikeStationVO>();
        result.push(new BikeStationVO('1', 'M�riadeck', '20', '4.483.803', '-0.58437', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('2', 'Saint Bruno', '20', '4.483.784', '-0.59028', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('3', 'Place Tartas', '18', '4.484.088', '-0.59104', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('4', 'Saint Seurin', '20', '4.484.221', '-0.58482', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('5', 'Place Gambetta', '20', '4.484.150', '-0.58080', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('6', 'Square Andr� Lhote', '20', '4.483.779', '-0.58166', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('7', 'Palais de Justice', '18', '4.483.594', '-0.58211', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('8', 'Patinoire', '20', '4.483.436', '-0.58825', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('9', 'Gavini�s', '20', '4.483.303', '-0.59289', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('10', 'Stade Chaban Delmas', '22', '4.483.176', '-0.59868', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('11', 'Cit� Administrative', '20', '4.484.166', '-0.59970', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('12', 'Grand Lebrun', '16', '4.485.115', '-0.60861', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('13', 'Barri�re Saint M�dard', '20', '4.484.837', '-0.59810', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('14', 'Dubreuil-Turenne', '14', '4.484.819', '-0.59197', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('15', 'rue de la Croix Blanche', '14', '4.484.521', '-0.59206', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('16', 'Galin', '18', '4.484.947', '-0.54525', 'Vcub', 'FAUX', '2', 'VRAI', 'In'));
        result.push(new BikeStationVO('17', 'Palais Gallien', '14', '4.484.690', '-0.58219', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('18', 'Huguerie', '14', '4.484.423', '-0.58164', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('19', 'Place Tourny', '20', '4.484.465', '-0.57745', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('20', 'Place des Grands Hommes', '20', '4.484.314', '-0.57724', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('21', 'Place Puy Paulin', '15', '4.484.122', '-0.57560', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('22', 'Hotel de Ville', '33', '4.483.826', '-0.57648', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('23', 'R�publique', '20', '4.483.483', '-0.58019', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('24', 'Lib�ration', '16', '4.483.325', '-0.58308', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('25', 'Rue Fran�ois de Sourdis', '14', '4.483.100', '-0.58734', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('26', 'Xaintrailles', '16', '4.482.797', '-0.59349', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('27', 'Universit� Bordeaux II', '20', '4.482.654', '-0.60184', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('28', 'Pellegrin', '20', '4.482.986', '-0.60351', 'Vcub', 'VRAI', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('29', 'Saint Augustin', '20', '4.483.251', '-0.61047', 'Vcub', 'VRAI', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('30', 'La Glaciere Mond�sir', '18', '4.483.838', '-0.61689', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('31', 'Caud�ran', '16', '4.485.175', '-0.61438', 'Vcub+', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('32', 'Parc Bordelais', '16', '4.485.261', '-0.59923', 'Vcub', 'VRAI', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('33', 'Barri�re du M�doc', '18', '4.485.343', '-0.59264', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('34', 'Tivoli', '14', '4.485.379', '-0.58864', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('35', 'Place Marie Brizard', '16', '4.485.005', '-0.58547', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('36', 'Place de Longchamps', '18', '4.485.005', '-0.58200', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('37', 'Jardin Public', '20', '4.484.849', '-0.57581', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('39', 'Quinconces', '40', '4.484.423', '-0.57434', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('40', 'Grand Th��tre', '20', '4.484.293', '-0.57390', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('41', 'Place Saint Projet', '18', '4.483.889', '-0.57466', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('42', 'Place Camille Jullian', '20', '4.483.924', '-0.57203', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('43', 'Saint Paul', '18', '4.483.707', '-0.57279', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('44', 'Mus�e d Aquitaine', '20', '4.483.606', '-0.57544', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('45', 'Place Sainte Eulalie', '20', '4.483.312', '-0.57695', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('46', 'Belcier', '21', '4.482.278', '-0.55296', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('47', 'Magendie', '16', '4.482.789', '-0.58605', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('48', 'Barri�re de Pessac', '18', '4.482.578', '-0.58975', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('49', 'Le Bouscat Mairie', '18', '4.486.329', '-0.59995', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('50', 'Mandron Godard', '14', '4.485.999', '-0.58876', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('51', 'Place Amp�re', '20', '4.486.260', '-0.58328', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('52', 'Place de l Europe', '18', '4.485.890', '-0.58108', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('53', 'Parc Rivi�re', '14', '4.485.417', '-0.58659', 'Vcub', 'FAUX', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('54', 'Rue St Vincent de Paul', '22', '4.482.642', '-0.55732', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('55', 'Camille Godard', '16', '4.485.462', '-0.57435', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('56', 'Place Paul Doumer', '20', '4.485.171', '-0.57427', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('57', 'Eglise Saint-Louis', '16', '4.485.155', '-0.57163', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('58', 'Chartrons', '18', '4.485.321', '-0.56727', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('59', 'CAPC', '18', '4.484.978', '-0.57024', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('60', 'All�es de Chartres', '20', '4.484.718', '-0.57131', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('61', 'Parc aux Ang�liques', '16', '4.484.625', '-0.56495', 'Vcub', 'VRAI', '2', 'VRAI', 'In'));
        result.push(new BikeStationVO('62', 'Cenon Gare', '18', '4.485.614', '-0.53364', 'Vcub+', 'FAUX', '3', 'VRAI', 'In'));
        result.push(new BikeStationVO('63', 'Fran�ois Mitterrand', '18', '4.483.028', '-0.52697', 'Vcub+', 'FAUX', '3', 'VRAI', 'In'));
        result.push(new BikeStationVO('64', 'La Benauge', '18', '4.483.960', '-0.55645', 'Vcub', 'VRAI', '2', 'VRAI', 'In'));
        result.push(new BikeStationVO('65', 'Stalingrad', '41', '4.484.034', '-0.55955', 'Vcub', 'VRAI', '1', 'VRAI', 'In'));
        result.push(new BikeStationVO('66', 'Gare d Orl�ans', '20', '4.484.114', '-0.56224', 'Vcub', 'VRAI', '1', 'VRAI', 'In'));
        result.push(new BikeStationVO('67', 'All�e de Serr - Abadie', '18', '4.484.377', '-0.55751', 'Vcub', 'FAUX', '2', 'VRAI', 'In'));
        result.push(new BikeStationVO('68', 'Thiers Jardin Botanique', '18', '4.484.298', '-0.55573', 'Vcub', 'VRAI', '3', 'VRAI', 'In'));
        result.push(new BikeStationVO('69', 'Cours Le Rouzic', '14', '4.484.300', '-0.55033', 'Vcub', 'FAUX', '2', 'VRAI', 'In'));
        result.push(new BikeStationVO('70', 'Buttini�re', '20', '4.486.428', '-0.52420', 'Vcub+', 'FAUX', '3', 'VRAI', 'In'));
        result.push(new BikeStationVO('71', 'La Gardette', '18', '4.488.750', '-0.51763', 'Vcub+', 'FAUX', '3', 'VRAI', 'Out'));
        result.push(new BikeStationVO('72', 'Jean Zay', '24', '4.485.418', ' - 0.51282', 'Vcub + ', 'FAUX', '3', 'VRAI', 'In'));
        result.push(new BikeStationVO('73', 'Terres Neuves', '21', '4.481.535', ' - 0.55115', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('74', 'Place du 14 Juillet', '22', '4.480.770', ' - 0.54821', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('75', 'Ferdinand Buisson', '18', '4.480.329', ' - 0.55774', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('76', 'Pont de la Maye', '21', '4.478.215', ' - 0.56616', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('77', 'Place Bernard Roumegoux', '20', '4.477.353', ' - 0.61432', 'Vcub + ', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('78', 'Bougnard', '20', '4.479.387', '-0.63530', 'Vcub+', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('79', 'Pessac Bersol', '20', '4.478.620', '-0.63874', 'Vcub+', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('80', 'Gare Alouette', '18', '4.479.329', ' - 0.65926', 'Vcub + ', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('81', 'L. Morin Cazalet', '18', '4.479.588', '-0.66733', 'Vcub+', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('82', 'La Ch�taigneraie', '18', '4.479.326', ' - 0.64731', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('83', 'Pessac Centre', '21', '4.480.446', '- 0.63267', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('84', 'Le Burck', '18', '4.481.535', ' - 0.63444', 'Vcub+ ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('85', 'M�rignac Quatre Chemins', '18', '4.483.242', ' - 0.64594', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('86', 'M�rignac Soleil', '20', '4.483.256', ' - 0.65698', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('87', 'Kennedy Parc Hotelier', '20', '4.483.628', ' - 0.68713', 'Vcub + ', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('88', 'M�rignac Capeyron', '18', '4.485.097', '-0.64475', 'Vcub+', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('89', 'M�rignac Centre', '21', '4.484.105', '-0.64707', 'Vcub+', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('90', 'Fontaine d Arlac', '18', '4.482.650', '-0.62577', 'Vcub+', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('91', 'Mairie du Haillan', '16', '4.487.369', '-0.67753', 'Vcub+', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('92', 'St M�dard Place de la R�publique', '16', '4.489.530', ' - 0.71467', 'Vcub + ', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('93', 'Eysines Centre', '16', '4.488.396', '-0.64992', 'Vcub+', 'FAUX', '3', 'FAUX', 'Out'));
        result.push(new BikeStationVO('94', 'Gare de Blanquefort', '18', '4.491.730', ' - 0.62382', 'Vcub +', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('95', 'Bruges H�tel de Ville', '16', '4.488.145', ' - 0.61337', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('96', 'Les Aubiers', '26', '4.487.389', ' - 0.57401', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('97', 'Claveau', '20', '4.487.738', ' - 0.54433', 'Vcub + ', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('98', 'Bassins � Flot', '18', '4.486.007', ' - 0.55447', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('99', 'Les Hangars', '20', '4.485.787', ' - 0.55808', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('100', 'Cours du M�doc', '20', '4.485.560', ' - 0.56319', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('101', 'Place Jean Jaur�s', '20', '4.484.295', ' - 0.57037', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('102', 'Place de la Bourse', '20', '4.484.030', ' - 0.56914', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('103', 'Place du Palais', '20', '4.483.779', ' - 0.57034', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('104', 'Grosse Cloche', '17', '4.483.518', '- 0.57205', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('105', 'Rue du Mirail', '20', '4.483.262', ' - 0.57097', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('106', 'Place de la Victoire', '40', '4.483.064', ' -0.57321', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('107', 'Saint -Nicolas', '15', '4.482.751', ' - 0.57589', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('108', 'Bergoni�', '16', '4.482.471', ' - 0.57815', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('109', 'Barri�re Saint Gen�s', '36', '4.482.209', ' - 0.58178', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('110', 'Forum', '41', '4.481.238', ' - 0.59103', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('111', 'Peixotto', '40', '4.480.681', ' - 0.59245', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('112', 'Arts et M�tiers', '40', '4.480.591', ' - 0.60232', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('113', 'Ecole de Management', '20', '4.479.688', ' - 0.60187', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('114', 'Compostelle', '27', '4.479.313', '- 0.60547', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('115', 'CREPS', '32', '4.480.091', ' - 0.59651', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('116', 'Montaigne Montesquieu', '40', '4.479.667', ' - 0.61704', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('117', 'Doyen Brus', '20', '4.480.038', ' - 0.60986', 'Vcub', 'FAUX', '3', 'FAUX', 'In'));
        result.push(new BikeStationVO('118', 'Le Bouscat Ravezies', '20', '4.486.694', ' - 0.57608', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('119', 'Tram station Grand Parc', '20', '4.486.260', ' - 0.57576', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('120', 'Saint Louis Haussmann', '18', '4.486.261', ' - 0.56718', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('121', 'Place Saint Martial', '14', '4.485.891', ' - 0.56584', 'Vcub', 'FAUX', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('122', 'Cours Saint Louis M�doc', '16', '4.485.849', ' - 0.56966', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('123', 'Porte de Bourgogne', '36', '4.483.779', ' - 0.56716', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('124', 'Parc des sports', '20', '4.483.387', '- 0.56271', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('125', 'Conservatoire', '20', '4.483.183', ' - 0.55966', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('126', 'Quai de Paludate', '12', '4.482.670', ' - 0.54983', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('127', 'Gare Saint - Jean', '22', '4.482.630', ' - 0.55707', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('128', 'Sacr� Coeur', '16', '4.482.218', ' - 0.56308', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('129', 'Barri�re de B�gles', '17', '4.481.308', ' - 0.56420', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('130', 'Barri�re de Toulouse', '19', '4.481.456', ' -0.57082', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('131', 'Nansouty', '16', '4.482.032', ' - 0.57185', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('132', 'Cours de la Somme', '14', '4.482.628', ' - 0.57248', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('133', 'Capucins', '20', '4.482.995', ' - 0.56812', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('134', 'Place du Maucaillou', '19', '4.483.263', ' - 0.56711', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('135', 'Place Saint Michel', '20', '4.483.462', ' - 0.56661', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('136', 'Eglise Sainte Croix', '18', '4.483.131', '- 0.56139', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('137', 'Place Andr� Meunier', '25', '4.482.831', ' - 0.56229', 'Vcub', 'VRAI', '1', 'FAUX', 'In'));
        result.push(new BikeStationVO('138', 'Barbey', '18', '4.482.656', ' - 0.56455', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        result.push(new BikeStationVO('139', 'Lyc�e Br�montier', '18', '4.482.405', ' - 0.57024', 'Vcub', 'VRAI', '2', 'FAUX', 'In'));
        return result;
    }
}
