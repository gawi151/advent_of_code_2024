import 'package:day1/day1.dart';
import 'package:test/test.dart';

void main() {
  test('day1 part 1 example test', () {
    const exampleInputText = '''3   4
4   3
2   5
1   3
3   9
3   3''';
    final lines = exampleInputText.split('\n');
    final (leftList, rightList) = extractLists(lines);
    final day1Result = day1Part1(leftList, rightList);
    expect(day1Result, 11);
  });

  test('day1 part 2 example test', () {
    final input = '''3   4
4   3
2   5
1   3
3   9
3   3''';
    final lines = input.split('\n');
    final (leftList, rightList) = extractLists(lines);
    final day1Result = day1Part2(leftList, rightList);
    expect(day1Result, 31);
  });
}
