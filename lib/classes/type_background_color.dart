import 'package:flutter/material.dart';
import 'package:pokedex/utilities/color.dart';

mixin TypeBackgroundColor on StatelessWidget {
  Color getBackgroundColor({required String type, required Brightness brightness}) {
    Color color;

    switch (brightness) {
      case Brightness.dark:
        switch (type) {
          case 'grass':
            color = kGrassDark;
            break;
          case 'fire':
            color = kFireDark;
            break;
          case 'water':
            color = kWaterDark;
            break;
          case 'normal':
            color = kNormalDark;
            break;
          case 'flying':
            color = kFlyingDark;
            break;
          case 'bug':
            color = kBugDark;
            break;
          case 'poison':
            color = kPoisonDark;
            break;
          case 'electric':
            color = kElectricDark;
            break;
          case 'ground':
            color = kGroundDark;
            break;
          case 'fighting':
            color = kFightingDark;
            break;
          case 'psychic':
            color = kPsychicDark;
            break;
          case 'rock':
            color = kRockDark;
            break;
          case 'ice':
            color = kIceDark;
            break;
          case 'ghost':
            color = kGhostDark;
            break;
          case 'dragon':
            color = kDragonDark;
            break;
          case 'dark':
            color = kDarkDark;
            break;
          case 'steel':
            color = kSteelDark;
            break;
          case 'fairy':
            color = kFairyDark;
            break;
          default:
            color = kPokemonTileButtonBackgroundColorDefault;
            break;
        }

        break;
      case Brightness.light:
        switch (type) {
          case 'grass':
            color = kGrass;
            break;
          case 'fire':
            color = kFire;
            break;
          case 'water':
            color = kWater;
            break;
          case 'normal':
            color = kNormal;
            break;
          case 'flying':
            color = kFlying;
            break;
          case 'bug':
            color = kBug;
            break;
          case 'poison':
            color = kPoison;
            break;
          case 'electric':
            color = kElectric;
            break;
          case 'ground':
            color = kGround;
            break;
          case 'fighting':
            color = kFighting;
            break;
          case 'psychic':
            color = kPsychic;
            break;
          case 'rock':
            color = kRock;
            break;
          case 'ice':
            color = kIce;
            break;
          case 'ghost':
            color = kGhost;
            break;
          case 'dragon':
            color = kDragon;
            break;
          case 'dark':
            color = kDark;
            break;
          case 'steel':
            color = kSteel;
            break;
          case 'fairy':
            color = kFairy;
            break;
          default:
            color = kPokemonTileButtonBackgroundColorDefault;
            break;
        }
        break;
      default:
        color = kPokemonTileButtonBackgroundColorDefault;
        break;
    }
    return color;
  }
}
