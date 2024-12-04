import 'dart:io';

import 'package:test/test.dart';
import 'package:aoc2024/day4.dart';

void main() {
  test('part1', () {
    final lines = '''MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX'''
        .split('\n');
    final result = part1(lines);
    expect(result, 18);
  });

  test('part 1 with real input', () async {
    final file = File('day4_input.txt');
    final lines = await file.readAsLines();
    final result = part1(lines);
    expect(result, allOf(lessThan(3416), greaterThan(1736)));
  });

  test('part2', () {
    final lines = ''''''.split('\n');
    final result = part2(lines);
    expect(result, 0);
  });
}
