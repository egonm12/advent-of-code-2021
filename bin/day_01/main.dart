import '../utils.dart';

Future<void> main() async {
  const path = 'bin/day_01/input.txt';

  final List<int> values = await Utils.writeDataFromFile(path, <int>[]);

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
    final List<int> collection = [];

    for (var i = 0; i < values.length - 2; i++) {
      final measurements = values.getRange(i, i + 3);
      final sumOfThree = measurements.fold(0, (int p, int c) => p + c);

      collection.add(sumOfThree);

      if (i == 0) continue;

      final collectionLength = collection.length;

      if (collection[collectionLength - 1] > collection[collectionLength - 2]) {
        increasedValues++;
      }
    }

    return increasedValues;
  }

  final answer1 = await getIncreasedCount();
  final answer2 = await getIncreasedCountOfThree();

  print('1387 $answer1');
  print('1362 $answer2');
}
