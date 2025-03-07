import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/feature/home/home_page.dart';
import 'package:pokedex/feature/home/home_page_vm.dart';
import 'package:pokedex/feature/widget/loading_widget.dart';
import 'package:pokedex/state/actions/home_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class HomePageConnector extends StatelessWidget {
  @override
  Widget build(Object context) {
    return StoreConnector<AppState, HomePageVm>(
      vm: HomePageVmFactory.new,
      onInit: (store) {
        store.dispatch(GetPokemons());
      },
      builder: (context, vm) {
        return vm.pageState.when(
          (pokemons) => HomePage(pokemons: pokemons),
          loading: () => LoadingWidget(),
          error: (errorMessage) => Center(child: Text(errorMessage ?? '')),
        );
      },
    );
  }
}
