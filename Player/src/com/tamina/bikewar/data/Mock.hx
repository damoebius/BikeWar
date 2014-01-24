package com.tamina.bikewar.data;
import com.tamina.bikewar.game.Game;
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
            result.stations.push(stationsVO[i].toBikeStation(width, height));
        }
// Camions
        result.trucks.push(new Truck(result.players[0], Game.START_POINTS[0]));
        result.trucks.push(new Truck(result.players[0], Game.START_POINTS[0]));
        result.trucks.push(new Truck(result.players[1], Game.START_POINTS[1]));
        result.trucks.push(new Truck(result.players[1], Game.START_POINTS[1]));
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
        result.push(new BikeStationVO('1', 'Mériadeck', '20', '44.83803', '-0.58437', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('2', 'Saint Bruno', '20', '44.83784', '-0.59028', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('3', 'Place Tartas', '18', '44.84088', '-0.59104', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('4', 'Saint Seurin', '20', '44.84221', '-0.58482', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('5', 'Place Gambetta', '20', '44.84150', '-0.58080', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('6', 'Square André Lhote', '20', '44.83779', '-0.58166', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('7', 'Palais de Justice', '18', '44.83594', '-0.58211', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('8', 'Patinoire', '20', '44.83436', '-0.58825', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('9', 'Gaviniès', '20', '44.83303', '-0.59289', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('10', 'Stade Chaban Delmas', '22', '44.83176', '-0.59868', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('11', 'Cité Administrative', '20', '44.84166', '-0.59970', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('12', 'Grand Lebrun', '16', '44.85115', '-0.60861', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('13', 'Barrière Saint Médard', '20', '44.84837', '-0.59810', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('14', 'Dubreuil-Turenne', '14', '44.84819', '-0.59197', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('15', 'rue de la Croix Blanche', '14', '44.84521', '-0.59206', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('16', 'Galin', '18', '44.84947', '-0.54525', 'Vcub', 'FAUX', '2', 'VRAI'));
        result.push(new BikeStationVO('17', 'Palais Gallien', '14', '44.84690', '-0.58219', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('18', 'Huguerie', '14', '44.84423', '-0.58164', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('19', 'Place Tourny', '20', '44.84465', '-0.57745', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('20', 'Place des Grands Hommes', '20', '44.84314', '-0.57724', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('21', 'Place Puy Paulin', '15', '44.84122', '-0.57560', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('22', 'Hotel de Ville', '33', '44.83826', '-0.57648', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('23', 'République', '20', '44.83483', '-0.58019', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('24', 'Libération', '16', '44.83325', '-0.58308', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('25', 'Rue François de Sourdis', '14', '44.83100', '-0.58734', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('26', 'Xaintrailles', '16', '44.82797', '-0.59349', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('27', 'Université Bordeaux II', '20', '44.82654', '-0.60184', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('28', 'Pellegrin', '20', '44.82986', '-0.60351', 'Vcub', 'VRAI', '3', 'FAUX'));
        result.push(new BikeStationVO('29', 'Saint Augustin', '20', '44.83251', '-0.61047', 'Vcub', 'VRAI', '3', 'FAUX'));
        result.push(new BikeStationVO('30', 'La Glaciere Mondésir', '18', '44.83838', '-0.61689', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('31', 'Caudéran', '16', '44.85175', '-0.61438', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('32', 'Parc Bordelais', '16', '44.85261', '-0.59923', 'Vcub', 'VRAI', '3', 'FAUX'));
        result.push(new BikeStationVO('33', 'Barrière du Médoc', '18', '44.85343', '-0.59264', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('34', 'Tivoli', '14', '44.85379', '-0.58864', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('35', 'Place Marie Brizard', '16', '44.85005', '-0.58547', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('36', 'Place de Longchamps', '18', '44.85005', '-0.58200', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('37', 'Jardin Public', '20', '44.84849', '-0.57581', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('38', 'Place Charles Gruet', '16', '44.84641', '-0.58020', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('39', 'Quinconces', '40', '44.84423', '-0.57434', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('40', 'Grand Théâtre', '20', '44.84293', '-0.57390', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('41', 'Place Saint Projet', '18', '44.83889', '-0.57466', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('42', 'Place Camille Jullian', '20', '44.83924', '-0.57203', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('43', 'Saint Paul', '18', '44.83707', '-0.57279', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('44', 'Musée d Aquitaine', '20', '44.83606', '-0.57544', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('45', 'Place Sainte Eulalie', '20', '44.83312', '-0.57695', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('46', 'Belcier', '21', '44.82278', '-0.55296', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('47', 'Magendie', '16', '44.82789', '-0.58605', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('48', 'Barrière de Pessac', '18', '44.82578', '-0.58975', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('49', 'Le Bouscat Mairie', '18', '44.86329', '-0.59995', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('50', 'Mandron Godard', '14', '44.85999', '-0.58876', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('51', 'Place Ampère', '20', '44.86260', '-0.58328', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('52', 'Place de l Europe', '18', '44.85890', '-0.58108', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('53', 'Parc Rivière', '14', '44.85417', '-0.58659', 'Vcub', 'FAUX', '2', 'FAUX'));
        result.push(new BikeStationVO('54', 'Rue St Vincent de Paul', '22', '44.82642', '-0.55732', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('55', 'Camille Godard', '16', '44.85462', '-0.57435', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('56', 'Place Paul Doumer', '20', '44.85171', '-0.57427', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('57', 'Eglise Saint-Louis', '16', '44.85155', '-0.57163', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('58', 'Chartrons', '18', '44.85321', '-0.56727', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('59', 'CAPC', '18', '44.84978', '-0.57024', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('60', 'Allées de Chartres', '20', '44.84718', '-0.57131', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('61', 'Parc aux Angéliques', '16', '44.84625', '-0.56495', 'Vcub', 'VRAI', '2', 'VRAI'));
        result.push(new BikeStationVO('62', 'Cenon Gare', '18', '44.85614', '-0.53364', 'Vcub+', 'FAUX', '3', 'VRAI'));
        result.push(new BikeStationVO('63', 'François Mitterrand', '18', '44.83028', '-0.52697', 'Vcub+', 'FAUX', '3', 'VRAI'));
        result.push(new BikeStationVO('64', 'La Benauge', '18', '44.83960', '-0.55645', 'Vcub', 'VRAI', '2', 'VRAI'));
        result.push(new BikeStationVO('65', 'Stalingrad', '41', '44.84034', '-0.55955', 'Vcub', 'VRAI', '1', 'VRAI'));
        /*result.push(new BikeStationVO('650', 'MIN', '41', Std.string(BikeStationVO.northEastGPS.y), Std.string(BikeStationVO.northEastGPS.x), 'Vcub', 'VRAI', '1', 'VRAI'));
        result.push(new BikeStationVO('651', 'MAX', '41', Std.string(BikeStationVO.southWestGPS.y), Std.string(BikeStationVO.southWestGPS.x), 'Vcub', 'VRAI', '1', 'VRAI'));*/
        result.push(new BikeStationVO('66', 'Gare d Orléans', '20', '44.84114', '-0.56224', 'Vcub', 'VRAI', '1', 'VRAI'));
        result.push(new BikeStationVO('67', 'Allée de Serr - Abadie', '18', '44.84377', '-0.55751', 'Vcub', 'FAUX', '2', 'VRAI'));
        result.push(new BikeStationVO('68', 'Thiers Jardin Botanique', '18', '44.84298', '-0.55573', 'Vcub', 'VRAI', '3', 'VRAI'));
        result.push(new BikeStationVO('69', 'Cours Le Rouzic', '14', '44.84300', '-0.55033', 'Vcub', 'FAUX', '2', 'VRAI'));
        result.push(new BikeStationVO('70', 'Buttinière', '20', '44.86428', '-0.52420', 'Vcub+', 'FAUX', '3', 'VRAI'));
        result.push(new BikeStationVO('71', 'La Gardette', '18', '44.88750', '-0.51763', 'Vcub+', 'FAUX', '3', 'VRAI'));
        result.push(new BikeStationVO('72', 'Jean Zay', '24', '44.85418', '-0.51282', 'Vcub+', 'FAUX', '3', 'VRAI'));
        result.push(new BikeStationVO('73', 'Terres Neuves', '21', '44.81535', '-0.55115', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('74', 'Place du 14 Juillet', '22', '44.80770', '-0.54821', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('75', 'Ferdinand Buisson', '18', '44.80329', '-0.55774', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('76', 'Pont de la Maye', '21', '44.78215', '-0.56616', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('77', 'Place Bernard Roumegoux', '20', '44.77353', '-0.61432', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('78', 'Bougnard', '20', '44.79387', '-0.63530', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('79', 'Pessac Bersol', '20', '44.78620', '-0.63874', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('80', 'Gare Alouette', '18', '44.79329', '-0.65926', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('81', 'L. Morin Cazalet', '18', '44.79588', '-0.66733', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('82', 'La Châtaigneraie', '18', '44.79326', '-0.64731', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('83', 'Pessac Centre', '21', '44.80446', '-0.63267', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('84', 'Le Burck', '18', '44.81535', '-0.63444', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('85', 'Mérignac Quatre Chemins', '18', '44.83242', '-0.64594', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('86', 'Mérignac Soleil', '20', '44.83256', '-0.65698', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('87', 'Kennedy Parc Hotelier', '20', '44.83628', '-0.68713', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('88', 'Mérignac Capeyron', '18', '44.85097', '-0.64475', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('89', 'Mérignac Centre', '21', '44.84105', '-0.64707', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('90', 'Fontaine d Arlac', '18', '44.82650', '-0.62577', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('91', 'Mairie du Haillan', '16', '44.87369', '-0.67753', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('92', 'St Médard Place de la République', '16', '44.89530', '-0.71467', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('93', 'Eysines Centre', '16', '44.88396', '-0.64992', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('94', 'Gare de Blanquefort', '18', '44.91730', '-0.62382', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('95', 'Bruges Hôtel de Ville', '16', '44.88145', '-0.61337', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('96', 'Les Aubiers', '26', '44.87389', '-0.57401', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('97', 'Claveau', '20', '44.87738', '-0.54433', 'Vcub+', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('98', 'Bassins à Flot', '18', '44.86007', '-0.55447', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('99', 'Les Hangars', '20', '44.85787', '-0.55808', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('100', 'Cours du Médoc', '20', '44.85560', '-0.56319', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('101', 'Place Jean Jaurès', '20', '44.84295', '-0.57037', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('102', 'Place de la Bourse', '20', '44.84030', '-0.56914', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('103', 'Place du Palais', '20', '44.83779', '-0.57034', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('104', 'Grosse Cloche', '17', '44.83518', '-0.57205', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('105', 'Rue du Mirail', '20', '44.83262', '-0.57097', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('106', 'Place de la Victoire', '40', '44.83064', '-0.57321', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('107', 'Saint-Nicolas', '15', '44.82751', '-0.57589', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('108', 'Bergonié', '16', '44.82471', '-0.57815', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('109', 'Barrière Saint Genès', '36', '44.82209', '-0.58178', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('110', 'Forum', '41', '44.81238', '-0.59103', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('111', 'Peixotto', '40', '44.80681', '-0.59245', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('112', 'Arts et Métiers', '40', '44.80591', '-0.60232', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('113', 'Ecole de Management', '20', '44.79688', '-0.60187', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('114', 'Compostelle', '27', '44.79313', '-0.60547', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('115', 'CREPS', '32', '44.80091', '-0.59651', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('116', 'Montaigne Montesquieu', '40', '44.79667', '-0.61704', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('117', 'Doyen Brus', '20', '44.80038', '-0.60986', 'Vcub', 'FAUX', '3', 'FAUX'));
        result.push(new BikeStationVO('118', 'Le Bouscat Ravezies', '20', '44.86694', '-0.57608', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('119', 'Tram station Grand Parc', '20', '44.86260', '-0.57576', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('120', 'Saint Louis Haussmann', '18', '44.86261', '-0.56718', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('121', 'Place Saint Martial', '14', '44.85891', '-0.56584', 'Vcub', 'FAUX', '1', 'FAUX'));
        result.push(new BikeStationVO('122', 'Cours Saint Louis Médoc', '16', '44.85849', '-0.56966', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('123', 'Porte de Bourgogne', '36', '44.83779', '-0.56716', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('124', 'Parc des sports', '20', '44.83387', '-0.56271', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('125', 'Conservatoire', '20', '44.83183', '-0.55966', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('126', 'Quai de Paludate', '12', '44.82670', '-0.54983', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('127', 'Gare Saint-Jean', '22', '44.82630', '-0.55707', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('128', 'Sacré Coeur', '16', '44.82218', '-0.56308', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('129', 'Barrière de Bègles', '17', '44.81308', '-0.56420', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('130', 'Barrière de Toulouse', '19', '44.81456', '-0.57082', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('131', 'Nansouty', '16', '44.82032', '-0.57185', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('132', 'Cours de la Somme', '14', '44.82628', '-0.57248', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('133', 'Capucins', '20', '44.82995', '-0.56812', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('134', 'Place du Maucaillou', '19', '44.83263', '-0.56711', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('135', 'Place Saint Michel', '20', '44.83462', '-0.56661', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('136', 'Eglise Sainte Croix', '18', '44.83131', '-0.56139', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('137', 'Place André Meunier', '25', '44.82831', '-0.56229', 'Vcub', 'VRAI', '1', 'FAUX'));
        result.push(new BikeStationVO('138', 'Barbey', '18', '44.82656', '-0.56455', 'Vcub', 'VRAI', '2', 'FAUX'));
        result.push(new BikeStationVO('139', 'Lycée Brémontier', '18', '44.82405', '-0.57024', 'Vcub', 'VRAI', '2', 'FAUX'));
        return result;
    }
}
