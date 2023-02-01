import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_graphql/src/view/characters/characters_screen.dart';
import 'package:rick_and_morty_graphql/src/view_model/home_view_model.dart';

import 'title_text_buttom.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeViewModel>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => Scaffold(
        body: value.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextButtom(
                          title: "Characters",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CharactersScreen.routeName);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.characters.length,
                            itemBuilder: (context, index) => CharacterListItem(
                              name: value.characters[index].name,
                              id: value.characters[index].id,
                              imageUrl: value.characters[index].imageUrl!,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TitleTextButtom(
                          title: "Locations",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(
                          3,
                          (index) => LocationListItem(
                            name: value.locations[index].name,
                            id: value.locations[index].id,
                            dimension: value.locations[index].dimension!,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TitleTextButtom(
                          title: "Episodes",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(
                          3,
                          (index) => EpisodeListItem(
                            name: value.episodes[index].name,
                            id: value.episodes[index].id,
                            episode: value.episodes[index].episode!,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class CharacterListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String id;
  const CharacterListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.network(
                    imageUrl,
                    width: 150,
                  )),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  final String name;
  final String dimension;
  final String id;
  const LocationListItem({
    Key? key,
    required this.name,
    required this.dimension,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_pin),
      title: Text(name),
      subtitle: Text(dimension),
    );
  }
}

class EpisodeListItem extends StatelessWidget {
  final String name;
  final String episode;
  final String id;
  const EpisodeListItem({
    Key? key,
    required this.name,
    required this.episode,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.tv),
      title: Text(name),
      subtitle: Text(episode),
    );
  }
}
