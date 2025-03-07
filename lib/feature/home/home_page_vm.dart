import 'package:async_redux/async_redux.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/feature/home/home_page_connector.dart';
import 'package:pokedex/models/union_page_state.dart';
import 'package:pokedex/state/actions/home_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class HomePageVmFactory extends VmFactory<AppState, HomePageConnector, HomePageVm> {
  @override
  HomePageVm fromStore() => HomePageVm(pageState: _getPageState());

  UnionPageState<List<Pokemon>> _getPageState() {
    if (state.wait.isWaiting(pokemonLoadingKey)) {
      return UnionPageState.loading();
    } else if (state.pokemonList.isNotEmpty == true) {
      return UnionPageState(state.pokemonList);
    } else {
      return UnionPageState.error('Home Page Error Message');
    }
  }
}

class HomePageVm extends Vm {
  HomePageVm({required this.pageState}) : super(equals: [pageState]);

  final UnionPageState pageState;
}
