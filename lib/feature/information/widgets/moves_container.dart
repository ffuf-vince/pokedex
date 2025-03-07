import 'package:flutter/material.dart';
import 'package:pokedex/classes/information_helper.dart';

class MovesContainer extends StatelessWidget with InformationHelper {
  MovesContainer({required this.information});

  final Map<String, dynamic> information;

  @override
  Widget build(BuildContext context) {
    final listOfMoves = getMoves(information);
    return Container(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: GridView.count(
        childAspectRatio: 21 / 9,
        crossAxisCount: 3,
        children: List.generate(listOfMoves.length, (index) {
          return Text(
            listOfMoves.elementAt(index).name?.toLowerCase() ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          );
        }),
      ),
    );
  }
}
