import 'package:flutter/material.dart';

const String kIconUrl =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/';

const String kUrl = 'https://pokeapi.co/api/v2/pokemon?limit=807';

const Color kBackgroundUIColor = Color(0xffe8e4d8);

const Color kAppBarBackgroundColor = Color(0xff263238);

const Color kPokemonTileButtonBackgroundColor = Color(0xfffafaf7);

const kPokemonTileButtonDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black54,
      offset: Offset(0, 0),
      blurRadius: 5,
    )
  ],
  borderRadius: BorderRadius.all(Radius.circular(20)),
  color: kPokemonTileButtonBackgroundColor,
);
