import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/type_model.dart';
import 'package:pokedex/classes/information_helper.dart';
import 'package:pokedex/classes/type_background_color.dart';
import 'package:pokedex/feature/information/pokemon_info_page.dart';
import 'package:pokedex/feature/information/pokemon_info_page_vm.dart';
import 'package:pokedex/feature/widget/loading_widget.dart';
import 'package:pokedex/state/actions/pokemon_info_page_action.dart';
import 'package:pokedex/state/app_state.dart';

class PokemonInfoPageConnector extends StatelessWidget with TypeBackgroundColor, InformationHelper {
  PokemonInfoPageConnector({required this.name, required this.url, required this.type});

  final String name;
  final String url;
  final Type type;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return StoreConnector<AppState, PokemonInfoPageVm>(
      vm: PokemonInfoPageVmFactory.new,
      onInit: (store) => store.dispatch(GetPokemonInformation(url: url)),
      builder: (context, vm) {
        return vm.pageState.when(
          (pokemonInfo) => PokemonInfoPage(
            backgroundColor: getBackgroundColor(type: type.name ?? '', brightness: brightness),

            pokemonInfo: pokemonInfo,
            evolutionChain: vm.evolutionChain,
          ),
          loading: () => LoadingWidget(),
          error: (errorMessage) => Center(child: Text(errorMessage ?? '')),
        );
      },
    );
  }
}
