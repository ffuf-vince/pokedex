import 'package:flutter/material.dart';
import 'pokemon_tile_button.dart';

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    Key key,
    @required this.pokemonList,
    @required this.iconUrl,
    @required this.index,
  }) : super(key: key);

  final List pokemonList;
  final String iconUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PokemonTileButton(
              pokemonList: pokemonList,
              nameIndex: index - 1,
              imageIndex: index,
              iconUrl: iconUrl),
          SizedBox(
            width: 20,
          ),
          PokemonTileButton(
              pokemonList: pokemonList,
              nameIndex: index,
              imageIndex: index + 1,
              iconUrl: iconUrl),
        ],
      ),
    );
  }
}


