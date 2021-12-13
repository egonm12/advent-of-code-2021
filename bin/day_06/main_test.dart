import 'package:test/test.dart';

import 'main.dart';

void main() {
  final initialLanternFish = [3, 4, 3, 1, 2];

  test(
      'returns the correct number of lanternFish depending on the number of days',
      () {
    final result = updateInternalTimers(initialLanternFish, 80);
    expect(result, 5934);
  });

  // test(
  //     'returns the correct number of lanternFish depending on the number of days',
  //     () {
  //   final result = updateInternalTimers(initialLanternFish, 256);
  //   expect(result, 26984457539);
  // });
}
