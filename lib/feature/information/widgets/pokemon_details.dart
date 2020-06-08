import 'package:flutter/material.dart';
import 'information_view_container.dart';
import 'package:pokedex/utilities/constants.dart';

class PokemonDetails extends StatelessWidget {

  PokemonDetails({
    @required this.about,
    @required this.abilities,
    @required this.moves,
    @required this.evolution,
  });

  final List<Widget> about;
  final List<Widget> abilities;
  final List<Widget> moves;
  final List<Widget> evolution;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[600],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            TabBar(
              isScrollable: true,
              indicatorColor: kPokemonTileButtonBackgroundColor,
              labelColor: kPokemonTileButtonBackgroundColor,
              tabs: <Widget>[
                Tab(
                  text: 'About',
                ),
                Tab(
                  text: 'Abilities',
                ),
                Tab(
                  text: 'Moves',
                ),
                Tab(
                  text: 'Evolution',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  InformationViewContainer(
                    children: about,
                  ),
                  InformationViewContainer(
                    children: abilities,
                  ),
                  InformationViewContainer(
                    children: moves,
                  ),
                  InformationViewContainer(
                    children: evolution,
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