import 'package:flutter/material.dart';
import 'package:pokedex/classes/information_helper.dart';

import 'evolution_tile.dart';

class EvolutionContainer extends StatelessWidget with InformationHelper {
  EvolutionContainer({required this.information});

  final Map<String, dynamic> information;

  @override
  Widget build(BuildContext context) {
    final evolution = getEvolution(information);
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (evolution.base != null) EvolutionTile(item: [evolution.base!]),
          if (evolution.middle?.isNotEmpty == true) EvolutionTile(item: evolution.middle!),
          if (evolution.last?.isNotEmpty == true) EvolutionTile(item: evolution.last!),
        ],
      ),
    );
  }
}
