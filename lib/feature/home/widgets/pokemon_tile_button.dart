import 'package:flutter/material.dart';
import 'package:pokedex/apis/pokemonapi/handlers/pokemon_information_handler.dart';
import 'package:pokedex/apis/pokemonapi/models/pokemon_model.dart';
import 'package:pokedex/apis/pokemonapi/models/type_model.dart';
import 'package:pokedex/classes/information_helper.dart';
import 'package:pokedex/classes/tile_decoration_helper.dart';
import 'package:pokedex/feature/information/pokemon_info_page_connector.dart';
import 'package:pokedex/utilities/constants.dart';

class PokemonTileButton extends StatefulWidget with InformationHelper, TileDecorationHelper {
  const PokemonTileButton({required this.pokemon, required this.imageIndex, super.key});

  final Pokemon pokemon;
  final String imageIndex;

  @override
  _PokemonTileButtonState createState() => _PokemonTileButtonState();
}

class _PokemonTileButtonState extends State<PokemonTileButton> {
  List<Widget> types = [];
  List<Type> listOfTypes = [];

  void buildTypes() async {
    final url = widget.pokemon.url;
    if (url == null) return;

    final tempInfo = await PokemonInformation.getInformation(url);
    listOfTypes = widget.getTypes(tempInfo);

    for (var type in listOfTypes) {
      types.add(
        Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white24),
          child: Text(type.name?.toUpperCase() ?? '', style: TextStyle(color: Colors.white)),
        ),
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    buildTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => PokemonInfoPageConnector(
                    name: widget.pokemon.name ?? '',
                    url: widget.pokemon.url ?? '',
                    type: listOfTypes.first,
                  ),
            ),
          ),
      child: AnimatedContainer(
        decoration: widget.getTileDecoration(
          type: listOfTypes.isNotEmpty ? listOfTypes.first.name ?? '' : '',
          brightness: Theme.of(context).brightness,
        ),
        duration: Duration(milliseconds: 300),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.network(kIconUrl + '${widget.imageIndex}.png', width: 100, height: 100),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.pokemon.name?.toUpperCase() ?? 'Loading...', style: widget.tileTextStyle),
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: types,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
