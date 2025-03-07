import 'package:flutter/material.dart';

import 'types_container.dart';

class UpperPart extends StatelessWidget {
  UpperPart({required this.pokemonInformation, required this.color});

  final Map<String, dynamic> pokemonInformation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            pokemonInformation['name'].toString().toUpperCase(),
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Text(
            '#' + pokemonInformation['id'].toString().padLeft(3, '0'),
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          TypesContainer(information: pokemonInformation),
        ],
      ),
    );
  }
}
