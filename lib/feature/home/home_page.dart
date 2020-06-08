import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/pokemons_model.dart';
import 'package:pokedex/feature/home/widgets/pokemon_list_tile.dart';
import 'widgets/pokemon_search.dart';
import 'package:pokedex/utilities/constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pokemonList = [];

  void getPokemons() async {
    try {
      List tempList = await PokemonsModel().getData();
      setState((){
        pokemonList = tempList;
      });
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundUIColor,
      appBar: AppBar(
        title: Text(
          'Pokédex',
        ),
        backgroundColor: kAppBarBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: PokemonSearch(list: pokemonList));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                 'images/pokedex_background.png',
              ),
            ),
            ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                //start building only if there are more than 3 pokemons
                //temporarily fixes the 'out of range issue' causes by offsetting
                //the index
                if (pokemonList.length > 3) {
                  if (index % 2 != 0) {
                    return PokemonListTile(
                      pokemonList: pokemonList,
                      iconUrl: kIconUrl,
                      index: index,
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


