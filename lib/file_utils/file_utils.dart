import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {

  final String dateNow;

  FileUtils(this.dateNow);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test $dateNow.txt');
  }

  Future<File> writeFile() async {
    final file = await _localFile;
    return file.writeAsString("Plik utworzony: $dateNow");
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "Błąd odczytu pliku";
    }
  }
}