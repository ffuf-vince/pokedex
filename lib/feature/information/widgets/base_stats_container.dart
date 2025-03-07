import 'package:flutter/material.dart';
import 'package:pokedex/classes/information_helper.dart';

import 'base_stat_tile.dart';

class BaseStatsContainer extends StatelessWidget with InformationHelper {
  BaseStatsContainer({required this.information});

  final Map<String, dynamic> information;

  @override
  Widget build(BuildContext context) {
    final listOfStatistics = getStats(information);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          BaseStatTile(item: listOfStatistics[0]),
          BaseStatTile(item: listOfStatistics[1]),
          BaseStatTile(item: listOfStatistics[2]),
          BaseStatTile(item: listOfStatistics[3]),
          BaseStatTile(item: listOfStatistics[4]),
          BaseStatTile(item: listOfStatistics[5]),
        ],
      ),
    );
  }
}
