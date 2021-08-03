import 'package:flutter/material.dart';
import 'package:google_map/common/constant/string.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_map/pages/live_route/source_screen/source_screen.dart';
import 'package:google_map/service/suggestion_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Routes extends StatefulWidget {
  @override
  RoutesState createState() => RoutesState();
}

class RoutesState extends State<Routes> {
  GoogleMapController googleMapController;
  TextEditingController controller = TextEditingController();
  double lat = 21.2300;
  double long = 72.9009;

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long) ?? LatLngs.NanaVarachha,
              zoom: 10,
              tilt: 20,
            ),
          ),
          searchLocationField(
            controller: controller,
            readOnly: true,
            onTap: () async {
              final Suggestions result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SourceScreen()));
              print('Result -->${result.desc}');
              print('Result -->${result.lat} ${result.long}');
              controller.text = result.desc ?? '';
              lat = result.lat ?? '';
              long = result.long ?? '';
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  onMapCreated(controller) {
    setState(() {
      googleMapController = controller;
    });
  }

  sourceLocation(TextEditingController controller) async {
    final Suggestions result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SourceScreen(),
        ));
    print('Result -->${result.desc}');
    controller.text = result.desc ?? '';
  }
}
