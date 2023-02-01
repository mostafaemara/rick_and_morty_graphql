import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty_graphql/src/graphql.dart';
import 'package:rick_and_morty_graphql/src/model/episode.dart';
import 'package:rick_and_morty_graphql/src/model/location.dart';

import '../model/character.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._graphqlService);
  final GraphqlService _graphqlService;
  bool _isLoading = true;
  List<Character> _characters = [];
  List<Location> _locations = [];
  List<Episode> _episodes = [];
  List<Character> get characters => _characters;
  List<Location> get locations => _locations;
  List<Episode> get episodes => _episodes;
  bool get isLoading => _isLoading;
  void init() async {
    try {
      final data = await _graphqlService.client.query(QueryOptions(
          document: gql(Schemas.queryHomeDataWithNameAndImage),
          variables: const {"page": 6}));

      _characters = charactersFromMap(data.data!["characters"]["results"]);
      _locations = locationsFromMap(data.data!["locations"]["results"]);
      _episodes = episodesFromMap(data.data!["episodes"]["results"]);
      log(data.data.toString(), name: "HomeViewModel");
    } catch (e) {
      log(e.toString(), error: "HomeViewModel");
    }
    _isLoading = false;
    notifyListeners();
  }
}
