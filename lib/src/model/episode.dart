// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:rick_and_morty_graphql/src/model/character.dart';

class Episode {
  final String id;
  final String name;
  final String? episode;
  final List<Character>? characters;
  final String? airDate;

  Episode(this.id, this.name, this.episode, this.characters, this.airDate);

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      map['id'] as String,
      map['name'] as String,
      map['episode'] != null ? map['episode'] as String : null,
      map['characters'] != null
          ? List<Character>.from(
              (map['characters'] as List<int>).map<Character?>(
                (x) => Character.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      map['air_date'] != null ? map['air_date'] as String : null,
    );
  }
}

List<Episode> episodesFromMap(List<dynamic> map) =>
    map.map((e) => Episode.fromMap(e)).toList();
