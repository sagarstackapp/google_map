import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_map/common/constant/colors.dart';
import 'package:google_map/common/constant/images.dart';
import 'package:google_map/common/constant/string.dart';
import 'package:google_map/common/methods/methods.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GoogleMapController googleMapController;
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
  MapType currentType = MapType.normal;
  List<Marker> markers = [];
  String searchAddress;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  @override
  void initState() {
    customPinMaker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            mapType: currentType,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLngs.NanaVarachha,
              zoom: 10,
              tilt: 20,
            ),
            onTap: handleTap,
            markers: Set.from(markers),
          ),
          Positioned(
            top: 20,
            left: 30,
            right: 30,
            child: searchAddressField(
              searchAdd,
              (value) {
                setState(() {
                  searchAddress = value;
                });
              },
              currentLocationController,
              'Choose start location',
              Icons.search,
            ),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: Column(
              children: [
                mapIcon(onMapTypeChange, Icons.map, 'Map'),
                SizedBox(height: 16),
                mapIcon(onAddLocation, Icons.add_location, 'Add Location'),
                SizedBox(height: 16),
                mapIcon(goToRoutePage, Icons.alt_route, 'Get Route')
              ],
            ),
          ),
        ],
      ),

    );
  }

  Future<void> onMapTypeChange() async {
    setState(() {
      currentType =
          currentType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  void customPinMaker() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 25),
      ImageResources.BlackMarker,
    );
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 25),
      ImageResources.RedMarker,
    );
  }

  void onAddLocation() async {
    final location = Coordinations.nanaVarachha;
    var locationMap =
        await Geocoder.local.findAddressesFromCoordinates(location);
    print('Location Name : ${locationMap.first.toMap()}');
    var locality = '${locationMap.first.locality}';
    var subLocality = '${locationMap.first.subLocality}';
    print('locality Name : $locality');
    print('subLocality Name : $subLocality');
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(Coordinations.nanaVarachha.toString()),
          position: LatLngs.NanaVarachha,
          icon: destinationIcon,
          infoWindow: InfoWindow(
            title: subLocality,
            snippet: locality,
          ),
        ),
      );
    });
  }

  handleTap(LatLng argument) async {
    print('Handle tap : $argument');
    final location = new Coordinates(argument.latitude, argument.longitude);
    var locationMap =
        await Geocoder.local.findAddressesFromCoordinates(location);
    print('Location Name : ${locationMap.first.toMap()}');
    var locality = '${locationMap.first.locality}';
    var subLocality = '${locationMap.first.subLocality}';
    print('locality Name : $locality');
    print('subLocality Name : $subLocality');
    setState(() {
      // markers = [];
      markers.add(
        Marker(
          markerId: MarkerId(argument.toString()),
          icon: sourceIcon,
          position: argument,
          draggable: true,
          infoWindow: InfoWindow(
            title: subLocality,
            snippet: locality,
          ),
          onDragEnd: (dragEndPoint) {
            print(dragEndPoint);
          },
        ),
      );
    });
  }

  searchAdd() async {
    print('Searched for : $searchAddress');
    if (currentLocationController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter address',
        textColor: ColorResources.White,
        backgroundColor: ColorResources.Red,
      );
    } else {
      var address = await Geocoder.local.findAddressesFromQuery(searchAddress);
      var addressMap = address.first.toMap();
      var coordinates = addressMap['coordinates'];
      print('Current searched address coordinates : $coordinates');
      var latitude = coordinates['latitude'];
      var longitude = coordinates['longitude'];
      print('Searched address Latitude : $latitude');
      print('Searched address longitude : $longitude');
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 10,
          ),
        ),
      );
    }
  }

  onMapCreated(controller) {
    setState(() {
      googleMapController = controller;
    });
  }

  goToRoutePage() {
    goRoute(context);
  }
}
