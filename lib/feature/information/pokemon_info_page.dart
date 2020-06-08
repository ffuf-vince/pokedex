import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/utilities/constants.dart';
import 'package:pokedex/apis/pokemonapi/pokemon_information_model.dart';
import 'widgets/pokemon_profile.dart';
import 'widgets/pokemon_details.dart';

class PokemonInfoPage extends StatefulWidget {
  PokemonInfoPage({@required this.name, @required this.url});

  static const String id = 'pokemon_info_screen';
  final String name;
  final String url;

  @override
  _PokemonInfoPageState createState() => _PokemonInfoPageState();
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  Map pokemonInformation = {};
  Map evolutionChain = {};

  void getPokemonInformation() async {
    try {
      Map tempPokeInfo =
          await PokemonInformationModel.getInformation(widget.url);
      Map tempChain =
          await PokemonInformationModel.getEvolutionData(tempPokeInfo);
      setState(() {
        pokemonInformation = tempPokeInfo;
        evolutionChain = tempChain;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getPokemonInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundUIColor,
      appBar: AppBar(
        backgroundColor: kAppBarBackgroundColor,
        title: Text(
          widget.name.toUpperCase(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: PokemonProfile(
              backgroundImage: pokemonInformation.isEmpty
                  ? AssetImage('images/placeholder.png')
                  : NetworkImage(
                      pokemonInformation['sprites']['front_default']),
              type: pokemonInformation.isNotEmpty
                  ? PokemonInformationModel.getTypes(pokemonInformation)
                  : [],
              stats: pokemonInformation.isNotEmpty
                  ? PokemonInformationModel.getStats(pokemonInformation,
                      (MediaQuery.of(context).size.width * .45))
                  : [],
            ),
          ),
          Expanded(
            flex: 2,
            child: PokemonDetails(
              about: pokemonInformation.isNotEmpty
                  ? PokemonInformationModel.getAbout(pokemonInformation)
                  : [],
              abilities: pokemonInformation.isNotEmpty
                  ? PokemonInformationModel.getAbilities(pokemonInformation)
                  : [],
              moves: pokemonInformation.isNotEmpty
                  ? PokemonInformationModel.getMoves(pokemonInformation)
                  : [],
              evolution: evolutionChain.isNotEmpty
                  ? PokemonInformationModel.getEvolution(evolutionChain)
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
