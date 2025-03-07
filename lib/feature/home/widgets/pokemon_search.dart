import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/feature/home/widgets/pokemon_tile_button.dart';
import 'package:pokedex/utilities/extensions.dart';

class PokemonSearch extends SearchDelegate<String> {
  PokemonSearch({required this.list});

  final List<Pokemon> list;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      brightness: theme.brightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultList =
        query.isEmpty ? <Pokemon>[] : list.where((pokemon) => pokemon.name?.startsWith(query) == true).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 5 / 4,
        children: List.generate(resultList.length, (index) {
          return PokemonTileButton(
            key: GlobalKey(),
            pokemon: resultList.elementAt(index),
            imageIndex: resultList.elementAt(index).url?.pokeID ?? '',
          );
        }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        query.isEmpty ? <Pokemon>[] : list.where((pokemon) => pokemon.name?.startsWith(query) == true).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 5 / 4,
        children: List.generate(suggestionList.length, (index) {
          return PokemonTileButton(
            key: GlobalKey(),
            pokemon: suggestionList.elementAt(index),
            imageIndex: suggestionList.elementAt(index).url?.pokeID ?? '',
          );
        }),
      ),
    );
  }
}
