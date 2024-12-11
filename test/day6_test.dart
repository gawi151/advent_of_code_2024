import 'dart:io';

import 'package:test/test.dart';
import 'package:aoc2024/day6.dart';

void main() {
  test('part1', () {
    final lines = '''....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...'''.split('\n');
    final result = part1(lines);
    expect(result, 41);
  });

  test('part1 with real input', () async {
    final file = File('day6_input.txt');
    final lines = await file.readAsLines();
    final result = part1(lines);
    expect(result, 5534);
  });

  test('part2', () {
    final lines = '''....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...'''.split('\n');
    final result = part2(lines);
    expect(result, 6);
  });

  test('part2 with real input', () async {
    final file = File('day6_input.txt');
    final lines = await file.readAsLines();
    final result = part2(lines);
    expect(result, 2262);
  });
}
