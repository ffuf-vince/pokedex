import 'dart:convert';

import 'package:async_redux/async_redux.dart';
import 'package:pokedex/utilities/app_local_storage.dart';
import 'package:pokedex/utilities/state_serializer.dart';

class StatePersistor<T> extends Persistor<T> {
  StatePersistor({required this.serializer}) {
    _localStorage = AppLocalStorage();
  }

  final StateSerializer<T> serializer;

  late AppLocalStorage _localStorage;

  @override
  Future<void> deleteState() => _localStorage.delete();

  @override
  Future<void> persistDifference({required T? lastPersistedState, required T newState}) async {
    if (lastPersistedState == newState) return;

    Map<String, dynamic> json;
    try {
      json = serializer.encode(newState);
    } catch (e) {
      throw Exception('On serialize json: ${e.toString()}');
    }

    try {
      final data = jsonEncode(json);
      await _localStorage.save(data);
    } catch (e) {
      throw Exception('On save to storage: ${e.toString()}');
    }
  }

  @override
  Future<T?> readState() async {
    String? data;
    try {
      data = await _localStorage.load();
    } catch (e) {
      throw Exception('On load from storage: ${e.toString()}');
    }

    if (data == null) return null;

    T state;
    try {
      state = serializer.decode(jsonDecode(data));
    } catch (e) {
      throw Exception('On deserialize state: ${e.toString()}');
    }

    return state;
  }

  @override
  Duration? get throttle => Duration(milliseconds: 100);
}
