import 'dart:io';

import 'package:day1/day1.dart';

void main(List<String> arguments) async {
  final file = File('input.txt');
  final lines = await file.readAsLines();

  // create lists
  final (leftList, rightList) = extractLists(lines);

  final day1Part1Result = day1Part1(leftList, rightList);
  print('Part 1: $day1Part1Result');

  final day1Part2Result = day1Part2(leftList, rightList);
  print('Part 2: $day1Part2Result');
}
