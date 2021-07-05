import 'package:flutter/material.dart';
import 'package:google_map/common/constant/string.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/map_polyline_draw.dart';

class Routes extends StatefulWidget {
  const Routes({Key key}) : super(key: key);

  @override
  RoutesState createState() => RoutesState();
}

String searchAddress;

class RoutesState extends State<Routes> {

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return Scaffold(
      appBar: topAppBar(),
      body: Stack(
        children: [
          MapPolyLineDraw(
            apiKey: StringResources.AndroidAPIKey,
            firstPoint: MapPoint(22.0225, 72.5714),
            secondPoint: MapPoint(23.0225, 72.5714),
            mapTypes: MapTypes.hybrid,
            lineWidth: 10,
            mapZoom: 20,
          ),
        ],
      ),
    );
  }
}
