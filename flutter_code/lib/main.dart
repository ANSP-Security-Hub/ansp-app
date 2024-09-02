import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'Pages/mainDashboard.dart';
import 'Pages/wazuhManger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:figma/models/mapData.dart';
void main() {
  runApp(DashboardPageWidget());
}

class DashboardPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            const Color(0xFF14141F), // Set the background color
      ),
      home: MyHomePage(), // Setting HomePage as the initial route
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<MyHomePage> {
  int selectedIndex = 0; // Initially no item is selected

  TextStyle myTextStyle = const TextStyle(
    fontFamily: 'Readex Pro',
    color: Colors.white, // Default color
    letterSpacing: 0,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold widget for the home page

      body: Stack(
        children: [
          //logo
          Align(
            alignment: AlignmentDirectional(-0.93, -0.83),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'images/logo.png',
                width: 125,
                height: 125,
                fit: BoxFit.contain,
              ),
            ),
          ),

          //username
          const Align(
            alignment: AlignmentDirectional(-0.92, -0.5),
            child: Text(
              'Suhaib',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Color(0xFFE5E5E5),
                fontSize: 37,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //User email
          const Align(
            alignment: AlignmentDirectional(-0.918, -0.39),
            child: Text(
              'suhaib@fake.com',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Color(0xFFE5E5E5),
                fontSize: 20,
                letterSpacing: 0,
              ),
            ),
          ),

          //Pages list
          Align(
            alignment: const AlignmentDirectional(-0.92, 0.10),
            child: Container(
                width: 203,
                height: 300,
                decoration: BoxDecoration(),
                child: ListView(
                  children: [
                    buildListTile('Dashboard', 0),
                     buildListTile('Wazuh', 1),
                    buildListTile('OPNsense', 2),
                    buildListTile('Pi-hole', 3),
                    buildListTile('Ntopng', 4),
                    buildListTile('Settings', 5),
                   ],
                )),
          ),

          // Milkey container
          Align(
            alignment: const AlignmentDirectional(0.9, 0),
            child: Container(
                width: 1100,
                height: 760,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCF8EC),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: IndexedStack(
                  // IndexedStack widget to show the selected page
                  index: selectedIndex,
                  children: [
                    DashboardPPage(),
                     const WazuhManger(),
                    //emptypages
                    /* const Center(
                      child: Text('This is the OPNsense Page'),
                    ), */
                    /* const Center(
                      child: Text('This is the Pi-hole Page'),
                    ), */
                    /* const Center(
                      child: Text('This is the Ntopng Page'),
                    ), */
                    OPNsense(),
                    PiHole(),
                    Ntopng(),
                    SettingsPage(), 
                  ],
                )),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, int index) {
    return ListTile(
      title: Text(
        title,
        style: index == selectedIndex
            ? myTextStyle.copyWith(color: Colors.white)
            : myTextStyle.copyWith(color: const Color(0xFF57636C)),
      ),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}

////////////////////
///
class DashboardPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DashboardPage(),
    );
  }
}

class WazuhPage extends StatefulWidget {
  @override
  _WazuhPageState createState() => _WazuhPageState();
}

class _WazuhPageState extends State<WazuhPage> {
  String src = 'https://wazuh.com/';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40), // Rounded edges
      child: Container(
        height:
            MediaQuery.of(context).size.height, // Adjust the height as needed
        width: MediaQuery.of(context).size.width, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded edges
          color: const Color(0xFFFCF8EC),
        ),
        child: Column(
          children: [
            Expanded(
              child: EasyWebView(
                src: src,
                //isHtml: false,
                isMarkdown: false,
                convertToWidgets: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ElsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Else Page'),
    );
  }
}

class AnotherElsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Another Else Page'),
    );
  }
}

//OPNsense page
class OPNsense extends StatefulWidget {
  @override
  _OPNsensePageState createState() => _OPNsensePageState();
}

