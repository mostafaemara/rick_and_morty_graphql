// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:rick_and_morty_graphql/src/model/episode.dart';
import 'package:rick_and_morty_graphql/src/model/location.dart';

List<Character> charactersFromMap(List<dynamic> map) =>
    map.map((e) => Character.fromMap(e)).toList();

class Character {
  final String id;
  final String name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Location? orgin;
  final Location? location;
  final String? imageUrl;
  final List<Episode>? episodes;

  Character(this.id, this.name, this.status, this.species, this.type,
      this.gender, this.orgin, this.location, this.imageUrl, this.episodes);

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      map['id'] as String,
      map['name'] as String,
      map['status'] != null ? map['status'] as String : null,
      map['species'] != null ? map['species'] as String : null,
      map['type'] != null ? map['type'] as String : null,
      map['gender'] != null ? map['gender'] as String : null,
      map['orgin'] != null
          ? Location.fromMap(map['orgin'] as Map<String, dynamic>)
          : null,
      map['location'] != null
          ? Location.fromMap(map['location'] as Map<String, dynamic>)
          : null,
      map['image'] != null ? map['image'] as String : null,
      map['episodes'] != null
          ? List<Episode>.from(
              (map['episodes'] as List<int>).map<Episode?>(
                (x) => Episode.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class CharactersModel {
  final List<Character> results;
  final int? count;
  final int? next;
  final int? pages;
  final int? prev;

  CharactersModel(this.results, this.count, this.next, this.pages, this.prev);

  factory CharactersModel.fromMap(Map<String, dynamic> map) {
    return CharactersModel(
      List<Character>.from(
        (map["characters"]['results'] as List<dynamic>).map<Character>(
          (x) => Character.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map["characters"]["info"]['count'],
      map["characters"]["info"]['next'],
      map["characters"]["info"]['pages'],
      map["characters"]["info"]['prev'],
    );
  }
}
