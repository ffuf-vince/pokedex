import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/classes/information_helper.dart';

import 'about_tiles.dart';

class AboutContainer extends StatelessWidget with InformationHelper {
  AboutContainer({required this.information});

  final Map<String, dynamic> information;

  @override
  Widget build(BuildContext context) {
    final listOfAbouts = getAbout(information);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          AboutTiles(item: listOfAbouts[0]),
          AboutTiles(item: listOfAbouts[1]),
          AboutTiles(item: listOfAbouts[2]),
          AboutTiles(item: listOfAbouts[3]),
        ],
      ),
    );
  }
}
