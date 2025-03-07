import 'package:flutter/material.dart';
import 'package:pokedex/classes/information_helper.dart';

class TypesContainer extends StatelessWidget with InformationHelper {
  TypesContainer({required this.information});

  final Map<String, dynamic> information;

  @override
  Widget build(BuildContext context) {
    final pokemonTypes = getTypes(information);
    return Row(
      children:
          pokemonTypes
              .map(
                (type) => Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white24),
                  child: Text(type.name?.toUpperCase() ?? '', style: TextStyle(color: Colors.white)),
                ),
              )
              .toList(),
    );
  }
}
