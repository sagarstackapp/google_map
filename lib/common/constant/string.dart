import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StringResources {
  static const String AndroidAPIKey = 'AIzaSyAYF8jW8dhujXmWMUonN7-pcg94goP-G8M';
  static const String IosAPIKey = 'AIzaSyC5JZ8C5KWEecGyIRTJfhRee3lGZRk57fo';
}

class LatLngs {
  // ================== Nana Varachha ================== //
  static const LatLng NanaVarachha = const LatLng(21.2300, 72.9009);
  static const LatLng Ahmedabad = const LatLng(23.0225, 72.5714);
}

class Coordinations {
  static var nanaVarachha = Coordinates(21.2300, 72.9009);
  static var ahmedabad = Coordinates(23.0225, 72.5714);
}
