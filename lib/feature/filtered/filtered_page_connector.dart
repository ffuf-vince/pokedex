import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/feature/filtered/filtered_page.dart';
import 'package:pokedex/feature/filtered/filtered_page_vm.dart';
import 'package:pokedex/feature/widget/loading_widget.dart';
import 'package:pokedex/state/actions/filtered_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class FilteredPageConnector extends StatelessWidget {
  FilteredPageConnector({required this.type});
  final String type;

  @override
  Widget build(Object context) {
    return StoreConnector<AppState, FilteredPageVm>(
      vm: FilteredPageVmFactory.new,
      onInit: (store) {
        store.dispatch(GetFilteredPokemons(type: type));
      },
      builder: (context, vm) {
        return vm.pageState.when(
          (pokemons) => FilterPage(pokemons: pokemons, type: type),
          loading: () => LoadingWidget(),
          error: (errorMessage) => Center(child: Text(errorMessage ?? '')),
        );
      },
    );
  }
}
