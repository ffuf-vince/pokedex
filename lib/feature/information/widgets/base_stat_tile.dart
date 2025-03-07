import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/statistic_model.dart';

import 'base_stat_bar.dart';

class BaseStatTile extends StatelessWidget {
  BaseStatTile({required this.item});

  final Statistic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Container(
            height: 20,
            width: (MediaQuery.of(context).size.width - 40) * .25,
            child: Text(
              (item.name == 'hp' ? item.name?.toUpperCase() : item.name?.toUpperCase()) ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            height: 20,
            width: (MediaQuery.of(context).size.width - 40) * .12,
            child: Text(item.value.toString(), style: Theme.of(context).textTheme.titleSmall),
          ),
          Container(
            height: 20,
            width: (MediaQuery.of(context).size.width - 40) * .63,
            child: BaseStatBar(rawScore: item.value ?? 0, barWidth: (MediaQuery.of(context).size.width - 40) * .63),
          ),
        ],
      ),
    );
  }
}
