extension StringExtension on String {
  String get pokeID {
    final url = this;
    return url.replaceAll('https://pokeapi.co/api/v2/pokemon/', '').replaceAll('/', '');
  }

  String get specieNumber {
    final text = this;
    return text.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '');
  }
}

extension MapExtension on Map {
  String get specieUrl => this['species']['url'];
  String get specieName => this['species']['name'];

  List<MapEntry<String, dynamic>> get abilities => this['abilities'];
  String get abilityName => this['ability']['name'];

  String get imageUrl => this['sprites']['other']['official-artwork']['front_default'];
}
