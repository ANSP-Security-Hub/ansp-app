import 'package:flutter/material.dart';
import 'package:figma/widgets/networkStatus.dart';
import 'package:figma/models/statusScreenData.dart';
import 'package:figma/widgets/userStatus.dart';
import 'package:figma/widgets/userButton.dart';
import 'package:figma/models/locations.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:figma/models/mapData.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
 
 late List<Widget> positionedWidgets ;
  Future<void> dashboardPageData() async {
  await refreshUsersData();
  await getMapDataForSpecificUser();
  await updateDataSource();
  setState(() {
    statesScreen = 1;
  });
}
/// make  CircularProgressIndicator function 
Future <void> progressIndicator() async {
  showDialog(
    context: 
    context,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },  
  );
  print("progressIndicator");
  await dashboardPageData();

  Navigator.of(context).pop();
} 

Future<void> updateDataSource() async {
  // await  refreshmapData();

    
    print("dataSource updated");
    //print(mapData[0].continent);
    setState(() {
    /*   mapData = <mapModel>[
    mapModel('Jordan', 50),
    mapModel('Africa', 54, ),
    mapModel('Canada', 51, ),
    mapModel('North America', 23, ),
    mapModel('South America', 80, ),
    mapModel('Australia', 14, ),
  ]; */
  //getMapDataForSpecificUser();

    dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    );
    });
  }

  
  late Timer _timer;

   

  @override
  void initState() {
    super.initState();
     getmapData();
     updateDataSource();
    getDevices();
    positionedWidgets = positionedWidgets =
      List.generate(devices.length, // Adjust the number of items as needed
          (index) {
    final double xLocation = locationsData[index][0];
    final double yLocation = locationsData[index][1];

    return UserButton(
        x_location: xLocation,
        y_location: yLocation,
        index: index,
        deviceinfo: devices[index],
        onTap: progressIndicator,
        );
  });
   // refreshmapData();
    refreshData();
    refreshDevices();
    dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    );
    setState(() {
      // refreshDevices();
     });
     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      refreshDevices();
      positionedWidgets.clear();

     
    
      setState(() {
            
        /////////////////////////////////////////////////////////////////////////
        if (devices.length > locationsData.length) {
          throw Exception(
              "Number of devices does not match number of locations");
        }

        positionedWidgets.clear();
        positionedWidgets = List.generate(
            devices.length, // Adjust the number of items as needed

            (index) {
          final double xLocation = locationsData[index][0];
          final double yLocation = locationsData[index][1];
          return UserButton(
              x_location: xLocation,
              y_location: yLocation,
              index: index,
              deviceinfo: devices[index],
              onTap: progressIndicator,);
        });
      });
    }); 
   // refreshmapData();
 
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Future<void> getDevices() async {

    await refreshDevices();
    positionedWidgets.clear();
        positionedWidgets = List.generate(
            devices.length, // Adjust the number of items as needed

            (index) {
          final double xLocation = locationsData[index][0];
          final double yLocation = locationsData[index][1];
          return UserButton(
              x_location: xLocation,
              y_location: yLocation,
              index: index,
              deviceinfo: devices[index],
              onTap: progressIndicator,);
        });
    setState(() {});
  }
  Future<void> _onItemTapped(int index) async {
    await getmapData();
    await updateDataSource();
    setState(() {
      statesScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 720,
      width: 1060,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children: [
          //SizedBox(height: 20), // Optional spacing between rows (or columns
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 350,
                  width: 780,
                  // Set your desired height
                  color: Color(0xFF192740),
                  child: Stack(
                    children: [
                      const Positioned(
                          top: 24,
                          left: 13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '''My Home''',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Akshar",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "last Updated: 02:15 PM",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Akshar",
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )),
                      //add png image
                      Container(
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset('images/topview.png',
                                  width: 760, height: 330, fit: BoxFit.cover),
                            ),
                            ...positionedWidgets,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              //Network status or User status widget
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 350, // Set your desired height
                  width: 260,
                  color: const Color(0xFF192740),

                  child: Center(
                    //make IndexedStack for the network status and user status
                    child: IndexedStack(
                      index: statesScreen,
                      children: [
                        NetworkStatus(),
                        UserStatus(
                          onTap: () => _onItemTapped(0),
                        ),
                        //arrowWidgetthatreturntoNetworkStatus(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //const SettingsPage(),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [SizedBox(
                  height: 360,
                  width: 1060,
                  child: Container(
                    height: 360, // Set your desired height
                    width: 1500,
                    color: const Color(0xFF192740),
                    
                      child: 
                            // and image
                            Container(
                              height: 700,
                              width: 1060,
                  
                                        //color: Color.fromARGB(255, 5, 82, 214),
                                       child: SfMaps(
                                                    layers: [
                                                      MapShapeLayer(
                                                        strokeColor: Color(0xFF9E9E9E),
                                                        color: Color(0xFFFCF8EC),
                                                         bubbleSettings: const MapBubbleSettings(maxRadius: 50, minRadius: 30,color: Color.fromARGB(147, 116, 114, 206),strokeColor: Color.fromARGB(255, 82, 54, 244)),
                                                
                                                        source: dataSource,
                                                
                                                        bubbleTooltipBuilder: (BuildContext context, int index) {
                                       return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text('Country : ' +
                                             mapData[index].continent +
                                             '\nNumber of Connections : ' +
                                             mapData[index].numOfConnections.toStringAsFixed(0),
                                             style: ThemeData().textTheme.caption!
                                                .copyWith(color: ThemeData().colorScheme.surface)),
                                       );
                                                        },
                                                      ),
                                                    ],
                                                                     ),
                                   
                            ),
                      
                    
                  ),
                ),
                ],
            ),
          
    ),
        ],
      ),
    );
  }
}
/* 
class SettingsPage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  final VoidCallback? onDataUpdate;
  const SettingsPage({Key? key, this.onDataUpdate}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
 // _SettingsPage();
  //late List<mapModel> mapData ;
 // late MapShapeSource dataSource;
    @override
void initState() {
  super.initState();

mapData = <mapModel>[
    mapModel('Jordan', 50),
    mapModel('Africa', 54, ),
    mapModel('Europe', 51, ),
    mapModel('North America', 23, ),
    mapModel('South America', 80, ),
    mapModel('Australia', 14, ),
  ]; 
  dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    ); 
  //setState(() {});
}
  
   @override
void dispose() {

  super.dispose();

} 

Future<void> updateDataSource() async {
   await  refreshmapData();
/* mapData = <mapModel>[
    mapModel('Jordan', 50),
    mapModel('Africa', 54, ),
    mapModel('Canada', 51, ),
    mapModel('North America', 23, ),
    mapModel('South America', 80, ),
    mapModel('Australia', 14, ),
  ];*/
    dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    ); 
    print("dataSource updated");
    print(mapData[0].numOfConnections);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return   ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                
                //make evaluated button
               

                SizedBox(
                  height: 360,
                  width: 1060,
                  child: Container(
                    height: 360, // Set your desired height
                    width: 1500,
                    color: const Color(0xFF192740),
                    
                      child: 
                            // and image
                            Container(
                              height: 700,
                              width: 1060,
                  
                                        //color: Color.fromARGB(255, 5, 82, 214),
                                       child: SfMaps(
                                                    layers: [
                                                      MapShapeLayer(
                                                        strokeColor: Color(0xFF9E9E9E),
                                                        color: Color(0xFFFCF8EC),
                                                         bubbleSettings: const MapBubbleSettings(maxRadius: 50, minRadius: 30,color: Color.fromARGB(150, 53, 190, 53),),
                                                
                                                        source: dataSource,
                                                
                                                        bubbleTooltipBuilder: (BuildContext context, int index) {
                                       return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text('Country : ' +
                                             mapData[index].continent +
                                             '\nNumber of Connections : ' +
                                             mapData[index].numOfConnections.toStringAsFixed(0),
                                             style: ThemeData().textTheme.caption!
                                                .copyWith(color: ThemeData().colorScheme.surface)),
                                       );
                                                        },
                                                      ),
                                                    ],
                                                                     ),
                                   
                            ),
                      
                    
                  ),
                ),
                 ElevatedButton(onPressed: updateDataSource
                , child: Text("Refresh Data")),
              ],
            ),
          
    );
  }
}

 */