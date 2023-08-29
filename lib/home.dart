import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //flutter map
      body: FlutterMap(
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
