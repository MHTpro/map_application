import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData? userLocation;
  MapController mapController = MapController();

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  //get permission of location
  Future<void> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    userLocation = await location.getLocation();
    //move to the user location on the map
    mapController.move(
      //location of user
      LatLng(userLocation!.latitude!, userLocation!.longitude!),

      //zoom of map
      18.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //flutter map
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          //point of view
          center: const LatLng(35.715298, 51.404343),

          //zoom the map
          zoom: 16.0,
        ),
        children: <Widget>[
          TileLayer(
            //use open street map
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: "app.map.com",
          ),
        ],
      ),
    );
  }
}
