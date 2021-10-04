import 'package:flutter/material.dart';
import 'package:google_map/pages/route_draw_screen/route_draw_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: RouteDrawScreen(),
    );
  }
}
