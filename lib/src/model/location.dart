// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:rick_and_morty_graphql/src/model/character.dart';

class Location {
  final String id;
  final String name;

  final String? type;
  final String? dimension;
  final List<Character>? residents;

  Location(this.id, this.name, this.type, this.dimension, this.residents);

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      map['id'] as String,
      map['name'] as String,
      map['type'] != null ? map['type'] as String : null,
      map['dimension'] != null ? map['dimension'] as String : null,
      map['residents'] != null
          ? List<Character>.from(
              (map['residents'] as List<int>).map<Character?>(
                (x) => Character.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

List<Location> locationsFromMap(List<dynamic> map) =>
    map.map((e) => Location.fromMap(e)).toList();
