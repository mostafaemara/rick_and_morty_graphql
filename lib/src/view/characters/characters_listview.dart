import 'package:flutter/material.dart';

import '../../model/character.dart';

class CharacterListView extends StatefulWidget {
  final List<Character> characters;
  final VoidCallback onLoadMore;

  const CharacterListView(
      {super.key, required this.characters, required this.onLoadMore});

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.onLoadMore();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: widget.characters.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(widget.characters[index].name),
        subtitle: Text(widget.characters[index].species!),
        trailing: Text(
          widget.characters[index].status!,
          style: TextStyle(
              color: mapStatusToColor(widget.characters[index].status!)),
        ),
        leading: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            child: Image.network(widget.characters[index].imageUrl!)),
      ),
    );
  }

  Color mapStatusToColor(String value) {
    switch (value) {
      case "Alive":
        return Colors.green;
      case "Dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
