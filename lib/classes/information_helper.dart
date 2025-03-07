import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/about_model.dart';
import 'package:pokedex/apis/pokemonapi/models/evolution_model.dart';
import 'package:pokedex/apis/pokemonapi/models/move_model.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/apis/pokemonapi/models/statistic_model.dart';
import 'package:pokedex/apis/pokemonapi/models/type_model.dart';
import 'package:pokedex/utilities/constants.dart';
import 'package:pokedex/utilities/enums.dart';
import 'package:pokedex/utilities/extensions.dart';
import 'package:pokedex/utilities/string_constants.dart';

mixin InformationHelper on Widget {
  // used inside extract evolution
  // Pokemon.url -> modified in this method to become icon url already
  Evolution getEvolution(Map<String, dynamic> chain) {
    final lastPokemonList = <Pokemon>[];
    final middlePokemonList = <Pokemon>[];

    if (chain['evolves_to'].isNotEmpty) {
      // for last
      final lastSpecies = chain['evolves_to'][0]['evolves_to'];
      for (Map item in lastSpecies) {
        var newPokemon = Pokemon().copyWith(
          name: item.specieName,
          url: kIconUrl + '${item.specieUrl.specieNumber}.png',
        );
        lastPokemonList.add(newPokemon);
      }

      // for middle
      final middleSpecies = chain['evolves_to'];
      for (Map item in middleSpecies) {
        var newPokemon = Pokemon().copyWith(
          name: item.specieName,
          url: kIconUrl + '${item.specieUrl.specieNumber}.png',
        );
        middlePokemonList.add(newPokemon);
      }
    }

    return Evolution(
      base: Pokemon(name: chain.specieName, url: kIconUrl + '${chain.specieUrl.specieNumber}.png'),
      middle: middlePokemonList,
      last: lastPokemonList,
    );
  }

  List<Type> getTypes(Map information) {
    final types = <Type>[];

    for (Map type in information['types']) {
      types.add(Type(name: type['type']['name']));
    }
    return types;
  }

  List<Statistic> getStats(Map information) {
    final statistics = <Statistic>[];

    for (Map statistic in information['stats']) {
      String name = statistic['stat']['name'];
      switch (name) {
        case specialAttack:
          name = specialAttackShortened;
          break;
        case specialDefense:
          name = specialDefenseShortened;
          break;
        default:
          break;
      }
      var newStatistic = Statistic().copyWith(name: name, value: statistic['base_stat']);
      statistics.add(newStatistic);
    }
    return statistics;
  }

  List<About> getAbout(Map<String, dynamic> information) {
    final about = <About>[];

    AboutTabElement.values.forEach((element) {
      About aboutElement;
      switch (element) {
        case AboutTabElement.HEIGHT:
          aboutElement = About().copyWith(name: height, value: (information['height'] / 10).toString() + ' $meterUnit');
          about.add(aboutElement);
          break;
        case AboutTabElement.WEIGHT:
          aboutElement = About().copyWith(
            name: weight,
            value: (information['weight'] / 10).toString() + ' $kilogramUnit',
          );
          about.add(aboutElement);
          break;
        case AboutTabElement.ABILITIES:
          final value = <String>[];

          for (Map ability in information['abilities']) {
            value.add('${ability['ability']['name']}'.toUpperCase());
          }
          aboutElement = About().copyWith(name: abilities, value: value.join(', '));
          about.add(aboutElement);
          break;
        case AboutTabElement.BASE_EXPERIENCE:
          aboutElement = About().copyWith(
            name: baseExperience,
            value: information['base_experience'].toString() + ' $experienceUnit',
          );
          about.add(aboutElement);
          break;
      }
    });
    return about;
  }

  List<Move> getMoves(Map<String, dynamic> information) {
    final moves = <Move>[];
    for (Map move in information['moves']) {
      var newMove = Move().copyWith(name: move['move']['name'].toUpperCase());
      moves.add(newMove);
    }
    return moves;
  }
}
