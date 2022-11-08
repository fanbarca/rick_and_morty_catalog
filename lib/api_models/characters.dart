import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'enums.dart';
import 'info.dart';

class Characters {
  Characters({
    required this.info,
    required this.results,
  });

  Info info;
  List<Character> results;

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        info: Info.fromJson(json["info"]),
        results: List<Character>.from(json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  LocationUrl origin;
  LocationUrl location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: LocationUrl.fromJson(json["origin"]),
        location: LocationUrl.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

class LocationUrl {
  LocationUrl({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory LocationUrl.fromJson(Map<String, dynamic> json) => LocationUrl(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
