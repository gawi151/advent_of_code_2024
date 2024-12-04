int part1(List<String> lines) {
  final regex = RegExp(r'mul\((\d+),(\d+)\)');
  final sum = lines.map((line) => sumMuls(line, regex)).reduce((a, b) => a + b);
  return sum;
}

int sumMuls(String line, RegExp regex) {
  final matchedGroups = regex
      .allMatches(line)
      .map((match) => match.groups([1, 2]))
      .where((groups) => groups.every((group) => group != null))
      .map((groups) => groups.map((g) => g!).toList())
      .toList();

  print('matched groups: $matchedGroups');

  final sum = matchedGroups
      .map((params) => mul(int.parse(params[0]), int.parse(params[1])))
      .fold(0, (sum, value) => sum + value);
  return sum;
}

int mul(int a, int b) {
  return a * b;
}

int part2(String input) {
  return sumMulsPart2(input);
}

int sumMulsPart2(String line) {
  final mulRegex = RegExp(r'mul\((\d+),(\d+)\)');
  final controlRegex = RegExp(r"(?:do|don\'t)\(\)");

  var sum = 0;
  var isEnabled = true;
  var position = 0;

  final allControls = controlRegex.allMatches(line).toList();
  final allMuls = mulRegex.allMatches(line).toList();

  for (final m in allMuls) {
    final lastControl = allControls
        .where(
            (control) => control.start < m.start && control.start >= position)
        .lastOrNull;

    if (lastControl != null) {
      final controlString = line.substring(lastControl.start, lastControl.end);
      isEnabled = controlString.startsWith('do()');
      position = lastControl.end;
    }

    if (isEnabled) {
      final a = int.parse(m.group(1)!);
      final b = int.parse(m.group(2)!);
      sum += mul(a, b);
    }
  }

  return sum;
}
