import 'dart:async';

import 'package:pokedex/apis/pokemonapi/handlers/pokemon_information_handler.dart';
import 'package:pokedex/state/actions/actions.dart';
import 'package:pokedex/state/app_state.dart';

const pokemonInfoLoadingKey = 'pokemon-info-loading';

class GetPokemonInformation extends LoadingAction {
  GetPokemonInformation({required this.url}) : super(actionKey: pokemonInfoLoadingKey);
  final String url;

  @override
  Future<AppState> reduce() async {
    try {
      final tempPokeInfo = await PokemonInformation.getInformation(url);
      final tempChain = await PokemonInformation.getEvolutionData(tempPokeInfo);
      return state.copyWith(pokemonInformation: tempPokeInfo, evolutionChain: tempChain);
    } catch (e) {
      print(e);
      return state.copyWith(pokemonInformation: {}, evolutionChain: {});
    }
  }
}