class _OPNsensePageState extends State<OPNsense> {
  String src = 'https://10.10.10.1';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40), // Rounded edges
      child: Container(
        height:
            MediaQuery.of(context).size.height, // Adjust the height as needed
        width: MediaQuery.of(context).size.width, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded edges
          color: Color(0xFFFCF8EC),
        ),
        child: Column(
          children: [
            Expanded(
              child: EasyWebView(
                src: src,
                //isHtml: false,
                isMarkdown: false,
                convertToWidgets: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Pi-hole page

class PiHole extends StatefulWidget {
  @override
  _PiHolePageState createState() => _PiHolePageState();
}

class _PiHolePageState extends State<PiHole> {
  String src = 'http://10.10.10.2';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40), // Rounded edges
      child: Container(
        height:
            MediaQuery.of(context).size.height, // Adjust the height as needed
        width: MediaQuery.of(context).size.width, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded edges
          color: const Color(0xFFFCF8EC),
        ),
        child: Column(
          children: [
            Expanded(
              child: EasyWebView(
                src: src,
                //isHtml: false,
                isMarkdown: false,
                convertToWidgets: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ntopng extends StatefulWidget {
  @override
  _NtopngPageState createState() => _NtopngPageState();
}

class _NtopngPageState extends State<Ntopng> {
  String src = 'http://10.10.10.1:3000';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40), // Rounded edges
      child: Container(
        height:
            MediaQuery.of(context).size.height, // Adjust the height as needed
        width: MediaQuery.of(context).size.width, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded edges
          color: const Color(0xFFFCF8EC),
        ),
        child: Column(
          children: [
            Expanded(
              child: EasyWebView(
                src: src,
                //isHtml: false,
                isMarkdown: false,
                convertToWidgets: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  _SettingsPage();
  late MapShapeSource dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    );
    @override
void initState() {
  super.initState();
 // refreshmapData();
/*   data = <Model>[
    Model('Asia', 50, '44,579,000 sq. km.'),
    Model('Africa', 54, '30,370,000 sq. km.'),
    Model('Europe', 51, '10,180,000 sq. km.'),
    Model('North America', 23, '24,709,000 sq. km.'),
    Model('South America', 80, '17,840,000 sq. km.'),
    Model('Australia', 14, '8,600,000 sq. km.'),
  ];
 */
 mapData = <mapModel>[
    mapModel('Jordan', 50),
    mapModel('Africa', 54, ),
    mapModel('Europe', 51, ),
    mapModel('North America', 23, ),
    mapModel('South America', 80, ),
    mapModel('Australia', 14, ),
  ]; 
  updateDataSource();
 /*  //make function that make data update when click on button "Click me!"
  void updateDataSource() {
    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].continent,
      bubbleSizeMapper: (int index) => data[index].countriesCount,
    );
    setState(() {});
  } */
}
  void updateDataSource() async {
   await  refreshmapData();
    /* data = <Model>[
    Model('Jordan', 3000, '3000'),
    Model('Canada', 1000, '1000'),
    Model('Europe', 51, '10,180,000 sq. km.'),
    Model('North America', 23, '24,709,000 sq. km.'),
    Model('South America',100, '17,840,000 sq. km.'),
    Model('Australia', 14, '8,600,000 sq. km.'),
  ]; */
    dataSource = MapShapeSource.asset(
      "images/world_map.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      bubbleSizeMapper: (int index) => mapData[index].numOfConnections.toDouble(),
    );
    setState(() {});
  }
  @override
void dispose() {

  super.dispose();

}
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 370, // Set your desired height
              width: 1060,
              color: const Color(0xFF192740),
              
                child: Center(
                  child:
                      // and image
                      Container(
                        height: 320,
                        width: 1060,
                        child: Column(
                          children: [
                           
                               SfMaps(
                                            layers: [
                                              MapShapeLayer(
                                                strokeColor: Colors.grey,
                                                color: Colors.grey,
                                                 bubbleSettings: MapBubbleSettings(maxRadius: 50, minRadius: 30),
                                        
                                                source: dataSource,
                                        
                                                bubbleTooltipBuilder: (BuildContext context, int index) {
                               return Padding(
                                  padding: EdgeInsets.all(10),
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
                             Text('World Map',
                                style: ThemeData().textTheme.headline6!
                                    .copyWith(color: ThemeData().colorScheme.surface)),
                          ],
                        ),
                      ),
                ),
              
            ),
          ),
    );
  }
}