import 'dart:convert';
import 'dart:io';
import 'dart:math';

final numbers = [
  13,
  47,
  64,
  52,
  60,
  69,
  80,
  85,
  57,
  1,
  2,
  6,
  30,
  81,
  86,
  40,
  27,
  26,
  97,
  77,
  70,
  92,
  43,
  94,
  8,
  78,
  3,
  88,
  93,
  17,
  55,
  49,
  32,
  59,
  51,
  28,
  33,
  41,
  83,
  67,
  11,
  91,
  53,
  36,
  96,
  7,
  34,
  79,
  98,
  72,
  39,
  56,
  31,
  75,
  82,
  62,
  99,
  66,
  29,
  58,
  9,
  50,
  54,
  12,
  45,
  68,
  4,
  46,
  38,
  21,
  24,
  18,
  44,
  48,
  16,
  61,
  19,
  0,
  90,
  35,
  65,
  37,
  73,
  20,
  22,
  89,
  42,
  23,
  15,
  87,
  74,
  10,
  71,
  25,
  14,
  76,
  84,
  5,
  63,
  95
];
final List<int> list = [];
final boardHeight = 5;
final boardWidth = 5;

List<T> flatten<T>(Iterable<dynamic> list) => [
      for (var element in list)
        if (element is! Iterable) element else ...flatten(element),
    ];

Future<List<List<int>>> readBoardInput(String path) async =>
    await File('${Directory.current.path}/$path')
        .openRead()
        .map(utf8.decode)
        .transform(LineSplitter())
        .where((line) => line.isNotEmpty)
        .map(
          (line) => line
              .split(' ')
              .where(
                (element) => element.isNotEmpty,
              )
              .map((e) => int.parse(e))
              .toList(),
        )
        .toList();

Future<List<List<List<int>>>> getBoards(String path) async {
  final boardInput = await readBoardInput(path);

  final List<List<List<int>>> splitBoards = [];
  final maxIterations = boardInput.length / boardHeight;

  for (var i = 0; i < maxIterations; i++) {
    final board = boardInput.skip(i * 5).take(boardHeight).toList();

    splitBoards.add(board);
  }

  return splitBoards;
}

int getRandomNumber([List<int>? numbersFoo]) {
  final input = numbersFoo ?? numbers;
  final randomIndex = Random().nextInt(input.length - 1);

  final randomNumber = input[randomIndex];
  input.removeAt(randomIndex);

  return randomNumber;
}

void markNumber(int drawnNumber, List<List<int>> board) {
  int? rowIndex;
  int? valueIndex;

  for (var row = 0; row < board.length; row++) {
    final index = board[row].indexWhere((element) => element == drawnNumber);
    if (index != -1) {
      valueIndex = index;
      rowIndex = row;
    }
  }

  if (valueIndex == null || rowIndex == null) return;

  board[rowIndex][valueIndex] = -1;
}

List<List<int>> columnsToRows(List<List<int>> board) {
  final List<List<int>> rows = [];

  for (var i = 0; i < boardHeight; i++) {
    final List<int> row = [];

    for (var j = 0; j < boardWidth; j++) {
      final value = board[j][i];

      row.add(value);
    }

    rows.add(row);
  }

  return rows.toList();
}

bool checkIfWon(List<List<int>> board) {
  for (var i = 0; i < boardWidth; i++) {
    final row = board[i];

    if (row.where((element) => element == -1).length == boardWidth) {
      return true;
    }
  }

  return false;
}

int sum(List<int> values) => values.fold(0, (int p, c) => p + c);

Future<int> runBingoUntilFirstWin(List<int> numbers, path) async {
  final boards = await getBoards(path);

  List<List<int>>? winningBoard;
  int? bingoNumber;
  var won = false;
  var turn = 0;

  while (won == false) {
    final number = numbers[turn];

    for (var index = 0; index < boards.length; index++) {
      final board = boards[index];
      markNumber(number, board);

      final checkRows = checkIfWon(board);
      final checkColumns = checkIfWon(columnsToRows(board));

      if (checkRows || checkColumns) {
        won = true;
        winningBoard = board;
        bingoNumber = number;
      }
    }
    turn++;
  }

  final flattenedUnmarkedNumbers =
      flatten<int>(winningBoard!).where((value) => value != -1).toList();
  final sumOfUnmarkedNumbers = sum(flattenedUnmarkedNumbers);

  return bingoNumber! * sumOfUnmarkedNumbers;
}

void main() async {
  final output = await runBingoUntilFirstWin(numbers, 'bin/day_04/input.txt');
  print(output);
}
