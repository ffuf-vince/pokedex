import 'package:flutter/material.dart';
import 'package:pokedex/utilities/color.dart';
import 'package:pokedex/utilities/string_constants.dart';

import 'about_container.dart';
import 'base_stats_container.dart';
import 'evolution_container.dart';
import 'moves_container.dart';

class BottomPart extends StatelessWidget {
  final Color color;
  final Map<String, dynamic> pokemonInformation;
  final Map<String, dynamic> evolutionChain;

  const BottomPart({required this.color, required this.pokemonInformation, required this.evolutionChain, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 25),
              TabBar(
                labelPadding: const EdgeInsets.all(0),
                indicatorColor: kFloatingActionButtonColor,
                unselectedLabelColor: Colors.grey,
                labelColor: Theme.of(context).textTheme.titleLarge?.color,
                tabs: <Widget>[Tab(text: about), Tab(text: baseStats), Tab(text: evolution), Tab(text: moves)],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    AboutContainer(information: pokemonInformation),
                    BaseStatsContainer(information: pokemonInformation),
                    EvolutionContainer(information: evolutionChain),
                    MovesContainer(information: pokemonInformation),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
