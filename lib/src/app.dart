import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_graphql/src/graphql.dart';
import 'package:rick_and_morty_graphql/src/view/characters/characters_screen.dart';
import 'package:rick_and_morty_graphql/src/view/home/home_screen.dart';

import 'package:rick_and_morty_graphql/src/view_model/home_view_model.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.graphQlService,
  });
  final GraphqlService graphQlService;
  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(graphQlService),
        ),
      ],
      child: GraphQLProvider(
        client: ValueNotifier(graphQlService.client),
        child: MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            CharactersScreen.routeName: (context) => const CharactersScreen()
          },
        ),
      ),
    );
  }
}
