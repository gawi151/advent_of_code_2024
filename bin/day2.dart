import 'dart:io';
import 'package:aoc2024/day2.dart';

void main(List<String> arguments) async {
  final file = File('day2_input.txt');
  final lines = await file.readAsLines();
  final day2Result = day2Part1(lines);
  print('Day 2 Part 1: $day2Result');

  final day2Part2Result = day2Part2(lines);
  print('Day 2 Part 2: $day2Part2Result');
}
