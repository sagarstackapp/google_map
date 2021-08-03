import 'package:flutter/material.dart';
import 'package:google_map/pages/live_route/route_home_screen/route_home_screen.dart';

goRoute(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Routes(),
    ),
  );
}
