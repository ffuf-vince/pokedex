import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/utilities/constants.dart';
import 'package:pokedex/views/about_view.dart';

class PokemonInfoScreen extends StatefulWidget {
  PokemonInfoScreen({@required this.name, @required this.url});

  static const String id = 'pokemon_info_screen';
  final String name;
  final String url;

  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  Map pokemonInformation = {};
  List evolutionData = [];

  void getPokemonInformation() async {
    http.Response response;
    try {
      response = await http.get(widget.url);
      if (response.statusCode == 200) {
        setState(() {
          pokemonInformation = jsonDecode(response.body);
          getEvolutionData();
        });
        print(pokemonInformation.isEmpty);
      } else {
        print(
            "Can't get pokemon Information. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  void getEvolutionData() async {
    String speciesURL = pokemonInformation['species']['url'];
    http.Response speciesResponse;
    try{
      speciesResponse = await http.get(speciesURL);
      if (speciesResponse.statusCode == 200) {
        String evolutionURL = jsonDecode(speciesResponse.body)['evolution_chain']['url'];
        http.Response evolutionChainResponse;
        try{
          evolutionChainResponse = await http.get(evolutionURL);
          if(evolutionChainResponse.statusCode == 200) {
            setState(() {
              evolutionData = jsonDecode(evolutionChainResponse.body)['chain']['evolves_to'][0]['evolves_to'];
            });
          } else {
            print("Can't get Evolution: Status Code: ${evolutionChainResponse.statusCode}");
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        print("Can't get Species: Status Code: ${speciesResponse.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  List<Widget> getTypes() {
    List<Widget> typeList = [];
    for (Map type in pokemonInformation['types']){
      typeList.add(SizedBox(width: 15,));
      typeList.add(
        Image.asset(
          'images/${type['type']['name']}.png',
          height: 25,
        ),
      );
    }
    typeList.add(SizedBox(width: 15,));
    return typeList;
  }

  List<Widget> getStats() {
    List<Widget> statList = [];
    for (Map stat in pokemonInformation['stats']) {
      int baseStat;
      String statName;

      const int maxStat = 200;
      final double statRank = (stat['base_stat'] *
          (MediaQuery.of(context).size.width * .45) /
          maxStat);

      Color getRankColor() {
        if (statRank >= 133.3) {
          return Colors.green;
        } else if (statRank >= 66.7) {
          return Colors.yellow.shade800;
        } else {
          return Colors.red.shade600;
        }
      }
      statList.add(Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        width: MediaQuery.of(context).size.width * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(stat['stat']['name']),
                Text(stat['base_stat'].toString()),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * .45,
                  color: Colors.grey.shade400,
                ),
                Container(
                  height: 2,
                  width: statRank,
                  color: getRankColor(),
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return statList.reversed.toList();
  }

  List<Widget> getAbilities() {
    List<Widget> abilitiesList = [];

    for (Map ability in pokemonInformation['abilities']){
      Widget newCard = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text((ability['ability']['name']).toUpperCase()),
          trailing: ability['is_hidden']? Text('Hidden') : Text(''),
        ),
      );
      abilitiesList.add(newCard);
    }

    return abilitiesList;
  }

  List<Widget> getMoves() {
    List<Widget> movesList = [];

    for (Map move in pokemonInformation['moves']){
      Widget newCard = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text((move['move']['name']).toUpperCase()),
        ),
      );
      movesList.add(newCard);
    }
    return movesList;
  }

  List<Widget> getEvolution() {
    List<Widget> evolutionForms = [];
    for (Map form in evolutionData) {
      String name = form['species']['name'];
      String id = form['species']['url'];
      id = id.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
      id = id.replaceAll('/', '');

      Widget evolutionForm = Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Image.network(kIconUrl + '$id.png'),
              Text(name.toUpperCase()),
            ],
          ),
        ),
      );
      evolutionForms.add(evolutionForm);
    }
    return evolutionForms;
  }

  @override
  void initState() {
    getPokemonInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
//    pokemonInformation.isNotEmpty ? getEvolutionData() : null;
    return Scaffold(
      backgroundColor: Color(0xffe8e4d8),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          widget.name.toUpperCase(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        maxRadius: 75,
                        minRadius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: pokemonInformation.isEmpty
                            ? AssetImage('images/placeholder.png')
                            : NetworkImage(
                                pokemonInformation['sprites']['front_default']),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: evolutionData.isNotEmpty ? getTypes() : [],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemonInformation.isEmpty ? [] : getStats(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
//              color: Colors.blueGrey,
              decoration: BoxDecoration(
                color: Colors.blueGrey[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Color(0xffe8e4d8),
                      tabs: <Widget>[
                        Tab(
                          text: 'About',
                        ),
                        Tab(
                          text: 'Abilities',
                        ),
                        Tab(
                          text: 'Moves',
                        ),
                        Tab(
                          text: 'Evolution',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          AboutView(pokemonInformation: pokemonInformation),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ListView(
                              children: pokemonInformation.isNotEmpty ? getAbilities() : [],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ListView(
                              children: pokemonInformation.isNotEmpty ? getMoves() : [],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ListView(
                              children: pokemonInformation.isNotEmpty ? getEvolution() : [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




