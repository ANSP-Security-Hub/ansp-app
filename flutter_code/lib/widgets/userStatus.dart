import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma/models/statusScreenData.dart';
import 'package:figma/Pages/mainDashboard.dart';

//make widget stateful to show data from jsom file
class UserStatus extends StatefulWidget {
  final String name = "Khalid Jomkeh";
  final String ip = "192.168.1.152";
  final int id = 1;
  final VoidCallback onTap;
  UserStatus({required this.onTap});

  @override
  _UserStatusScreen createState() => _UserStatusScreen();
}

class _UserStatusScreen extends State<UserStatus> {
  UserFullData userFullData = 
      UserFullData(
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

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
    refreshData();
  }

  Future<void> refreshData() async {
    await getUserStatusData();
    UserFullData newData = await getUserFullData();
    
    setState(() {
      userFullData = newData;
  });
  print("new data");
    print(userFullData.ip);
    print("new data");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 16),
          Container(
            // color: Colors.blue,
            width: 229,
            height: 100,

            child: Stack(
              children: [
                //make arrow icon
                Align(
                  alignment: Alignment(-1.3, -1),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onTap();
                      refreshData();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFCF8EC),
                      size: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -.0),
                  child: Container(
                    //alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFFCF8EC),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.id.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(width: 30),

          Text(
            userStatusData.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            userStatusData.ip,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          //add row with two icons
          SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 15),

              //add svg image
              SvgPicture.asset(
                'images/heart_beat.svg',
                color: userStatusData.health == 'healthy'
                    ? Colors.green
                    : userStatusData.health == 'warning'
                        ? Colors.yellow
                        : Colors.red,
                width: 70,
                height: 70,
              ),
              //add prgress line

              Container(
                width: 130,
                height: 70,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, -0.3),
                      child: Text(
                        userStatusData.health,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //make progress line
                    Align(
                      alignment: Alignment(0, 0.5),
                      child: Container(
                        width: 130,
                        height: 3,
                        color: userStatusData.health == 'healthy'
                            ? Colors.green
                            : userStatusData.health == 'warning'
                                ? Colors.yellow
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          //make divider
          Container(
            width: 220,
            height: 2,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFCF8EC),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              await refreshData();
              setState(() {
                
              });
              showDialog(context: context,
               builder: (BuildContext context) {
                 return UserStatusDialog(userFullData: userFullData);
               });
            },
            child: Text(
              "more",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Arial",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* 
//make dialog to show user status
void showUserStatus(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment(.4, .25),
        backgroundColor: Color(0xFF1E1E2A),
        content: Stack(
          children: [
            Text(
              "User Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          //make list of wibsites names and beside each one make switch button to Block or unblock


        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
 */
// Define a class to hold website data
class Website {
  final String name;
  bool isBlocked;

  Website(this.name, this.isBlocked);
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
  List<Website> websites = [
    Website("Google.com", false),
    Website("facebook.com", true),
    Website("youtube.com", false),
  ];
  
  @override
  Widget build(BuildContext context) {
    // Function to build the list of websites with block buttons
    /* Widget buildWebsiteList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: websites.map((website) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      website.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Toggle the blocked status of the website
                        website.isBlocked = !website.isBlocked;
                        // You can add your logic here to handle blocking/unblocking
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          website.isBlocked ? Colors.red : Colors.green,
                      alignment: Alignment.center,
                    ),
                    child: Text(
                      website.isBlocked ? "Unblock" : "Block",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          );
        }).toList(),
      );
    } */

    return AlertDialog(
      // alignment: Alignment(.3, .1),
      backgroundColor: Color(0xFF1E1E2A),
      title: Row(
        children: [
          Text(
            "User Info",
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
            print(widget.userFullData.alerts.lowAlerts[0].destIp);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          child: Image.asset('images/close.png',width: 30,height: 30,),
        ),
        ],
      ),

      //content
      /* content: SizedBox(
        width: 400,
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Top Accessed Websites",
                  style: TextStyle(
                    color: Color(0xFF00FF6A),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              buildWebsiteList(),
            ],
          ),
        ),
      ), */

      content: SizedBox(
           width: 1000,
           height: 600,
          child: Stack(
          children: [
            //make horizontal divider
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment(-0.9, -.8),
              child: Container(
                //color: Colors.white,
                width:200,
                height: 300,
                child: Column(
                  children: [
                    //SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFCF8EC),
                      ),
                      width: 188,
                      height: 156,
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                
                    /*Replace with Json Data */
                    Text(
                      widget.userFullData.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.userFullData.health,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
           Align(
            alignment: Alignment(0.8,-.6),
            child: Container(
              width: 700,
              height: 300,
              //color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 200,
                   // height: 200,
                    //color: Colors.black,
                    child: Column(children: [
                      //make list of text
                      SizedBox(height: 10),
                      Text(
                        "Name",
                        style: textStyle,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "IP",
                        style: textStyle,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "OS Type",
                        style: textStyle,
                      ),
                      SizedBox(height: 45),
                      Text(
                        "Alerts",
                        style:textStyle,
                      )
                    
                    
                    ],),
                  ),
                  Center(
                    //width: 400,
                    //height: 200,
                    //color: Colors.black,
                    child: Column(children: [
                     //make rectangle with carved corners
                      infoRectangle(widget.userFullData.name),
                      SizedBox(height: 20),
                      infoRectangle(widget.userFullData.ip),
                      SizedBox(height: 20),
                      infoRectangle(widget.userFullData.os),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          alertRectangle("Low",widget.userFullData.alerts.lowAlertsNum,Color(0xFF83C378)),
                          SizedBox(width: 20),
                          alertRectangle("Medium",widget.userFullData.alerts.mediumAlertsNum,Color(0xFFC3BC78)),
                          SizedBox(width: 20),
                          alertRectangle("High",widget.userFullData.alerts.highAlertsNum,Color(0xFFC37878)),
                          
                        ])
                      
                      ]
                      )
                  )
                  
                ],//row
              ),
            )
           ),
            //Alerts info table
            Align(
              alignment: Alignment(-0.8, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                color: Color(0xFF2A3E60),
                ),
                width: 1000,
                height: 250,
                child: AlertTable(userFullData: widget.userFullData,),
              ),
            )
           ],
           ),
           ),
/* 
       actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(100, 197, 6, 6),
            elevation: 0,
          ),
          child: Text(
            "Close",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
       ], */
    );
  }
}

// Function to show user status dialog
void showUserStatus(UserFullData userFullData, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UserStatusDialog(userFullData: userFullData);
    },
  );
}



Widget infoRectangle(String text)
{
  return Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0XFF9F9999),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              " "+text,
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),),
                        )
                           );
}

//make alert rectangle take the text and the color
Widget alertRectangle(String type,int number,Color color)
{
  return Container(
                        width: 120,
                        height: 55,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                  number.toString(),
                                  style:TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                  ),),

