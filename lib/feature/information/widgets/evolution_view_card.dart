import 'package:flutter/material.dart';
import 'package:pokedex/utilities/constants.dart';

class EvolutionViewCard extends StatelessWidget {
  const EvolutionViewCard({
    Key key,
    @required this.id,
    @required this.name,
  }) : super(key: key);

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPokemonTileButtonBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Image.network(kIconUrl + '$id.png'),
          Text(name.toUpperCase()),
        ],
      ),
    );
  }
}