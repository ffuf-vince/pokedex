import 'package:async_redux/async_redux.dart';
import 'package:pokedex/feature/information/pokemon_info_page_connector.dart';
import 'package:pokedex/models/union_page_state.dart';
import 'package:pokedex/state/actions/pokemon_info_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class PokemonInfoPageVmFactory extends VmFactory<AppState, PokemonInfoPageConnector, PokemonInfoPageVm> {
  @override
  PokemonInfoPageVm fromStore() => PokemonInfoPageVm(pageState: _getPageState(), evolutionChain: state.evolutionChain);

  UnionPageState<Map<String, dynamic>> _getPageState() {
    if (state.wait.isWaiting(pokemonInfoLoadingKey)) {
      return UnionPageState.loading();
    } else if (state.pokemonInformation.isNotEmpty == true) {
      return UnionPageState(state.pokemonInformation);
    } else {
      return UnionPageState.error('information page error');
    }
  }
}

class PokemonInfoPageVm extends Vm {
  PokemonInfoPageVm({required this.pageState, required this.evolutionChain})
    : super(equals: [pageState, evolutionChain]);

  final UnionPageState pageState;
  final Map<String, dynamic> evolutionChain;
}
