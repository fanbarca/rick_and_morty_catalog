// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

import 'info.dart';

Locations locationsFromJson(String str) => Locations.fromJson(json.decode(str));

String locationsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    required this.info,
    required this.results,
  });

  Info info;
  List<Location> results;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: Info.fromJson(json["info"]),
        results: List<Location>.from(json["results"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  int id;
  String name;
  String type;
  String dimension;
  List<String> residents;
  String url;
  DateTime created;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}
