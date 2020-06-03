import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/components/pokemon_list_tile.dart';
import 'pokemon_info_screen.dart';
import 'package:pokedex/utilities/constants.dart';

List pokemonList = [];


class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void getPokemons() async {
    http.Response response;
    try {
      response = await http.get(kUrl);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      setState(() {
        pokemonList = jsonDecode(response.body)['results'];
      });
    } else {
      print("Can't get pokemon data. Status Code: ${response.statusCode}");
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
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
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

class DataSearch extends SearchDelegate<String> {
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
      icon: Icon(Icons.arrow_back),
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
        : pokemonList
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
                builder: (context) => PokemonInfoScreen(
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
