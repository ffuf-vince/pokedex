import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/utilities/constants.dart';

class PokemonList {
  static Future<List<Pokemon>> getData() async {
    late http.Response response;

    try {
      response = await http.get(Uri.parse(kUrl));
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      final pokemons = <Pokemon>[];
      List tempList = jsonDecode(response.body)['results'];
      for (var pokemon in tempList) {
        var currentPokemon = Pokemon().copyWith(name: pokemon['name'], url: pokemon['url']);
        pokemons.add(currentPokemon);
      }
      return pokemons;
    } else {
      print("Can't get pokemon data. Status Code: ${response.statusCode}");
      return [];
    }
  }

  static Future<List<Pokemon>> getFilteredData(String type) async {
    final list = <Pokemon>[];
    late http.Response response;

    try {
      response = await http.get(Uri.parse(kFilterURL + type));
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      List tempList = jsonDecode(response.body)['pokemon'];
      print('temp List length: ' + tempList.length.toString());
      for (Map<String, dynamic> pokemon in tempList) {
        var currentPokemon = Pokemon().copyWith(name: pokemon['pokemon']['name'], url: pokemon['pokemon']['url']);
        list.add(currentPokemon);
      }
    } else {
      print("Can't get pokemon data. Status Code: ${response.statusCode}");
    }
    return list;
  }
}
