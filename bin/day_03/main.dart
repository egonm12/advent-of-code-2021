import '../utils.dart';

Future<void> main() async {
  String gammaRate = '';
  String epsilonRate = '';

  const path = 'bin/day_03/input.txt';

  final List<String> values = await Utils.writeDataFromFileAsString(path, []);

  int bitToInt(String bit) {
    return int.parse(bit, radix: 2);
  }

  List<List<String>> splitStringChars(List<String> list) =>
      list.map((str) => str.split('')).toList();

  List<int> getNumberOfBits(List<List<String>> values, int index) {
    var zeros = 0;
    var ones = 0;

    for (final value in values) {
      value[index] == '0' ? zeros++ : ones++;
    }

    return [zeros, ones];
  }

  int getPowerConsumption() {
    final splitValues = splitStringChars(values);
    final bitLength = splitValues[0].length;

    for (var i = 0; i < bitLength; i++) {
      final numberOfBits = getNumberOfBits(splitValues, i);
      final countOfZeros = numberOfBits[0];
      final countOfOnes = numberOfBits[1];
      final gammaMatcher = countOfOnes > countOfZeros ? '1' : '0';
      final epsilonMatcher = countOfOnes > countOfZeros ? '0' : '1';

      gammaRate = '$gammaRate$gammaMatcher';
      epsilonRate = '$epsilonRate$epsilonMatcher';
    }

    return bitToInt(gammaRate) * bitToInt(epsilonRate);
  }

  int getRating(bool mostCommon) {
    final splitValues = splitStringChars(values);
    var originalValues = [...splitValues];

    var index = 0;

    while (originalValues.length > 1) {
      final numberOfBits = getNumberOfBits(originalValues, index);
      final matcher = mostCommon ? '1' : '0';
      final alternative = mostCommon ? '0' : '1';

      originalValues = originalValues
          .where(
            (value) =>
                value[index] ==
                (numberOfBits[0] > numberOfBits[1] ? alternative : matcher),
          )
          .toList();

      index++;
    }

    return bitToInt(originalValues[0].join(''));
  }

  print(getPowerConsumption());

  final oxygen = getRating(true);
  final co2 = getRating(false);

  print(oxygen * co2);
}
