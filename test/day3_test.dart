import 'dart:io';

import 'package:test/test.dart';
import 'package:aoc2024/day3.dart';

void main() {
  test('part1', () {
    final lines =
        '''xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'''
            .split('\n');
    final result = part1(lines);
    expect(result, 161);
  });

  test('part2', () async {
    final file = File('day3_input.txt');
    final lines = await file.readAsString();
    final result = part2(lines);
    expect(result, lessThan(94810037));
  });
}
