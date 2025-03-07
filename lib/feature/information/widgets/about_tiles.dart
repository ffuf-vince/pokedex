import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/models/about_model.dart';

class AboutTiles extends StatelessWidget {
  AboutTiles({required this.item});

  final About item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 40) * .4,
            child: Text(item.name ?? '', style: Theme.of(context).textTheme.titleMedium),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 40) * .6,
            child: Text(item.value ?? '', style: Theme.of(context).textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
