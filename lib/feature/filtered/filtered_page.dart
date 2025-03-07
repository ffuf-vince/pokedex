import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/feature/home/widgets/pokemon_tile_button.dart';
import 'package:pokedex/utilities/extensions.dart';

class FilterPage extends StatelessWidget {
  final List<Pokemon> pokemons;
  final String type;

  const FilterPage({required this.pokemons, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              primary: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  type.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              expandedHeight: 100,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 5 / 4,
                children: List.generate(pokemons.length, (index) {
                  return PokemonTileButton(
                    key: ObjectKey(pokemons.elementAt(index)),
                    pokemon: pokemons.elementAt(index),
                    imageIndex: pokemons.elementAt(index).url?.pokeID ?? '',
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
