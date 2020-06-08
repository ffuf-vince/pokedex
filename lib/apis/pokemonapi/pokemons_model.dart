import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/utilities/constants.dart';

class PokemonsModel {
  List list = [];

  Future<List> getData() async {
    http.Response response;
    try {
      response = await http.get(kUrl);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
        list = jsonDecode(response.body)['results'];
    } else {
      print("Can't get pokemon data. Status Code: ${response.statusCode}");
    }
    return list;
  }
}