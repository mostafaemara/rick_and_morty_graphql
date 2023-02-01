import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty_graphql/src/model/character.dart';

import '../../graphql.dart';
import 'characters_listview.dart';

class CharactersScreen extends StatelessWidget {
  static const routeName = "/characters";
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Characters"),
        ),
        body: SafeArea(
          child: Query(
            options: QueryOptions(
                parserFn: (data) {
                  return CharactersModel.fromMap(data);
                },
                document: gql(Schemas.queryCharacters),
                variables: const {"page": 1}),
            builder: (result, {fetchMore, refetch}) {
              //  fetchMore(_fetchMoreOptions);
              if (result.isLoading && result.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (result.hasException) {
                return Center(child: Text(result.toString()));
              }
              return Column(
                children: [
                  Expanded(
                    child: CharacterListView(
                      characters: result.parsedData!.results,
                      onLoadMore: () {
                        if (result.parsedData?.next == null) return;
                        fetchMore!(FetchMoreOptions(
                          variables: {"page": result.parsedData?.next},
                          updateQuery:
                              (previousResultData, fetchMoreResultData) {
                            final List<dynamic> characters = [
                              ...previousResultData!["characters"]["results"]
                                  as List<dynamic>,
                              ...fetchMoreResultData!["characters"]["results"]
                                  as List<dynamic>,
                            ];
                            fetchMoreResultData["characters"]["results"] =
                                characters;
                            return fetchMoreResultData;
                          },
                        ));
                      },
                    ),
                  ),
                  Visibility(
                      visible: result.isLoading,
                      child: const CircularProgressIndicator())
                ],
              );
            },
          ),
        ));
  }
}
