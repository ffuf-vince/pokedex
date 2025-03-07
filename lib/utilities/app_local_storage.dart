import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class AppLocalStorage {
  AppLocalStorage();

  Future<void>? save(String data) async {
    final file = await _getFile();
    final encodedData = Uint8List.fromList(utf8.encode(data));

    await file.writeAsBytes(encodedData);
  }

  Future<String?> load() async {
    final file = await _getFile();
    final isExisting = await file.exists();
    if (isExisting) {
      final decodedData = utf8.decode(file.readAsBytesSync());
      return decodedData;
    }
    return null;
  }

  Future<void> delete() async {
    final file = await _getFile();
    final isExisting = await file.exists();
    if (isExisting) {
      await file.delete();
    }
  }

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/persisted_state.json');
  }
}
