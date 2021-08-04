import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_map/common/constant/colors.dart';
import 'package:google_map/common/methods.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_map/pages/route_draw_screen/route_draw_screen.dart';
import 'package:google_map/pages/source_screen/source_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GoogleMapController googleMapController;
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  Coordinates sourceCoordinates;
  Coordinates destinationCoordinates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.White,
      appBar: topAppBar(context),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 280,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: ColorResources.Blue,
            border: Border.all(color: ColorResources.LightBlue, width: 4),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // shrinkWrap: true,
            children: [
              searchLocationField(
                controller: sourceController,
                readOnly: true,
                hint: 'Source location',
                onTap: () async {
                  final Suggestions result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SourceScreen()));
                  print('Result --> ${result.desc}');
                  print('Result --> ${result.lat} ${result.long}');
                  sourceController.text = result.desc ?? '';
                  sourceCoordinates =
                      await getLatLngByAddress(sourceController.text);
                  setState(() {});
                },
              ),
              searchLocationField(
                controller: destinationController,
                readOnly: true,
                hint: 'Destination location',
                onTap: () async {
                  final Suggestions destination = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SourceScreen()));
                  print('Result --> ${destination.desc}');
                  print('Result --> ${destination.lat} ${destination.long}');
                  destinationController.text = destination.desc ?? '';
                  destinationCoordinates =
                      await getLatLngByAddress(destinationController.text);
                  setState(() {});
                },
              ),
              SizedBox(height: 30),
              commonElevatedButton(
                onPressed: getDirection,
                text: 'Get Direction',
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  getDirection() {
    if (sourceController.text.length == 0) {
      Fluttertoast.showToast(
        msg: 'Please select source location',
        textColor: ColorResources.White,
        backgroundColor: ColorResources.Red,
      );
    } else if (destinationController.text.length == 0) {
      Fluttertoast.showToast(
        msg: 'Please select destination location',
        textColor: ColorResources.White,
        backgroundColor: ColorResources.Red,
      );
    } else if (sourceController.text == destinationController.text) {
      Fluttertoast.showToast(
        msg: 'Source and Destination can\'t be same',
        textColor: ColorResources.White,
        backgroundColor: ColorResources.Red,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RouteDrawScreen(
            source: sourceCoordinates,
            destination: destinationCoordinates,
          ),
        ),
      );
    }
  }
}
