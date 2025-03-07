import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex_app.dart';
import 'package:pokedex/state/app_state.dart';
import 'package:pokedex/utilities/state_persistor.dart';

void appStarter() async {
  final persistor = StatePersistor<AppState>(serializer: AppStateSerializer());

  WidgetsFlutterBinding.ensureInitialized();

  AppState? initialState;

  try {
    initialState = await persistor.readState();
  } catch (e) {
    print(e);
  }

  if (initialState == null) {
    initialState = AppState.init();
    await persistor.saveInitialState(initialState);
  }

  final store = Store<AppState>(
    initialState: initialState,
    actionObservers: [if (kDebugMode) Log.printer(formatter: Log.verySimpleFormatter)],
    persistor: persistor,
  );

  runApp(PokedexApp(store: store));
}
