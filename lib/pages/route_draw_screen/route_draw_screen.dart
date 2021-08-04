import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_map/common/constant/colors.dart';
import 'package:google_map/common/constant/images.dart';
import 'package:google_map/common/constant/string.dart';
import 'package:google_map/common/widget/widget.dart';
import 'package:google_map/pages/home_screen/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDrawScreen extends StatefulWidget {
  final Coordinates source;
  final Coordinates destination;

  RouteDrawScreen({this.source, this.destination});

  @override
  RouteDrawScreenState createState() => RouteDrawScreenState();
}

class RouteDrawScreenState extends State<RouteDrawScreen> {
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
    onAddLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            mapType: currentType,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: (widget.destination != null || widget.source != null)
                  ? LatLng(widget.source.latitude, widget.source.longitude)
                  : LatLngs.NanaVarachha,
              zoom: 10,
              tilt: 20,
            ),
            // onTap: handleTap,
            markers: Set.from(markers),
          ),
          (widget.destination != null || widget.source != null)
              ? Container()
              : Positioned(
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
                (widget.destination != null || widget.source != null)
                    ? Container()
                    : SizedBox(height: 16),
                (widget.destination != null || widget.source != null)
                    ? Container()
                    : mapIcon(
                        onAddLocation,
                        Icons.add_location,
                        'Add Location',
                      ),
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
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 20),
      ImageResources.BlackMarker,
    );
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 5),
      ImageResources.RedMarker,
    );
  }

  void onAddLocation() async {
    if (widget.source == null || widget.destination == null) {
      final location = Coordinations.nanaVarachha;
      List<Address> locationMap =
          await Geocoder.local.findAddressesFromCoordinates(location);
      print('Source Location Name : ${locationMap.first.toMap()}');
      String locality = '${locationMap.first.locality}';
      String subLocality = '${locationMap.first.subLocality}';
      print('locality Name : $locality');
      print('subLocality Name : $subLocality');
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId(Coordinations.nanaVarachha.toString()),
            position: LatLngs.NanaVarachha,
            icon: sourceIcon,
            infoWindow: InfoWindow(
              title: subLocality,
              snippet: locality,
            ),
          ),
        );
      });
    } else {
      final sourceLocation = widget.source;
      final destinationLocation = Coordinations.ahmedabad;
      List<Address> sourceLocationMap =
          await Geocoder.local.findAddressesFromCoordinates(sourceLocation);
      List<Address> destinationLocationMap = await Geocoder.local
          .findAddressesFromCoordinates(destinationLocation);
      print('Source Location Name : ${sourceLocationMap.first.toMap()}');
      print(
          'Destination Location Name : ${destinationLocationMap.first.toMap()}');
      String sourceLocality = '${sourceLocationMap.first.locality}';
      String sourceSubLocality = '${sourceLocationMap.first.subLocality}';
      String destinationLocality = '${destinationLocationMap.first.locality}';
      String destinationSubLocality =
          '${destinationLocationMap.first.subLocality}';
      print('locality Name : $sourceLocality');
      print('subLocality Name : $sourceSubLocality');
      print('locality Name : $destinationLocality');
      print('subLocality Name : $destinationSubLocality');
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId(widget.source.toString()),
            position: LatLng(widget.source.latitude, widget.source.longitude),
            icon: sourceIcon,
            infoWindow: InfoWindow(
              title: sourceSubLocality,
              snippet: sourceLocality,
            ),
          ),
        );
        markers.add(
          Marker(
            markerId: MarkerId(widget.destination.toString()),
            position: LatLng(
                widget.destination.latitude, widget.destination.longitude),
            icon: destinationIcon,
            infoWindow: InfoWindow(
              title: destinationSubLocality,
              snippet: destinationLocality,
            ),
          ),
        );
      });
    }
  }

  handleTap(LatLng argument) async {
    print('Handle tap : $argument');
    final location = new Coordinates(argument.latitude, argument.longitude);
    List<Address> locationMap =
        await Geocoder.local.findAddressesFromCoordinates(location);
    print('Location Name : ${locationMap.first.toMap()}');
    String locality = '${locationMap.first.locality}';
    String subLocality = '${locationMap.first.subLocality}';
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
      List<Address> address =
          await Geocoder.local.findAddressesFromQuery(searchAddress);
      Map<dynamic, dynamic> addressMap = address.first.toMap();
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
