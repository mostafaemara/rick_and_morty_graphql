import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  GraphqlService(GraphQLCache cache) {
    _graphQLClient = GraphQLClient(link: httpLink, cache: cache);
  }

  final HttpLink httpLink = HttpLink(
    'https://rickandmortyapi.com/graphql',
  );
  late final GraphQLClient _graphQLClient;

  GraphQLClient get client => _graphQLClient;
}

abstract class Schemas {
  static const queryHomeDataWithNameAndImage = '''
query HomeDataWithNameAndImage {
  characters {
    results {
      name
      id
      image
    }
  }
  episodes {
    results {
      name
      id
      episode
    }
  }
  locations {
    results {
      name
      id
      dimension
    }
  }
}
''';
  static const queryCharacters = '''
query Characters(\$page: Int) {
  characters(page: \$page) {
    results {
      name
      status
      species
      id
      image
    }
    info {
      count
      next
      pages
      prev
    }
  }
}
''';
}
