import 'package:figma/models/getData.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';


int statesScreen = 0;
int currentUser = 0;

 Future<void> setStatesScreen(int index) async {
  statesScreen = index;
} 
Future<void> setCurrentUser(int index) async {
  currentUser = index;
}
dynamic _networkJsonData = [];
dynamic _usersJsonData = [];

class NetworkStatusData {
  final String topSite;
  final int connectedUsers;
  final String speed;

  NetworkStatusData(
      {required this.topSite,
      required this.connectedUsers,
      required this.speed});
}

class UserStatusData {
  final String id;
  final String name;
  final String ip;
  final String health;
  final String status;
 // final int lastCooncted;

  UserStatusData({required this.id, required this.name, required this.ip, this.health = 'Healthy', this.status = 'active'/* , required this.lastCooncted */});
}

NetworkStatusData networkStatusData =
    NetworkStatusData(topSite: 'No', connectedUsers: 0, speed: 'No');
UserStatusData userStatusData = UserStatusData(id: '0', name: 'No', ip: 'No');

/* Future<String> getNetworkData() async {
  return await File('lib/Json/statusScreen.json').readAsString();
} */
/* Future<String> getDevicesData() async {
  return  File('lib/Json/devicesData.json').readAsString();
} */

//get data from http url
/* Future<String> getDevicesDataFromUrl() async {
  Response response = await get(Uri.parse('http://10.10.10.2:8000/api/v1/main/devices'));
  return response.body;
} */

/* Future<dynamic> fetchNetworkData() async {
  String data = await getNetworkData();
  return jsonDecode(data);
} */

/* Future<dynamic> fetchDevicesData() async {
  String data = await getDevicesData();
  //String data = await getDevicesDataFromUrl();
  return jsonDecode(data);
} */

Future<void> getNetworkStatusData() async {
  _networkJsonData = await fetchNetworkData(); // Wait for the data to be fetched

  networkStatusData = await NetworkStatusData(
    topSite: _networkJsonData['TopSite'].isEmpty ? 'No data' : _networkJsonData['TopSite'],
    connectedUsers: _networkJsonData['Devices'] == null ? 0 : _networkJsonData['Devices'],
    speed: _networkJsonData['Speed'].isEmpty ? 'No data' : _networkJsonData['Speed'],
  );
 // print(networkStatusData.connectedUsers);
}
//clear Devices data from disconnected devices
/* Future<dynamic> fetchConnectedDevisesData() async {
  _usersJsonData =[];
  _usersJsonData =await fetchDevicesData();
    print("hello2");

  for (var i = 0; i < _usersJsonData.length; i++) {
    if (_usersJsonData[i]['status'] == 'disconnected') {
      _usersJsonData.removeAt(i);
      print(i);
      
  
    }
  }
  print(_usersJsonData.length);
  return _usersJsonData;

} */

Future<void> getUserStatusData() async {
  _usersJsonData =[];
 // print("hello");
  _usersJsonData =   await fetchConnectedDevisesData();
 // print(_usersJsonData[0]);
  userStatusData =  UserStatusData(
    id: _usersJsonData[currentUser]['id'] ==null ? 'No data' : _usersJsonData[currentUser]['id'],
    name: _usersJsonData[currentUser]['name'],
    ip: _usersJsonData[currentUser]['ip'] ?? 'No data',
    health: _usersJsonData[currentUser]['health'],
    status: _usersJsonData[currentUser]['status'],
    //lastCooncted: _usersJsonData[currentUser]['lastCooncted'],
  );
      print(userStatusData.id);

 // print(userStatusData.name);
}

Future<void> refreshData() async {
  await getNetworkStatusData();
  await getUserStatusData();
  //print(networkStatusData.topSite);
}

Future<void> refreshNetworkData() async {
  await getNetworkStatusData();
}
Future<void> refreshUsersData() async {
  await getUserStatusData();
}


/////////////////////////////////////////
///
////////////////////////
///get the current user data/////

Future<String> getCurrentUser(String deviceId) async {
  return await File('lib/Json/oneDeviceData.json').readAsString();
}

Future<dynamic> fetchCurrentUserData(int index) async {
  String data = await getCurrentUser(_usersJsonData[currentUser]['id']);
  return jsonDecode(data);
  
}
UserFullData userFullData = UserFullData(
  name: 'No data',
  ip: 'No data',
  status: 'No data',
  health: 'No data',
  os: 'No data',
  alerts: Alerts(
    lowAlertsNum: 0,
    mediumAlertsNum: 0,
    highAlertsNum: 0,
    lowAlerts: [],
    mediumAlerts: [],
    highAlerts: [],
  ),
);

