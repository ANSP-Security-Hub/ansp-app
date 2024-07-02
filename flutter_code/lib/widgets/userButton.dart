//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:figma/models/statusScreenData.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import 'package:figma/models/locations.dart';

class UserButton extends StatefulWidget {
  final double x_location;
  final double y_location;
  final int index;
   Devices deviceinfo  ;
  final VoidCallback onTap;
  UserButton({required this.x_location, required this.y_location,required this.index,required this.deviceinfo  , required this.onTap });
  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {


 @override
  void initState() {
    super.initState();
  }
  //use current user to show the user data when the user click on the button
  @override
  void dispose() {
    super.dispose();
  }
  Future<void> refreshData() async {
    await setCurrentUser(widget.index);
    print(currentUser);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {

  return 
  Positioned(
      top: widget.y_location,
      left: widget.x_location,
      child: ElevatedButton(
        onPressed: () {
        refreshData();
        widget.onTap();
          setState(() {
           
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
         
          padding: EdgeInsets.zero,
        ), 
        child:Container(
    width: 55,
    height: 55,
    //use boxshadow to make circle shadow
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: 
          //change color of the shadow based on the health of the user

          widget.deviceinfo.health == "healthy" ? Colors.green : widget.deviceinfo.health == "warning" ? Colors.yellow : widget.deviceinfo.health == "critical" ? Colors.red : Colors.grey,
        ),
        BoxShadow(
          color: Color(0xFF192740).withOpacity(1),
          spreadRadius:3,
          blurRadius: 15,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
    
    child:Center(child: SvgPicture.asset('images/PC.svg', width: 30, height: 30, fit: BoxFit.cover, color: Colors.white,)),
      )
      )
      );
}
}