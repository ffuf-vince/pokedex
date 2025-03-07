import 'package:async_redux/async_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/utilities/state_serializer.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    @Default([]) List<Pokemon> pokemonList,
    @Default({}) Map<String, dynamic> pokemonInformation,
    @Default({}) Map<String, dynamic> evolutionChain,
    @Default([]) List<Pokemon> filteredPokemonList,
    @Default(Wait.empty) @JsonKey(includeToJson: false, includeFromJson: false) Wait wait,
  }) = _AppState;

  factory AppState.init() => AppState(wait: Wait());

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}

class AppStateSerializer extends StateSerializer<AppState> {
  @override
  AppState decode(Map<String, dynamic> data) => AppState.fromJson(data);

  @override
  Map<String, dynamic> encode(state) => state.toJson();
}