Future<UserFullData> getUserFullData() async {
  dynamic _currentUserData = await fetchCurrentUserData(currentUser);
  
  List<Alert> lowAlertsList = [];
  if (_currentUserData['alerts']['low'] != null) {
    lowAlertsList = List<Alert>.from(_currentUserData['alerts']['low']
        .map((alert) => Alert(
          srcIp: alert['src_ip'],
          destIp: alert['dest_ip'],
          logSource: alert['log_source'],
          logDescription: alert['log_description'],
          ruleDescription: alert['rule_description'],
          ruleLevel: alert['rule_level'],
          ruleId: alert['rule_id'],
          ruleGroups: List<String>.from(alert['rule_groups']),
          timestamp: alert['timestamp'],
          fullLog: alert['full_log'],
        )));
  }
  
  List<Alert> mediumAlertsList = [];
  if (_currentUserData['alerts']['medium'] != null) {
    mediumAlertsList = List<Alert>.from(_currentUserData['alerts']['medium']
        .map((alert) => Alert(
          srcIp: alert['src_ip'],
          destIp: alert['dest_ip'],
          logSource: alert['log_source'],
          logDescription: alert['log_description'],
          ruleDescription: alert['rule_description'],
          ruleLevel: alert['rule_level'],
          ruleId: alert['rule_id'],
          ruleGroups: List<String>.from(alert['rule_groups']),
          timestamp: alert['timestamp'],
          fullLog: alert['full_log'],
        )));
  }
  
  List<Alert> highAlertsList = [];
  if (_currentUserData['alerts']['high'] != null) {
    highAlertsList = List<Alert>.from(_currentUserData['alerts']['high']
        .map((alert) => Alert(
          srcIp: alert['src_ip'],
          destIp: alert['dest_ip'],
          logSource: alert['log_source'],
          logDescription: alert['log_description'],
          ruleDescription: alert['rule_description'],
          ruleLevel: alert['rule_level'],
          ruleId: alert['rule_id'],
          ruleGroups: List<String>.from(alert['rule_groups']),
          timestamp: alert['timestamp'],
          fullLog: alert['full_log'],
        )));
  }
  
  return UserFullData(
    name: _currentUserData['name'] ?? 'No data',
    ip: _currentUserData['ip'] ?? 'No data',
    status: _currentUserData['status'] ?? 'No data',
    health: _currentUserData['health'] ?? 'No data',
    os: _currentUserData['os'] ?? 'No data',
    alerts: Alerts(
      lowAlertsNum: _currentUserData['alert_count']['low'] ?? 0,
      mediumAlertsNum: _currentUserData['alert_count']['medium'] ?? 0,
      highAlertsNum: _currentUserData['alert_count']['high'] ?? 0,
      lowAlerts: lowAlertsList,
      mediumAlerts: mediumAlertsList,
      highAlerts: highAlertsList,
    ),
  );
}

class Alert {
  Alert({
    required this.srcIp,
    required this.destIp,
    required this.logSource,
    required this.logDescription,
    required this.ruleDescription,
    required this.ruleLevel,
    required this.ruleId,
    required this.ruleGroups,
    required this.timestamp,
    required this.fullLog,
  });

  final String srcIp;
  final String destIp;
  final String logSource;
  final String logDescription;
  final String ruleDescription;
  final int ruleLevel;
  final String ruleId;
  final List<String> ruleGroups;
  final int timestamp;
  final String fullLog;
}


class Alerts {
  Alerts({
    required this.lowAlertsNum,
    required this.mediumAlertsNum,
    required this.highAlertsNum,
    required this.lowAlerts,
    required this.mediumAlerts,
    required this.highAlerts,
  });

  final int lowAlertsNum;
  final int mediumAlertsNum;
  final int highAlertsNum;
  final List<Alert> lowAlerts;
  final List<Alert> mediumAlerts;
  final List<Alert> highAlerts;
}
class UserFullData {
  UserFullData({
    required this.name,
    required this.ip,
    required this.status,
    required this.health,
    required this.alerts,
    required this.os,

  });

 
  final String name;
  final String ip;
  final String status;
  final String health;
  final Alerts alerts;
  final String os;

}

////////////////////////////////////////////
/////////////////////////////////////
///getWebsites data////////////
class WebsiteModel {
  late String websiteName;
  late int numberOfVisits;
  late bool isBlocked ;
  WebsiteModel(this.websiteName, this.numberOfVisits,this.isBlocked);
}

Future<dynamic> fetchWebSitesData(int numOfWebsites) async {
  //List<dynamic> usersJsonData = [];

  try {
    Response response = await get(Uri.parse('http://10.10.10.2:8000/api/v1/main/top_sites/'+numOfWebsites.toString()));
    if (response.statusCode == 200) {
      String data = response.body;
      websitesJsonData = jsonDecode(data);
    } else {
      throw Exception('Failed to fetch data from the server');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }

  return websitesJsonData;
}

Future<String> getWebsitesViaURL() async {
  Response response = await get(Uri.parse('http://10.10.10.2:8000/api/v1/main/top_sites/30'));
  return  jsonDecode(response.body);
}

dynamic websitesJsonData = [];

Future<void> refreshWebsitesData(int numOfWebsites) async {
  websitesJsonData = await fetchWebSitesData(numOfWebsites);
  print("hetewa");
}