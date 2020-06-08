import 'package:flutter/material.dart';

class PokemonProfile extends StatelessWidget {

  PokemonProfile({
    @required this.backgroundImage,
    @required this.type,
    @required this.stats
  });

  final ImageProvider backgroundImage;
  final List<Widget> type;
  final List<Widget> stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                maxRadius: 75,
                minRadius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: backgroundImage,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: type,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: stats,
          ),
        ],
      ),
    );
  }
}