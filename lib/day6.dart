// If there is something directly in front of you, turn right 90 degrees.
// Otherwise, take a step forward.
import 'package:collection/collection.dart';

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

int part2(List<String> lines) {
  final start = findStart(lines);
  var possibleObstructionPositions = 0;
  var checked = 0;
  final totalPositions = lines.length * lines[0].length;
  final startTime = DateTime.now();

  // Pre-compute grid boundaries
  final maxX = lines[0].length;
  final maxY = lines.length;
  final max = (maxX, maxY);

  // Create a quick lookup for obstacles
  final obstacles = <Pos>{};
  for (var y = 0; y < maxY; y++) {
    for (var x = 0; x < maxX; x++) {
      if (lines[y][x] == '#') {
        obstacles.add((x, y));
      }
    }
  }

  for (var y = 0; y < lines.length; y++) {
    for (var x = 0; x < lines[y].length; x++) {
      checked++;
      if (checked % 100 == 0) {
        final progress = (checked / totalPositions * 100).toStringAsFixed(1);
        final elapsed = DateTime.now().difference(startTime);
        print(
            'Progress: $progress% ($checked/$totalPositions) - Time elapsed: ${elapsed.inSeconds}s');
      }

      final obstructionPos = (x, y);
      if (obstructionPos == start) continue;
      if (obstacles.contains(obstructionPos)) continue;

      if (willLoop(max, start, obstructionPos, obstacles)) {
        possibleObstructionPositions++;
        print(
            'Found loop at ($x, $y) - Total loops found: $possibleObstructionPositions');
      }
    }
  }

  final totalTime = DateTime.now().difference(startTime);
  print(
      'Completed in ${totalTime.inSeconds}s - Found $possibleObstructionPositions possible positions');
  return possibleObstructionPositions;
}

bool willLoop(
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
