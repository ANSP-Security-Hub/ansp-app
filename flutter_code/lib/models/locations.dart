import 'package:figma/models/getData.dart';

List<List<double>> locations = [];

void addLocation(double x, double y) {
  locations.add([x, y]);
}

void getLocations() {
  print(locations[0]);
}

List<List<double>> locationsData = [
 
[644,45],
 [140,155],
 [356,273],
 [598,190] ,
 [532,273],
 [308,45],
 [28,273],
 [476,110],
 [476,110],
 [290,190],
 [700,110],
 [700,273],
 [196,273],

 [28,90],
 [476,45],
 [588,110],
 [430,190],

 [290,273],
 [84,213],
 [364,110],
 [710,190],

 [196,90],
 [588,45],
 [588,273],
 [28,155],

 [420,273],
 [196,213],
 [420,45],
 [654,190],

 [542,190],
 [532,45],
 [84,90],
 [140,273],

 [308,110],
 [532,110],
 [644,273],
 [84,155],

 [356,190],
 [700,45],
 [476,273],
 [140,90],

 [420,110],
 [486,190],
 [28,213],
 [644,110],

 [196,155],
 [84,273],
 [364,45],
 [140,213], 
];


//Get devices data
class Devices {
  String id;
  String name;
  String ip;
  String health;
  String status;
  int lastCooncted;

  Devices(
      {required this.id,
      required this.name,
      required this.ip,
      required this.health,
      required this.status,
      required this.lastCooncted});


}

List<Devices> devices =[];



Future<void> getDevices() async {

  var _jsonData = await fetchConnectedDevisesData();
  ///if devices is not empty the old widgets will appear again
  devices = [];
  for (var i = 0; i < _jsonData.length; i++) {
    devices.add(Devices(
        id: _jsonData[i]['id'],
        name: _jsonData[i]['name'],
        ip: _jsonData[i]['ip'],
        health: _jsonData[i]['health'],
        status: _jsonData[i]['status'],
        lastCooncted: 0));
  }
}

Future<void> refreshDevices() async {

  await getDevices();

}

