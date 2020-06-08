import 'package:flutter/material.dart';
import 'package:pokedex/feature/information/pokemon_info_page.dart';
import 'package:pokedex/utilities/constants.dart';

class PokemonTileButton extends StatelessWidget {
  const PokemonTileButton({
    Key key,
    @required this.pokemonList,
    @required this.nameIndex,
    @required this.imageIndex,
    @required this.iconUrl,
  }) : super(key: key);

  final List pokemonList;
  final int nameIndex;
  final int imageIndex;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonInfoPage(
              name: pokemonList.elementAt(nameIndex)['name'],
              url: pokemonList.elementAt(nameIndex)['url'],
            ),
          ),
        );
        print(pokemonList.elementAt(nameIndex)['name'] + ' tapped');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child:
              Text(pokemonList.elementAt(nameIndex)['name'].toUpperCase()),
            ),
            //IDK if this is the right way to do it.
            Expanded(
              flex: 5,
              child: Image.network(iconUrl + '$imageIndex.png'),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * .40,
        height: MediaQuery.of(context).size.width * .35,
        decoration: kPokemonTileButtonDecoration,
      ),
    );
  }
}