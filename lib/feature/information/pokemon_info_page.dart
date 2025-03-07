import 'package:flutter/material.dart';
import 'package:pokedex/feature/information/widgets/bottom_part.dart';
import 'package:pokedex/feature/information/widgets/upper_part.dart';
import 'package:pokedex/utilities/color.dart';
import 'package:pokedex/utilities/extensions.dart';

class PokemonInfoPage extends StatelessWidget {
  final Color backgroundColor;
  final Map<String, dynamic> evolutionChain;
  final Map<String, dynamic> pokemonInfo;

  const PokemonInfoPage({
    required this.backgroundColor,
    required this.evolutionChain,
    required this.pokemonInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundUIColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Expanded(child: UpperPart(pokemonInformation: pokemonInfo, color: backgroundColor)),
                Expanded(
                  child: BottomPart(
                    color: backgroundColor,
                    pokemonInformation: pokemonInfo,
                    evolutionChain: evolutionChain,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(pokemonInfo.imageUrl, width: 200, height: 200),
            ),
          ],
        ),
      ),
    );
  }
}
