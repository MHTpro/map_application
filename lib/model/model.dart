//To parse this JSON data, do
//
//final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Route> routes;

  Welcome({
    required this.routes,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        routes: List<Route>.from(
          json["routes"].map(
            (x) => Route.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(
          routes.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Route {
  OverviewPolyline overviewPolyline;
  List<Leg> legs;

  Route({
    required this.overviewPolyline,
    required this.legs,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        overviewPolyline: OverviewPolyline.fromJson(json["overview_polyline"]),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "overview_polyline": overviewPolyline.toJson(),
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
      };
}

class Leg {
  String summary;
  Distance distance;
  Distance duration;
  List<Step> steps;

  Leg({
    required this.summary,
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        summary: json["summary"],
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary,
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Distance {
  int value;
  String text;

  Distance({
    required this.value,
    required this.text,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
      };
}

class Step {
  String name;
  String instruction;
  int bearingAfter;
  String type;
  String? modifier;
  Distance distance;
  Distance duration;
  String polyline;
  List<double> startLocation;
  int? exit;

  Step({
    required this.name,
    required this.instruction,
    required this.bearingAfter,
    required this.type,
    this.modifier,
    required this.distance,
    required this.duration,
    required this.polyline,
    required this.startLocation,
    this.exit,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        name: json["name"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        type: json["type"],
        modifier: json["modifier"],
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        polyline: json["polyline"],
        startLocation:
            List<double>.from(json["start_location"].map((x) => x?.toDouble())),
        exit: json["exit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "type": type,
        "modifier": modifier,
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "polyline": polyline,
        "start_location": List<dynamic>.from(startLocation.map((x) => x)),
        "exit": exit,
      };
}

class OverviewPolyline {
  String points;

  OverviewPolyline({
    required this.points,
  });

  factory OverviewPolyline.fromJson(Map<String, dynamic> json) =>
      OverviewPolyline(
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "points": points,
      };
}
