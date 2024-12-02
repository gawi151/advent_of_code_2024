import 'package:aoc2024/day2.dart';
import 'package:test/test.dart';

void main() {
  test('day2 part 1 example test', () {
    final lines = '''7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
'''
        .split('\n');
    final day2Result = day2(lines);
  });
}
