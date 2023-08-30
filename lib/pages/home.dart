import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:map/api/api_methods.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:map/api/extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData? userLocation;
  MapController mapController = MapController();
  Marker? destinationMarker;
  List<LatLng> routingPoint = [];
  @override
  void initState() {
    //get permission as soon as the app run
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

    //for add location icon
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //back to user location
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (userLocation != null) {
            mapController.move(
              //height and width of user location for map
              LatLng(
                userLocation!.latitude!,
                userLocation!.longitude!,
              ),
              //zoom
              18.0,
            );
          }
        },
        child: const Icon(
          Icons.location_searching_outlined,
        ),
      ),
      //flutter map
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          //point of view
          center: const LatLng(35.715298, 51.404343),

          //zoom the map
          zoom: 16.0,

          onLongPress: (tapPosition, location) async {
            if (userLocation == null) return;
            //use API
            final result = await getData(
              LatLng(
                userLocation!.latitude!,
                userLocation!.longitude!,
              ),
              location,
            );

            //use google polyline
            routingPoint =
                decodePolyline(result.routes[0].overviewPolyline.points)
                    .unpackPolyline();

            setState(
              () {
                destinationMarker = Marker(
                  point: location,
                  builder: (BuildContext context) {
                    return const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    );
                  },
                );
              },
            );
          },
        ),
        children: <Widget>[
          TileLayer(
            //use open street map
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

            userAgentPackageName: "app.map.com",
          ),

          //rounting...
          if (routingPoint.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routingPoint,
                  strokeWidth: 8.0,
                  color: Colors.deepOrange,
                ),
              ],
            ),
          //create icon for user location
          MarkerLayer(
            markers: <Marker>[
              if (userLocation != null)
                Marker(
                  point: LatLng(
                    userLocation!.latitude!,
                    userLocation!.longitude!,
                  ),
                  builder: (BuildContext context) {
                    return const Icon(
                      Icons.person_pin_sharp,
                      size: 40.0,
                      color: Colors.purple,
                    );
                  },
                ),
              if (destinationMarker != null) destinationMarker!,
            ],
          ),
        ],
      ),
    );
  }
}
