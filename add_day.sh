#!/bin/bash

# take first argument as day number
day=$1
# check if day number is provided
if [ -z "$day" ]; then
    echo "Please provide a day number"
    exit 1
fi

# check if day number is an integer
if ! [[ $day =~ ^[0-9]+$ ]]; then
    echo "Day number must be an integer"
    exit 1
fi

# check if day number is valid
if [ $day -lt 1 ] || [ $day -gt 25 ]; then
    echo "Invalid day number. Day number must be between 1 and 25"
    exit 1
fi

# create day{day}.dart to bin and lib directories
touch bin/day$day.dart
touch lib/day$day.dart

# create day{day}_test.dart to test directory
touch test/day${day}_test.dart

# create day{day}_input.txt in root 
touch day${day}_input.txt

# fill day{day}.dart with template
cat <<EOF > bin/day$day.dart
import 'dart:io';
import 'package:aoc2024/day$day.dart';

void main(List<String> arguments) async {
  print('Day $day');
  final file = File('day${day}_input.txt');
  final lines = await file.readAsLines();
  final part1Result = part1(lines);
  print('Part 1: \$part1Result');

  final part2Result = part2(lines);
  print('Part 2: \$part2Result');
}
EOF

# fill day{day}.dart with template
cat <<EOF > lib/day$day.dart
int part1(List<String> lines) {
  return 0;
}

int part2(List<String> lines) {
  return 0;
}
EOF

# fill day{day}_test.dart with template
cat <<EOF > test/day${day}_test.dart
import 'package:test/test.dart';
import 'package:aoc2024/day$day.dart';

void main() {
  test('part1', () {
    final lines = ''''''.split('\n');
    final result = part1(lines);
    expect(result, 0);
  });

  test('part2', () {
    final lines = ''''''.split('\n');
    final result = part2(lines);
    expect(result, 0);
  });
}
EOF
