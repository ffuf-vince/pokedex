import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/feature/information/widgets/information_view_card.dart';
import 'package:pokedex/utilities/constants.dart';
import 'package:pokedex/feature/information/widgets/evolution_view_card.dart';
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
    try{
      Map tempPokeInfo = await PokemonInformationModel().getInformation(widget.url);
      Map tempChain = await PokemonInformationModel().getEvolutionData(tempPokeInfo);
      setState(() {
        pokemonInformation = tempPokeInfo;
        evolutionChain = tempChain;
      });
    }
    catch (e) {
      print(e);
    }
  }

  List<Widget> getTypes() {
    List<Widget> typeList = [];
    for (Map type in pokemonInformation['types']) {
      typeList.add(SizedBox(
        width: 15,
      ));
      typeList.add(
        Image.asset(
          'images/pokemonTypes/${type['type']['name']}.png',
          height: 25,
        ),
      );
    }
    typeList.add(SizedBox(
      width: 15,
    ));
    return typeList;
  }

  List<Widget> getStats() {
    List<Widget> statList = [];
    for (Map stat in pokemonInformation['stats']) {

      const int maxStat = 200;
      final double statRank = (stat['base_stat'] *
          (MediaQuery.of(context).size.width * .45) /
          maxStat);

      Color getRankColor() {
        if (statRank >= 133.3) {
          return Colors.green;
        } else if (statRank >= 66.7) {
          return Colors.yellow.shade800;
        } else {
          return Colors.red.shade600;
        }
      }

      statList.add(Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        width: MediaQuery.of(context).size.width * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(stat['stat']['name']),
                Text(stat['base_stat'].toString()),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * .45,
                  color: Colors.grey.shade400,
                ),
                Container(
                  height: 2,
                  width: statRank,
                  color: getRankColor(),
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return statList.reversed.toList();
  }

  List<Widget> getAbout() => [
      InformationViewCard(
        title: Text('ID'),
        trailing: pokemonInformation.isEmpty ? Text('...') : Text(pokemonInformation['id'].toString()),
      ),
      InformationViewCard(
        title: Text('Height'),
        trailing: pokemonInformation.isEmpty ? Text('...') : Text((pokemonInformation['height']/10).toString() + ' m'),
      ),
      InformationViewCard(
        title: Text('Weight'),
        trailing: pokemonInformation.isEmpty ? Text('...') : Text((pokemonInformation['weight']/10).toString() + ' kg'),
      ),
      InformationViewCard(
        title: Text('Base Experience'),
        trailing: pokemonInformation.isEmpty ? Text('...') : Text(pokemonInformation['base_experience'].toString() + ' xp'),
      ),
    ];

  List<Widget> getAbilities() {
    List<Widget> abilitiesList = [];

    for (Map ability in pokemonInformation['abilities']) {
      Widget newCard = InformationViewCard(
        title: Text((ability['ability']['name']).toUpperCase()),
        trailing: ability['is_hidden'] ? Text('Hidden') : Text(''),
      );
      abilitiesList.add(newCard);
    }
    return abilitiesList;
  }

  List<Widget> getMoves() {
    List<Widget> movesList = [];
    for (Map move in pokemonInformation['moves']) {
      Widget newCard = InformationViewCard(
        title: Text((move['move']['name']).toUpperCase()),
      );
      movesList.add(newCard);
    }
    return movesList;
  }

  List<Widget> getEvolution() {

    String extractSpecieNumberFromURL(String url) {
      String specieNumber = url.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
      specieNumber = specieNumber.replaceAll('/', '');
      return specieNumber;
    }

    List<Widget> evolutionForms = [];
    String name;
    String id;

    //1st species
    name = evolutionChain['species']['name'];
    id = extractSpecieNumberFromURL(evolutionChain['species']['url']);
    List<Widget> firstSpecies = [EvolutionViewCard(id: id, name: name)];

    //2nd species
    List<Widget> secondSpecies = [];
    if (evolutionChain['evolves_to'].isNotEmpty){
      name = evolutionChain['evolves_to'][0]['species']['name'];
      id = extractSpecieNumberFromURL(evolutionChain['evolves_to'][0]['species']['url']);
      secondSpecies = [EvolutionViewCard(id: id, name: name)];
    }


    //3rd species
    List<Widget> thirdSpecies = [];
    if(evolutionChain['evolves_to'].isNotEmpty){
      List thirdSpeciesChain = evolutionChain['evolves_to'][0]['evolves_to'];
      List<Widget> thirdRow = [];
      for (Map item in thirdSpeciesChain) {
        name = item['species']['name'];
        id = extractSpecieNumberFromURL(item['species']['url']);
        thirdRow.add(Expanded(child: EvolutionViewCard(id: id, name: name),));
      }
      thirdSpecies = [Row(children: thirdRow)];
    }

    evolutionForms = [
      ...firstSpecies,
      ...secondSpecies,
      ...thirdSpecies,
    ];
    return evolutionForms;
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
                type: pokemonInformation.isNotEmpty ? getTypes() : [],
                stats: pokemonInformation.isEmpty ? [] : getStats(),
            ),
          ),
          Expanded(
            flex: 2,
            child: PokemonDetails(
                about: pokemonInformation.isNotEmpty
                    ? getAbout()
                    : [],
                abilities: pokemonInformation.isNotEmpty
                    ? getAbilities()
                    : [],
                moves: pokemonInformation.isNotEmpty
                    ? getMoves()
                    : [],
                evolution: evolutionChain.isNotEmpty
                    ? getEvolution()
                    : [],
            ),
          ),
        ],
      ),
    );
  }
}













