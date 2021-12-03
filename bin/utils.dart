import 'dart:convert';
import 'dart:io';

class Utils {
  Utils._();

  static Future<List<T>> writeDataFromFile<T>(String path, List<T> data) async {
    await File('${Directory.current.path}/$path')
        .openRead()
        .map(utf8.decode)
        .transform(LineSplitter())
        .forEach((line) {
      final int? valueAsInt = int.tryParse(line);

      if (valueAsInt != null) {
        data.add(valueAsInt as T);
      } else {
        final valueAsList = line.split(' ');

        if (valueAsList.length != 2) return;

        final key = valueAsList[0];
        final value = int.tryParse(valueAsList[1]);

        if (value != null) {
          data.add({
            key: value,
          } as T);
        }
      }
    });

    return data;
  }
}