                               Text(
                                type,
                                style:TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                ),
                               )   
                            ],
                          ),
                        )
                           );
}

//table 
/* class TableData extends DataTableSource {
  @override
  int get rowCount => 3;
  /* List<AlertModel> alerts = [
    AlertModel("Firewall", "Firewall is disabled", "High"),
    AlertModel("Antivirus", "Antivirus is disabled", "Medium"),
    AlertModel("VPN", "VPN is disabled", "Low"),
  ]; */
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(alerts[index].alertSource)),
        DataCell(Text(alerts[index].description)),
        DataCell(Text(alerts[index].alertLevel)),
      ],
    );

  }
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;

        }
       */

class AlertTable extends StatefulWidget {
  final UserFullData userFullData;
  AlertTable({required this.userFullData});
  @override
  _AlertTableState createState() => _AlertTableState();
  
}

class _AlertTableState extends State<AlertTable> {

  List<AlertModel> lowAlerts = [];
  List<AlertModel> mediumAlerts = [];
  List<AlertModel> highAlerts = [];
  void extractAlerts()
  {  //print("here");
     //print( widget.userFullData.ip);
    for (int i = 0; i < widget.userFullData.alerts.lowAlertsNum; i++) {
      print(widget.userFullData.alerts.lowAlerts[i].srcIp);
      lowAlerts.add(AlertModel(
        widget.userFullData.alerts.lowAlerts[i].logSource,
        widget.userFullData.alerts.lowAlerts[i].logDescription,
        'Low',
      ));
    }
    for (int i = 0; i < widget.userFullData.alerts.mediumAlertsNum; i++) {
      mediumAlerts.add(AlertModel(
        widget.userFullData.alerts.mediumAlerts[i].logSource,
        widget.userFullData.alerts.mediumAlerts[i].logDescription,
        'Medium',
      ));
    }
    for (int i = 0; i < widget.userFullData.alerts.highAlertsNum; i++) {
      highAlerts.add(AlertModel(
        widget.userFullData.alerts.highAlerts[i].logSource,
        widget.userFullData.alerts.highAlerts[i].logDescription,
        'High',
      ));
    }


  }
  @override
  void initState() {
    super.initState();
    
    extractAlerts();
  }
  /* //int get rowCount => 3;
  List<AlertModel> alerts = [
    AlertModel("Firewall", "Firewall is disabled", "High"),
    AlertModel("Antivirus", "Antivirus is disabled", "Medium"),
    AlertModel("VPN", "VPN is disabled", "Low"),
  ];
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(alerts[index].alertSource)),
        DataCell(Text(alerts[index].description)),
        DataCell(Text(alerts[index].alertLevel)),
      ],
    );
  }

 /*  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
   */ */
   /* final TableData alerts = TableData(); */
  @override
  Widget build(BuildContext context) {
    return 
        Theme(
          data: Theme.of(context).copyWith(
            dataTableTheme: DataTableThemeData(
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
              DataTable(columns: [
                DataColumn(label: Text("Alert Source")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Alert Level")),
              ], 
              rows: 
               /* List<DataRow>.generate(alerts.length, (index){
                return DataRow(
                  cells: [
                    DataCell(Text(alerts[index].alertSource)),
                    DataCell(Text(alerts[index].description)),
                    DataCell(Text(alerts[index].alertLevel,style: TextStyle(color: _getColorForAlertLevel(alerts[index].alertLevel)))),
                  ]

                  /* ,color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  // Set color based on alert level
                  switch (alerts[index].alertLevel.toLowerCase()) {
                    case 'high':
                      return Colors.red;
                    case 'medium':
                      return Colors.orange;
                    case 'low':
                      return Colors.green;
                    default:
                      return Colors.transparent;
                  }}), */
                );
              }

           ) + */
           List<DataRow>.generate(lowAlerts.length, (index){
                return DataRow(
                  cells: [
                    DataCell(Text(lowAlerts[index].alertSource)),
                    DataCell(Text(lowAlerts[index].description)),
                    DataCell(Text(lowAlerts[index].alertLevel,style: TextStyle(color: _getColorForAlertLevel(lowAlerts[index].alertLevel)))),
                  ]
                );
              }
           )
            +
            List<DataRow>.generate(mediumAlerts.length, (index){
                return DataRow(
                  cells: [
                    DataCell(Text(mediumAlerts[index].alertSource)),
                    DataCell(Text(mediumAlerts[index].description)),
                    DataCell(Text(mediumAlerts[index].alertLevel,style: TextStyle(color: _getColorForAlertLevel(mediumAlerts[index].alertLevel)))),
                  ]
                );
              })
            +
            List<DataRow>.generate(highAlerts.length, (index){
                return DataRow(
                  cells: [
                    DataCell(Text(highAlerts[index].alertSource)),
                    DataCell(Text(highAlerts[index].description)),
                    DataCell(Text(highAlerts[index].alertLevel,style: TextStyle(color: _getColorForAlertLevel(highAlerts[index].alertLevel)))),
                  ]
                );
              })
           
            
           
           ) ],
                 
                ),
        );
    
  }  
  Color _getColorForAlertLevel(String level) {
    switch (level) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.yellow;
      case 'Low':
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}

class AlertModel {
  final String alertSource;
  final String description;
  final String alertLevel;

  AlertModel(this.alertSource, this.description, this.alertLevel);
}
List<AlertModel> alerts = [
  AlertModel('Source A', 'Description A', 'High'),
  AlertModel('Source B', 'Description B', 'Low'),
  AlertModel('Source C', 'Descripkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkktion C', 'Medium'),
  AlertModel('Source D', 'Description D', 'High'),
  AlertModel('Source E', 'Description E', 'Low'),
  AlertModel('Source F', 'Description F', 'Medium'),
  AlertModel('Source G', 'Description G', 'High'),
];