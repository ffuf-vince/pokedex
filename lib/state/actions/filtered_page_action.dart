import 'dart:async';

import 'package:pokedex/apis/pokemonapi/handlers/pokemon_list_handler.dart';
import 'package:pokedex/state/actions/actions.dart';
import 'package:pokedex/state/app_state.dart';

const filterLoadingKey = 'filter-loading-key';

class GetFilteredPokemons extends LoadingAction {
  GetFilteredPokemons({required this.type}) : super(actionKey: filterLoadingKey);

  final String type;

  @override
  Future<AppState> reduce() async {
    try {
      final tempList = await PokemonList.getFilteredData(type);
      return state.copyWith(filteredPokemonList: tempList);
    } catch (e) {
      print(e);
      return state.copyWith(filteredPokemonList: []);
    }
  }
}
