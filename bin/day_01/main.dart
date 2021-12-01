import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  const path = 'bin/day_01/input.txt';
  final List<int> values = [];

  Future<void> writeDataFromFile() async {
    await File('${Directory.current.path}/${path}')
        .openRead()
        .map(utf8.decode)
        .transform(LineSplitter())
        .forEach((value) {
      final int? valueAsInt = int.tryParse(value);
      if (valueAsInt != null) values.add(valueAsInt);
    });
  }

  await writeDataFromFile();

  Future<int> getIncreasedCount() async {
    int increasedValues = 0;

    for (var i = 0; i < values.length; i++) {
      if (i == 0) continue;

      if (values[i] > values[i - 1]) increasedValues++;
    }

    return increasedValues;
  }

  Future<int> getIncreasedCountOfThree() async {
    int increasedValues = 0;
    final sumOfThree = [];

    for (var i = 0; i < values.length - 2; i++) {
      final first = values[i];
      final second = values[i + 1];
      final third = values[i + 2];

      sumOfThree.add(first + second + third);

      if (i == 0) continue;

      final length = sumOfThree.length;

      if (sumOfThree[length - 1] > sumOfThree[length - 2]) {
        increasedValues++;
      }
    }

    return increasedValues;
  }

  final answer1 = await getIncreasedCount();
  final answer2 = await getIncreasedCountOfThree();

  print(answer1);
  print(answer2);
}
