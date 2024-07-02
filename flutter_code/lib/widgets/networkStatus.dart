import 'package:flutter/material.dart';
import 'package:figma/models/statusScreenData.dart';
import 'package:figma/Pages/mainDashboard.dart';
import 'package:flutter/widgets.dart';

//make widget stateful to show data from jsom file
class NetworkStatus extends StatefulWidget {
  final int connectedUsers = 0;
  final String speed = "10Mbps";
  
  @override
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  Color backgroundColor = Colors.transparent;
  late WebsiteModel topSite =WebsiteModel("", 0, false) ;
 @override
  void initState() {
    super.initState();
    getFirstWebsitesData();
    setState(() {
      
    });
    /* print("init state");
    print(websitesJsonData);
    print("init state"); */
  }
  Future<void> getFirstWebsitesData() async {
    await refreshWebsitesData(1);
    
    
    print("init state");
    print(websitesJsonData);
    print("init state");
    setState(() {
     if (websitesJsonData.isNotEmpty) {
  topSite.websiteName = websitesJsonData[0]['name'] ?? "No Data";
} else {
  topSite.websiteName = "No Data";
}

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Top visited site widget

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 10),
            //add png image
MouseRegion(
  onHover: (event) {
    setState(() {
      backgroundColor = Color(0xFF14141F);
    });
  },
  onExit: (event) {
    setState(() {
      backgroundColor = Color(0xFF192740);
    });
  },
  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //shadowColor: Colors.transparent,
                      backgroundColor: backgroundColor,
                      
                    ),
                    
                    onLongPress: () {
                      print(websitesJsonData);
                    },
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => UserStatusDialog(userFullData: userFullData),
                    ),
                    child: 
              Column(
                children: [
                  Image.asset('images/site.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  
                  
                  //SizedBox(height: 0),
                  const Text('Top Site',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  //SizedBox(height: 0),
                  Text(topSite.websiteName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "Poppins",
                        color: Color(0xFF00FFFF),
                      ),
                      overflow: TextOverflow.ellipsis,
                      ),
                ],
              ),
              ),
),
            SizedBox(height: 10),
            const Divider(
                color: Colors.white, thickness: 2, indent: 20, endIndent: 20),
          ],
        ),

        //SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(width: 20),
            //add vertical connected devices widget
            Container(
              width: 100,
              //color: Colors.blue,
              child: Column(
                children: [
                  //SizedBox(height: 10),
                  //add png image
                  Image.asset('images/devices.png',
                      width: 40, height: 40, fit: BoxFit.contain),

                  SizedBox(height: 10),
                  const Text('Devices',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 22),
                  Text("5",
                      style: const TextStyle(
                          fontSize: 27,
                          fontFamily: "Poppins",
                          color: Color(0xFF31FF0F),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              color: Colors.white,
              width: 2,
              height: 190,
            ),
            SizedBox(width: 10),

            //make vertical speed widget
            Container(
              width: 100,
              //color: Colors.blue,
              child: Column(
                children: [
                  //SizedBox(height: 10),
                  //add png image
                  Image.asset('images/speeds.png',
                      width: 40, height: 40, fit: BoxFit.contain),

                  SizedBox(height: 10),
                  const Text('Speed',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 25),
                  Text(networkStatusData.speed,
                      style: const TextStyle(
                          fontSize: 22,
                          fontFamily: "Poppins",
                          color: Color(0xFF31FF0F),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserStatusDialog extends StatefulWidget {
  final UserFullData userFullData;
  UserStatusDialog({required this.userFullData});
  @override
  _UserStatusDialogState createState() => _UserStatusDialogState();
}

class _UserStatusDialogState extends State<UserStatusDialog> {
  // List of websites
  TextStyle textStyle =TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  );
  
  
  @override
  Widget build(BuildContext context) {
    // Function to build the list of websites with block buttons
    

    return AlertDialog(
      // alignment: Alignment(.3, .1),
      backgroundColor: Color(0xFF1E1E2A),
      title: Row(
        children: [
          Text(
            "Top Visited Site",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 850),
          ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
           //print(widget.userFullData.alerts.lowAlerts[0].destIp);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          child: Image.asset('images/close.png',width: 30,height: 30,),
        ),
        ],
      ),

    
      content: SizedBox(
           width: 1000,
           height: 600,
          child: Column(
          children: [
            //make horizontal divider
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.white,
            ),
            
             //Alerts info table
            SizedBox(height: 20),
             Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                color: Color(0xFF2A3E60),
                ),
                width: 1100,
                height: 575,
                child: WebsitesTable(),
              ),
            
           ],
           ),
           ),

    );
  }
}



class WebsitesTable extends StatefulWidget {
 /*  final UserFullData userFullData;
  WebsitesTable({required this.userFullData}); */
  
  @override
  _WebsitesTableState createState() => _WebsitesTableState();
  
}

class _WebsitesTableState extends State<WebsitesTable> {
bool switchValue = false;
late List<WebsiteModel> first30Websites= [] ;

Future<void> getFirstWebsitesData() async {
    await refreshWebsitesData(30);
    print(websitesJsonData);
    setState(() {
      for (int i = 0; i < 30; i++) {
        first30Websites.add(WebsiteModel(websitesJsonData[i]['name'], websitesJsonData[i]['visits'], false));
      }
    });
  }
  
  
  @override
  void initState() {
    super.initState();
    getFirstWebsitesData();
  }
  
  @override
  Widget build(BuildContext context) {
    return 
        Theme(
          data: Theme.of(context).copyWith(
            dataTableTheme: const DataTableThemeData(
              headingRowHeight: 50,
              horizontalMargin: 10,
              columnSpacing: 10,
              dividerThickness: 1,
              decoration: BoxDecoration(
                color: Color(0xFF2A3E60),
               // borderRadius: BorderRadius.circular(20),
              ),
              headingTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              dataTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            
          ),
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              DataTable(columns: const [
                DataColumn(label: Text("Website Name")),
                DataColumn(label: Text("Number of Visits")),
                DataColumn(label: Text("Block/Unblock")),
                
              ], 
              rows: 
               List<DataRow>.generate(first30Websites.length, (index){
                return DataRow(
                  cells: [
                    DataCell(Text(first30Websites[index].websiteName)),
                    DataCell(Text(first30Websites[index].numberOfVisits.toString())),
                    DataCell(Switch(
                      value: first30Websites[index].isBlocked,
                      activeColor: Colors.red,
                      inactiveThumbColor: Colors.green,
                      
                      onChanged: (value) {
                        setState(() {
                          first30Websites[index].isBlocked = value;
                        });
                      },
                    ),
                    )
                  ]

                
                );
              }

           ) 
          
              
           
            
           
           ) ],
                 
                ),
        );
    
  }  
  
}


List<WebsiteModel> websites = [
  WebsiteModel("google.com",1000000, true),
  WebsiteModel("facebook.com",1000000, false),
  WebsiteModel("youtube.com",1000000, false),
  WebsiteModel("twitter.com",1000000, false),
  WebsiteModel("instagram.com",1000000, false),
  WebsiteModel("linkedin.com",1000000, false),


];