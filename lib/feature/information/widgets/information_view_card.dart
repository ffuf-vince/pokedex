import 'package:flutter/material.dart';
import 'package:pokedex/utilities/constants.dart';

class InformationViewCard extends StatelessWidget {
  const InformationViewCard({
    Key key,
    this.trailing,
    this.title,
  }) : super(key: key);

  final Widget trailing;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPokemonTileButtonBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: title,
        trailing: trailing,
      ),
    );
  }
}