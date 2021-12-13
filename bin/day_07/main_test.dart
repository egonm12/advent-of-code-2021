import 'package:test/test.dart';

import 'main.dart';

void main() {
  final crabPositions = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14];

  test('returns the position that costs the least amount of fuel', () {
    expect(getPosition(crabPositions), 37);
  });

  test('returns the position expensive that costs the least amount of fuel',
      () {
    expect(getPositionExpensive(crabPositions), 168);
  });
}
