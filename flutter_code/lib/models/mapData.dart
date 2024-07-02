import 'package:syncfusion_flutter_maps/maps.dart';
import 'dart:io';
import 'dart:convert';
import '../models/statusScreenData.dart';
import '../models/getData.dart';
import 'package:http/http.dart' ;


class mapModel {
  mapModel(this.continent, this.numOfConnections, );

  final String continent;
  final int numOfConnections;

}
//get mapData from json file
List<mapModel> mapData = <mapModel>[
  mapModel("China", 100),
];

late MapShapeSource dataSource = MapShapeSource.asset(
  'images/world_map.json',
  shapeDataField: 'name',
  dataCount: mapData.length,
  primaryValueMapper: (int index) => mapData[index].continent,
  dataLabelMapper: (int index) => mapData[index].numOfConnections.toString(),
);

Future<void> getmapData() async {
  final File file = File('lib/Json/mapData.json');
  //Response response = await get(Uri.parse('http://10.10.10.2:8000/api/v1/map'));
  final String jsonData = await file.readAsString();
  //final String jsonData = response.body;
   final List<mapModel> _mapModel = List<mapModel>.from(
      json.decode(jsonData).map((dynamic model) => mapModel(model['country'] as String, model['total_count'] as int)));
      print("jjjj");
     print (mapData[0].continent);
     mapData = _mapModel;
    /*   dataSource = MapShapeSource.asset(
      'images/world_map.json',
      shapeDataField: 'name',
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].continent,
      dataLabelMapper: (int index) => mapData[index].numOfConnections.toString(),
    ); */
     
 
}
Future<void> getMapDataForSpecificUser() async
{
  //dynamic users = fetchConnectedDevisesData();
  //make http request data using the ip of the user
  //String _Ip = users[currentUser]['ip'];
  //http request to get the data of the user

   /* if (currentUser == 0) {
    mapData = [
      mapModel("China", 100),
    ];
  } else if (currentUser == 1) {
    mapData = [
      mapModel("India", 100),
    ];
  } else if (currentUser == 2) {

    mapData = [
      mapModel("United States of America", 100),
    ];
  } else if (currentUser == 3) {
    mapData = [
      mapModel("Brazil", 100),
    ];
  } else if (currentUser == 4) {
    mapData = [
      mapModel("Russia", 100),
    ];
  } else if (currentUser == 5) {
    mapData = [
      mapModel("France", 100),
    ];
  } else if (currentUser == 6) {
    mapData = [
      mapModel("Germany", 100),
    ];
  } else if (currentUser == 7) {
    mapData = [
      mapModel("United Kingdom", 100),
    ];
  } else if (currentUser == 8) {
    mapData = [
      mapModel("Italy", 100),
    ];
  } else if (currentUser == 9) {
    mapData = [
      mapModel("Spain", 100),
    ];
  } else if (currentUser == 10) {
    mapData = [
      mapModel("Turkey", 100),
    ];
  } else if (currentUser == 11) {
    mapData = [
      mapModel("Poland", 100),
    ];
  } else if (currentUser == 12) {
    mapData = [
      mapModel("Netherlands", 100),
    ];
  } else if (currentUser == 13) {
    mapData = [
      mapModel("Belgium", 100),
    ];
  }  */
 // await getmapData();
  if(currentUser == -1)
  { 
    mapModel m = await mapModel("Jordan", 5);
    mapData.clear();
    mapData.add(m);
  }else  if(currentUser == 0)
  { 
    mapModel m = await mapModel("Jordan", 5);
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 1)
  {
    mapModel m = await mapModel("Armenia", 3);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==2)
  {
    mapModel m = mapModel("United Kingdom", 6);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==3)
  {
    mapModel m = mapModel("Egypt", 3);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==4)
  {
    mapModel m = mapModel("South Korea", 4);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==5)
  {
    mapModel m = mapModel("Indonesia", 5);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==6)
  {
    mapModel m = mapModel("Germany", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==7)
  {
    mapModel m = mapModel("United Kingdom", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==8)
  {
    mapModel m = mapModel("Italy", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==9)
  {
    mapModel m = mapModel("Spain", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==10)
  {
    mapModel m = mapModel("Turkey", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==11)
  {
    mapModel m = mapModel("Poland", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==12)
  {
    mapModel m = mapModel("Netherlands", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==13)
  {
    mapModel m = mapModel("Belgium", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==14)
  {
    mapModel m = mapModel("Sweden", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==15)
  {
    mapModel m = mapModel("Switzerland", 100);
    mapData.clear();
    mapData.add(m);
  }
  else if(currentUser ==16)
  {
    mapModel m = mapModel("Austria", 100);
    mapData.clear();
    mapData.add(m);
  }



/* 
  }else if(currentUser == 1)
  {
    mapModel m = mapData[1];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 2)
  {
    mapModel m = mapData[2];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 3)
  {
    mapModel m = mapData[3];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 4)
  {
    mapModel m = mapData[4];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 5)
  {
    mapModel m = mapData[5];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 6)
  {
    mapModel m = mapData[6];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 7)
  {
    mapModel m = mapData[7];
    mapData.clear();
    mapData.add(m);

  }else if(currentUser == 8)
  {
    mapModel m = mapData[8];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 9)
  {
    mapModel m = mapData[9];
    mapData.clear();
    mapData.add(m);
  }else if(currentUser == 10)
  {
    mapModel m = mapData[10];
    mapData.clear();
    mapData.add(m);
  } */
}

Future<void> refreshmapData() async {
  await getmapData();
}



