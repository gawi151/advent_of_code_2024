import 'dart:io';

import 'package:test/test.dart';
import 'package:aoc2024/day5.dart';

void main() {
  test('part1', () {
    final lines = '''47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47'''.split('\n');
    final result = part1(lines);
    expect(result, 143);
  });

  test('part1 with real input', () async {
    final file = File('day5_input.txt');
    final lines = await file.readAsLines();
    final result = part1(lines);
    print(result);
    expect(result, 5208);
  });

  test('part2', () {
    final lines = '''47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47'''.split('\n');
    final result = part2(lines);
    expect(result, 123);
  });

  test('part2 with real input', () async {
    final file = File('day5_input.txt');
    final lines = await file.readAsLines();
    final result = part2(lines);
    print(result);
    expect(result, 6732);
  });
}
