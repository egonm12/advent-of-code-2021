import '../utils.dart';

Future<void> main() async {
  final path = 'bin/day_02/input.txt';

  final data = await Utils.writeDataFromFile(path, <Map<String, int>>[]);

  int getFinalPosition() {
    var horizontalPos = 0;
    var depthPos = 0;

    for (final movement in data) {
      for (final movement in movement.entries) {
        if (movement.key == 'forward') {
          horizontalPos += movement.value;
        } else if (movement.key == 'up') {
          depthPos -= movement.value;
        } else {
          depthPos += movement.value;
        }
      }
    }
    print('$horizontalPos * $depthPos');
    return horizontalPos * depthPos;
  }

  int getFinalPositionWithAim() {
    var horizontalPos = 0;
    var depthPos = 0;
    var aim = 0;

    for (final movement in data) {
      for (final movement in movement.entries) {
        if (movement.key == 'forward') {
          horizontalPos += movement.value;
          depthPos = depthPos + aim * movement.value;
        } else if (movement.key == 'up') {
          aim -= movement.value;
        } else {
          aim += movement.value;
        }
      }
    }
    print('$horizontalPos * $depthPos');
    return horizontalPos * depthPos;
  }

  print(getFinalPosition());
  print(getFinalPositionWithAim());
}
