import 'dart:convert';

import 'package:http/http.dart' as httpmethod;
import 'package:latlong2/latlong.dart';
import 'package:map/model/model.dart';
import 'package:map/my_api_key.dart';

//get all <List>
Future<List<Welcome>> getAllRequest(LatLng origin, LatLng destination) async {
  //parameters
  Map<String, String> qp = {
    "origin": "${origin.latitude},${origin.longitude}",
    "destination": "${destination.latitude},${destination.longitude}",
  };

  //response
  final respnose = await httpmethod.get(
    Uri.http(
      "api.neshan.org",
      "/v4/direction",
      qp,
    ),
    headers: {"Api-Key": myApiKey},
  );

  if (respnose.statusCode == 200) {
    return List<Welcome>.from(
      jsonDecode(respnose.body).map(
        (value) => Welcome.fromJson(value),
      ),
    );
  } else {
    throw Exception("Error: Can't load all data!!");
  }
}

//get a data
Future<Welcome> getData(LatLng origin, LatLng destination) async {
  //parameters
  Map<String, String> qp = {
    "origin": "${origin.latitude},${origin.longitude}",
    "destination": "${destination.latitude},${destination.longitude}",
  };
  //response
  final respnose = await httpmethod.get(
    Uri.http(
      "api.neshan.org",
      "/v4/direction",
      qp,
    ),
    headers: {"Api-Key": myApiKey},
  );

  if (respnose.statusCode == 200) {
    return Welcome.fromJson(
      jsonDecode(respnose.body),
    );
  } else {
    throw Exception("Can't load the data");
  }
}
