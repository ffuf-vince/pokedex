import 'dart:async';
import 'package:pokedex/apis/pokemonapi/handlers/pokemon_list_handler.dart';
import 'package:pokedex/state/actions/actions.dart';
import 'package:pokedex/state/app_state.dart';

const pokemonLoadingKey = 'pokemon-loading-key';

class GetPokemons extends LoadingAction {
  GetPokemons() : super(actionKey: pokemonLoadingKey);
  @override
  Future<AppState> reduce() async {
    try {
      final tempList = await PokemonList.getData();
      return state.copyWith(
        pokemonList: tempList,
      );
    } catch (e) {
      print(e);
      return state.copyWith(
        pokemonList: [],
      );
    }
  }
}
