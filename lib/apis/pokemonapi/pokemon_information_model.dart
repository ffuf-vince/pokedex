import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonInformationModel {

  Future<Map> getInformation(String pokemonURL) async {
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

  Future<Map> getEvolutionData(Map information) async {
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

}