import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';

part 'evolution_model.freezed.dart';
part 'evolution_model.g.dart';

@freezed
class Evolution with _$Evolution {
  factory Evolution({Pokemon? base, List<Pokemon>? middle, List<Pokemon>? last}) = _Evolution;

  factory Evolution.fromJson(Map<String, dynamic> json) => _$EvolutionFromJson(json);
}
