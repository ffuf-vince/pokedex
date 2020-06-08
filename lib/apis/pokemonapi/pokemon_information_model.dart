import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex/feature/information/widgets/information_view_card.dart';
import 'package:pokedex/feature/information/widgets/evolution_view_card.dart';

class PokemonInformationModel {

  static Future<Map> getInformation(String pokemonURL) async {
    Map information = {};

    http.Response response;
    try {
      response = await http.get(pokemonURL);
      if (response.statusCode == 200) {
        information = jsonDecode(response.body) ;
      } else {
        print("Can't get pokemon Information. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return information;
  }

  static Future<Map> getEvolutionData(Map information) async {
    Map chain = {};
    http.Response speciesResponse;
    try {
      speciesResponse = await http.get(information['species']['url']);
      if (speciesResponse.statusCode == 200) {
        String evolutionURL =
        jsonDecode(speciesResponse.body)['evolution_chain']['url'];
        http.Response evolutionChainResponse;
        try {
          evolutionChainResponse = await http.get(evolutionURL);
          if (evolutionChainResponse.statusCode == 200) {
            chain = jsonDecode(evolutionChainResponse.body)['chain'];
          } else {
            print(
                "Can't get Evolution: Status Code: ${evolutionChainResponse.statusCode}");
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("Can't get Species: Status Code: ${speciesResponse.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return chain;
  }

  static List<Widget> getTypes(Map information) {
    List<Widget> typeList = [];
    for (Map type in information['types']) {
      typeList.add(SizedBox(
        width: 15,
      ));
      typeList.add(
        Image.asset(
          'images/pokemonTypes/${type['type']['name']}.png',
          height: 25,
        ),
      );
    }
    typeList.add(SizedBox(
      width: 15,
    ));
    return typeList;
  }

  static List<Widget> getStats(Map information, double statWidth) {
    List<Widget> statList = [];
    for (Map stat in information['stats']) {

      const int maxStat = 200;

      final double statRank = (stat['base_stat'] *
          statWidth / maxStat);

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
        width: statWidth,
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
                  width: statWidth,
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

  static List<Widget> getAbout(Map information) => [
    InformationViewCard(
      title: Text('ID'),
      trailing: information.isEmpty
          ? Text('...')
          : Text(information['id'].toString()),
    ),
    InformationViewCard(
      title: Text('Height'),
      trailing: information.isEmpty
          ? Text('...')
          : Text((information['height'] / 10).toString() + ' m'),
    ),
    InformationViewCard(
      title: Text('Weight'),
      trailing: information.isEmpty
          ? Text('...')
          : Text((information['weight'] / 10).toString() + ' kg'),
    ),
    InformationViewCard(
      title: Text('Base Experience'),
      trailing: information.isEmpty
          ? Text('...')
          : Text(information['base_experience'].toString() + ' xp'),
    ),
  ];

  static List<Widget> getAbilities(Map information) {
    List<Widget> abilitiesList = [];

    for (Map ability in information['abilities']) {
      Widget newCard = InformationViewCard(
        title: Text((ability['ability']['name']).toUpperCase()),
        trailing: ability['is_hidden'] ? Text('Hidden') : Text(''),
      );
      abilitiesList.add(newCard);
    }
    return abilitiesList;
  }

  static List<Widget> getMoves(Map information) {
    List<Widget> movesList = [];
    for (Map move in information['moves']) {
      Widget newCard = InformationViewCard(
        title: Text((move['move']['name']).toUpperCase()),
      );
      movesList.add(newCard);
    }
    return movesList;
  }

  static List<Widget> getEvolution(Map chain) {
    String extractSpecieNumberFromURL(String url) {
      String specieNumber =
      url.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
      specieNumber = specieNumber.replaceAll('/', '');
      return specieNumber;
    }

    List<Widget> evolutionForms = [];
    String name;
    String id;

    //1st species
    name = chain['species']['name'];
    id = extractSpecieNumberFromURL(chain['species']['url']);
    List<Widget> firstSpecies = [EvolutionViewCard(id: id, name: name)];

    //2nd species
    List<Widget> secondSpecies = [];
    if (chain['evolves_to'].isNotEmpty) {
      name = chain['evolves_to'][0]['species']['name'];
      id = extractSpecieNumberFromURL(
          chain['evolves_to'][0]['species']['url']);
      secondSpecies = [EvolutionViewCard(id: id, name: name)];
    }

    //3rd species
    List<Widget> thirdSpecies = [];
    if (chain['evolves_to'].isNotEmpty) {
      List thirdSpeciesChain = chain['evolves_to'][0]['evolves_to'];
      List<Widget> thirdRow = [];
      for (Map item in thirdSpeciesChain) {
        name = item['species']['name'];
        id = extractSpecieNumberFromURL(item['species']['url']);
        thirdRow.add(Expanded(
          child: EvolutionViewCard(id: id, name: name),
        ));
      }
      thirdSpecies = [Row(children: thirdRow)];
    }

    evolutionForms = [
      ...firstSpecies,
      ...secondSpecies,
      ...thirdSpecies,
    ];
    return evolutionForms;
  }

}