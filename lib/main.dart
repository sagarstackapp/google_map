import 'package:flutter/material.dart';
import 'package:google_map/pages/home/home.dart';
import 'package:google_map/pages/live_route/route_home_screen/route_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: HomePage(),
      home: Routes(),
    );
  }
}
