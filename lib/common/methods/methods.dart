import 'package:flutter/material.dart';
import 'package:google_map/pages/route/route.dart';

goRoute(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Routes(),
    ),
  );
}
