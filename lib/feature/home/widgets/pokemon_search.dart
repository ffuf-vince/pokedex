import 'package:flutter/material.dart';
import 'package:pokedex/feature/information/pokemon_info_page.dart';

class PokemonSearch extends SearchDelegate<String> {

  PokemonSearch({@required this.list});

  final List list;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : list
        .where((pokemon) => pokemon['name'].startsWith(query))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonInfoPage(
                  name: suggestionList.elementAt(index)['name'],
                  url: suggestionList.elementAt(index)['url'],
                ),
              ),
            );
          },
          leading: Image.asset('images/pokeball.png', width: 30, height: 30),
          title: Text(suggestionList.elementAt(index)['name'].toUpperCase()),
        );
      },
    );
  }
}
