import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty_graphql/src/graphql.dart';

import 'src/app.dart';

void main() async {
  await initHiveForFlutter();

  runApp(MyApp(
      graphQlService: GraphqlService(
    GraphQLCache(store: HiveStore()),
  )));
}
