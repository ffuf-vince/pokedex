import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/state/app_state.dart';
import 'package:pokedex/utilities/theme.dart';

import 'feature/home/home_page_connector.dart';

class PokedexApp extends StatelessWidget {
  PokedexApp({required this.store});

  final Store<AppState> store;

  @override
  Widget build(Object context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(title: 'Pokedex', darkTheme: kDarkTheme, theme: kLightTheme, home: HomePageConnector()),
    );
  }
}
