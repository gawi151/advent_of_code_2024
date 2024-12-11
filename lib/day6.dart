// If there is something directly in front of you, turn right 90 degrees.
// Otherwise, take a step forward.
import 'package:collection/collection.dart';
import 'dart:isolate';

typedef Pos = (int x, int y);

extension PosExtension on Pos {
  int get x => this.$1;
  int get y => this.$2;
}

int part1(List<String> lines) {
  final start = findStart(lines);
  final (x, y) = start;
  print('checking start: ($start) -> ${lines[y][x]}');
  int positions = walk(lines, start);
  print('visited positions: $positions');
  return positions;
}

Pos findStart(List<String> lines) {
  var start = (0, 0);
  lines.forEachIndexedWhile((int y, String line) {
    final x = line.indexOf('^');
    if (x != -1) {
      start = (x, y);
      return false;
    }
    return true;
  });
  return start;
}

enum Direction {
  up((0, -1)),
  down((0, 1)),
  left((-1, 0)),
  right((1, 0));

  const Direction(this.posDiff);

  final Pos posDiff;
  int get dx => posDiff.x;
  int get dy => posDiff.y;

  Direction turnRight() {
    switch (this) {
      case Direction.up:
        return Direction.right;
      case Direction.down:
        return Direction.left;
      case Direction.left:
        return Direction.up;
      case Direction.right:
        return Direction.down;
    }
  }
}

int walk(List<String> lines, Pos start) {
  var direction = Direction.up;
  final maxX = lines[0].length;
  final maxY = lines.length;
  final max = (maxX, maxY);
  var (currX, currY) = start;
  final visited = {(currX, currY)};

  while (isInBounds(start, max)) {
    final (nextX, nextY) = (currX + direction.dx, currY + direction.dy);
    if (!isInBounds((nextX, nextY), max)) break;

    if (lines[nextY][nextX] == '#') {
      direction = direction.turnRight();
    } else {
      currX = nextX;
      currY = nextY;
      visited.add((currX, currY));
    }
  }

  return visited.length;
}

bool isInBounds(Pos pos, Pos max) {
  final (x, y) = pos;
  final (maxX, maxY) = max;
  return x >= 0 && x < maxX && y >= 0 && y < maxY;
}

typedef Visited = (Pos pos, Direction dir);

typedef GridData = ({
  Pos max,
  Pos start,
  Set<Pos> obstacles,
  List<Pos> positionsToCheck,
  int chunkIndex,
  int totalChunks
});

typedef IsolateResult = ({
  List<bool> results,
  int chunkIndex,
  Duration duration
});

void isolateFunction(List<dynamic> message) {
  final sendPort = message[0] as SendPort;
  final data = message[1] as GridData;
  final startTime = DateTime.now();

  final results = <bool>[];
  var loopsFound = 0;

  for (var i = 0; i < data.positionsToCheck.length; i++) {
    final pos = data.positionsToCheck[i];
    final isLoop = willLoopOptimized(data.max, data.start, pos, data.obstacles);
    if (isLoop) loopsFound++;
    results.add(isLoop);

    if ((i + 1) % 100 == 0) {
      final progress =
          ((i + 1) / data.positionsToCheck.length * 100).toStringAsFixed(1);
      print(
          'Chunk ${data.chunkIndex + 1}/${data.totalChunks}: $progress% - Loops found: $loopsFound');
    }
  }

  final duration = DateTime.now().difference(startTime);
  print(
      'Chunk ${data.chunkIndex + 1}/${data.totalChunks} completed in ${duration.inSeconds}s - Found $loopsFound loops');

  final result = (
    results: results,
    chunkIndex: data.chunkIndex,
    duration: duration,
  );
  sendPort.send(result);
}

Future<int> part2(List<String> lines) async {
  final start = findStart(lines);
  final startTime = DateTime.now();

  final maxX = lines[0].length;
  final maxY = lines.length;
  final max = (maxX, maxY);
  final obstacles = <Pos>{};
  final positionsToCheck = <Pos>[];

  for (var y = 0; y < maxY; y++) {
    for (var x = 0; x < maxX; x++) {
      final pos = (x, y);
      if (lines[y][x] == '#') {
        obstacles.add(pos);
      } else if (pos != start && lines[y][x] != '^') {
        positionsToCheck.add(pos);
      }
    }
  }

  final numIsolates = 8;
  final chunkSize = (positionsToCheck.length / numIsolates).ceil();
  final chunks = <List<Pos>>[];

  for (var i = 0; i < positionsToCheck.length; i += chunkSize) {
    final end = (i + chunkSize < positionsToCheck.length)
        ? i + chunkSize
        : positionsToCheck.length;
    chunks.add(positionsToCheck.sublist(i, end));
  }

  final futures = chunks.asMap().entries.map((entry) async {
    final receivePort = ReceivePort();
    final data = (
      max: max,
      start: start,
      obstacles: obstacles,
      positionsToCheck: entry.value,
      chunkIndex: entry.key,
      totalChunks: chunks.length,
    );

    await Isolate.spawn(
      isolateFunction,
      [receivePort.sendPort, data],
    );

    final result = await receivePort.first as IsolateResult;
    receivePort.close();
    return result;
  }).toList();

  final results = await futures.wait;
  final possibleObstructionPositions = results.fold(0, (sum, result) {
    final loopsFound = result.results.where((b) => b).length;
    return sum + loopsFound;
  });

  final totalTime = DateTime.now().difference(startTime);
  print(
      '\nAll chunks completed in ${totalTime.inSeconds}s - Found $possibleObstructionPositions possible positions');
  return possibleObstructionPositions;
}

bool willLoopOptimized(
  Pos max,
  Pos start,
  Pos obstruction,
  Set<Pos> obstacles,
) {
  final (maxX, maxY) = max;
  var (currX, currY) = start;
  var direction = Direction.up;

  final visited = <Visited>{};
  var steps = 0;
  final maxSteps = maxX * maxY * 4;

  while (currX >= 0 && currX < maxX && currY >= 0 && currY < maxY) {
    steps++;
    if (steps > maxSteps) return false;

    final (nextX, nextY) = (currX + direction.dx, currY + direction.dy);
    final nextPos = (nextX, nextY);

    if (nextX < 0 || nextX >= maxX || nextY < 0 || nextY >= maxY) return false;

    final currentState = ((currX, currY), direction);
    if (visited.contains(currentState)) return true;
    visited.add(currentState);

    if (nextPos == obstruction || obstacles.contains(nextPos)) {
      direction = direction.turnRight();
    } else {
      currX = nextX;
      currY = nextY;
    }
  }

  return false;
}
