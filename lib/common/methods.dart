import 'package:geocoder/geocoder.dart';

getLatLngByAddress(String address) async {
  var location = await Geocoder.local.findAddressesFromQuery(address);
  if (location == null || location.length == 0) {
    return null;
  }
  var locationMap = location.first;
  print('LocationMap --> ${locationMap.toMap()}');
  return locationMap.coordinates;
}
