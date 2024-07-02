
import 'dart:io';
import 'dart:convert';
import 'package:figma/models/statusScreenData.dart';
import 'package:http/http.dart';



Future<String> getNetworkData() async {
  return await File('lib/Json/statusScreen.json').readAsString();
}


Future<String> getDevicesData() async {
  return  File('lib/Json/devicesData.json').readAsString();
}


//get data from http url
Future<String> getDevicesDataFromUrl() async {
  Response response = await get(Uri.parse('http://10.10.10.2:8000/api/v1/main/devices'));
  return response.body;
}

Future<dynamic> fetchNetworkData() async {
  String data = await getNetworkData();
  return jsonDecode(data);
}

Future<dynamic> fetchDevicesData() async {
  //String data = await getDevicesData();
  String data = await getDevicesDataFromUrl();
  return jsonDecode(data);
}

dynamic usersJsonData = [];

//clear Devices data from disconnected devices
Future<dynamic> fetchConnectedDevisesData() async {
  usersJsonData =[];
  usersJsonData =await fetchDevicesData();
    //print("hello2");

  for (var i = 0; i < usersJsonData.length; i++) {
    if (usersJsonData[i]['status'] == 'disconnected') {
      usersJsonData.removeAt(i);
 
  
    }
  }

  return usersJsonData;

}

////////////////////////
///get the current user data/////

Future<String> getCurrentUser(String deviceId) async {
  return await File('lib/Json/oneDeviceData.json').readAsString();
}

Future<dynamic> fetchCurrentUserData(int index) async {
  String data = await getCurrentUser(usersJsonData[currentUser]['id']);
  return jsonDecode(data);
  
}
UserFullData userFullData = UserFullData(
  name: 'No data',
  ip: 'No data',
  status: 'No data',
  health: 'No data',
  alerts: Alerts(
    lowAlertsNum: 0,
    mediumAlertsNum: 0,
    highAlertsNum: 0,
    alerts: [],
  ),
);

Future<UserFullData> getUserFullData() async {
  dynamic _currentUserData = await fetchCurrentUserData(currentUser);
 return userFullData = UserFullData(
    name: _currentUserData['name'],
    ip: _currentUserData['ip'],
    status: _currentUserData['status'],
    health: _currentUserData['health'],
    alerts: Alerts(
      lowAlertsNum: _currentUserData['alerts']['lowAlertsNum'],
      mediumAlertsNum: _currentUserData['alerts']['mediumAlertsNum'],
      highAlertsNum: _currentUserData['alerts']['highAlertsNum'],
      alerts: List<String>.from(_currentUserData['alerts']['alerts']),
    ),
  );
}

class Alerts {
  Alerts({
    required this.lowAlertsNum,
    required this.mediumAlertsNum,
    required this.highAlertsNum,
    required this.alerts,
  });

  final int lowAlertsNum;
  final int mediumAlertsNum;
  final int highAlertsNum;
  final List<String> alerts;
}
class UserFullData {
  UserFullData({
    required this.name,
    required this.ip,
    required this.status,
    required this.health,
    required this.alerts,

  });

 
  final String name;
  final String ip;
  final String status;
  final String health;
  final Alerts alerts;

}

