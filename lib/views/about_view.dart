import 'package:flutter/material.dart';
import 'package:pokedex/components/about_card.dart';

class AboutView extends StatelessWidget {
  const AboutView({
    Key key,
    @required this.pokemonInformation,
  }) : super(key: key);

  final Map pokemonInformation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: <Widget>[
          AboutCard(
            label: 'ID',
            trailing: pokemonInformation.isEmpty ? Text('...') : Text(pokemonInformation['id'].toString()),
          ),
          AboutCard(
            label: 'Height',
            trailing: pokemonInformation.isEmpty ? Text('...') : Text((pokemonInformation['height']/10).toString() + ' m'),
          ),
          AboutCard(
            label: 'Weight',
            trailing: pokemonInformation.isEmpty ? Text('...') : Text((pokemonInformation['weight']/10).toString() + ' kg'),
          ),
          AboutCard(
            label: 'Base Experience',
            trailing: pokemonInformation.isEmpty ? Text('...') : Text(pokemonInformation['base_experience'].toString() + ' xp'),
          ),
        ],
      ),
    );
  }
}