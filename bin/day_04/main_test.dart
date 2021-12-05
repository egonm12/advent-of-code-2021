import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import 'main.dart';

void main() {
  final numbers = [
    7,
    4,
    9,
    5,
    11,
    17,
    23,
    2,
    0,
    14,
    21,
    24,
    10,
    16,
    13,
    6,
    15,
    25,
    12,
    22,
    18,
    20,
    8,
    19,
    3,
    26,
    1
  ];
  final path = 'bin/day_04/input_test.txt';

  group('utils', () {
    group('readBoardInput', () {
      test(
          'reads the board input and filters out empty lines returned as a List with a List of Strings per line',
          () async {
        final expected = [
          [22, 13, 17, 11, 0],
          [8, 2, 23, 4, 24],
          [21, 9, 14, 16, 7],
          [6, 10, 3, 18, 5],
          [1, 12, 20, 15, 19],
          [3, 15, 0, 2, 22],
          [9, 18, 13, 17, 5],
          [19, 8, 7, 25, 23],
          [20, 11, 10, 24, 4],
          [14, 21, 16, 12, 6],
          [14, 21, 17, 24, 4],
          [10, 16, 15, 9, 19],
          [18, 8, 23, 26, 20],
          [22, 11, 13, 6, 5],
          [2, 0, 12, 3, 7]
        ];

        expect(await readBoardInput(path), expected);
        expect([1, 2], [1, 2]);
      });
    });

    group('flatten', () {
      test('flattens a nested collection of lists to a single list', () {
        final list = [
          [
            1,
            2,
            [3]
          ]
        ];

        expect(flatten(list), [1, 2, 3]);
      });
    });

    group("getRandomNumber", () {
      test('returns a random number and removes the item from the input', () {
        final copyNumbers = [...numbers];

        final randomNumber = getRandomNumber(numbers);

        expect(copyNumbers.contains(randomNumber), true);
        expect(numbers.contains(randomNumber), false);
      });
    });

    group('getBoards', () {
      test(
          'returns the correct number of boards with the correct amount of numbers',
          () async {
        final boards = await getBoards(path);

        expect(boards.length, 3);

        print(boards);
        for (final board in boards) {
          expect(board.length, boardWidth);
        }
      });
    });

    group('markNumber', () {
      test('replaces the value with -1 if the number is found on the board',
          () {
        final board = [
          [1, 2, 3]
        ];

        markNumber(3, board);

        expect(board, [
          [1, 2, -1]
        ]);
      });

      test('leaves the board unchanged if the number is not found on the board',
          () {
        final board = [
          [1, 2, 3]
        ];

        markNumber(4, board);

        expect(board, [
          [1, 2, 3]
        ]);
      });
    });

    group('columnsToRows', () {
      test('converts the columns to rows', () {
        final input = [
          [22, -1, 17, 11, 0],
          [8, -1, 23, 4, 24],
          [21, -1, 14, 16, 7],
          [6, -1, 3, 18, 5],
          [1, -1, 20, 15, 19],
        ];
        final expected = [
          [22, 8, 21, 6, 1],
          [-1, -1, -1, -1, -1],
          [17, 23, 14, 3, 20],
          [11, 4, 16, 18, 15],
          [0, 24, 7, 5, 19],
        ];

        expect(columnsToRows(input), expected);
      });
    });

    group('checkIfWon', () {
      test(
          'returns true when a step of of 5 numbers after each other are marked as -1',
          () {
        final board = [
          [22, 13, 17, 11, 0],
          [-1, -1, -1, -1, -1],
          [21, 9, 14, 16, 7],
          [6, 10, 3, 18, 5],
          [1, 12, 20, 15, 19],
        ];

        expect(checkIfWon(board), true);
      });

      test(
          'returns true when numbers 5 places from each other are marked as -1',
          () {
        final board = [
          [22, -1, 17, 11, 0],
          [8, -1, 23, 4, 24],
          [21, -1, 14, 16, 7],
          [6, -1, 3, 18, 5],
          [1, -1, 20, 15, 19],
        ];

        expect(checkIfWon(columnsToRows(board)), true);
      });
    });
  });

  test('runBingo', () async {
    final output = await runBingo(numbers, path);
    expect(output, 4512);
  });
}
