import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';

class EvolutionTile extends StatelessWidget {
  EvolutionTile({required this.item});

  final List<Pokemon> item;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            item.map((pokemon) {
              final url = pokemon.url;
              return Column(
                children: [
                  if (url != null) Image.network(url, width: (MediaQuery.of(context).size.width - 40) / 3),
                  Text(pokemon.name?.toUpperCase() ?? '', style: Theme.of(context).textTheme.titleSmall),
                ],
              );
            }).toList(),
      ),
    );
  }
}
