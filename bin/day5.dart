import 'dart:io';
import 'package:aoc2024/day5.dart';

void main(List<String> arguments) async {
  print('Day 5');
  final file = File('day5_input.txt');
  final lines = await file.readAsLines();
  final part1Result = part1(lines);
  print('Part 1: $part1Result');

  final part2Result = part2(lines);
  print('Part 2: $part2Result');
}
