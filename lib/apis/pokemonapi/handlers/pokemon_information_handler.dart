import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/utilities/extensions.dart';

class PokemonInformation {
  static Future<Map<String, dynamic>> getInformation(String pokemonURL) async {
    var information = <String, dynamic>{};

    http.Response response;
    try {
      response = await http.get(Uri.parse(pokemonURL));
      if (response.statusCode == 200) {
        information = jsonDecode(response.body);
      } else {
        print("Can't get pokemon Information. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return information;
  }

  //Used in the actions
  static Future<Map<String, dynamic>> getEvolutionData(Map information) async {
    var chain = <String, dynamic>{};
    http.Response speciesResponse;
    try {
      speciesResponse = await http.get(Uri.parse(information.specieUrl));
      if (speciesResponse.statusCode == 200) {
        String evolutionURL = jsonDecode(speciesResponse.body)['evolution_chain']['url'];
        http.Response evolutionChainResponse;
        try {
          evolutionChainResponse = await http.get(Uri.parse(evolutionURL));
          if (evolutionChainResponse.statusCode == 200) {
            chain = jsonDecode(evolutionChainResponse.body)['chain'];
          } else {
            print("Can't get Evolution: Status Code: ${evolutionChainResponse.statusCode}");
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
}
