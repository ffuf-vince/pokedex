import 'package:async_redux/async_redux.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/feature/filtered/filtered_page_connector.dart';
import 'package:pokedex/models/union_page_state.dart';
import 'package:pokedex/state/actions/filtered_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class FilteredPageVmFactory extends VmFactory<AppState, FilteredPageConnector, FilteredPageVm> {
  @override
  FilteredPageVm fromStore() => FilteredPageVm(pageState: _getPageState());

  UnionPageState<List<Pokemon>> _getPageState() {
    if (state.wait.isWaiting(filterLoadingKey)) {
      return UnionPageState.loading();
    } else if (state.filteredPokemonList.isNotEmpty == true) {
      return UnionPageState(state.filteredPokemonList);
    } else {
      return UnionPageState.error('Filtered Pokemon Error');
    }
  }
}

class FilteredPageVm extends Vm {
  FilteredPageVm({required this.pageState}) : super(equals: [pageState]);

  final UnionPageState pageState;
}
