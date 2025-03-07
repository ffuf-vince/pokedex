import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/feature/home/widgets/my_floating_action_button.dart';
import 'package:pokedex/feature/home/widgets/pokemon_search.dart';
import 'package:pokedex/feature/home/widgets/pokemon_tile_button.dart';
import 'package:pokedex/utilities/extensions.dart';
import 'package:pokedex/utilities/string_constants.dart';

class HomePage extends StatelessWidget {
  final List<Pokemon> pokemons;

  const HomePage({required this.pokemons, super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final aspectRatio = screenSize.width / screenSize.height;
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 20, bottom: 20),
                title: Text(pokedex, textAlign: TextAlign.left, style: Theme.of(context).textTheme.titleLarge),
              ),
              expandedHeight: 100,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () => showSearch(context: context, delegate: PokemonSearch(list: pokemons)),
                    child: Icon(Icons.search, size: 35),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.count(
                crossAxisCount: aspectRatio <= .90 ? 2 : 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 5 / 4,
                children: List.generate(
                  pokemons.length,
                  (index) => PokemonTileButton(
                    key: UniqueKey(),
                    pokemon: pokemons.elementAt(index),
                    imageIndex: pokemons.elementAt(index).url?.pokeID ?? '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
