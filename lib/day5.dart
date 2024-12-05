import 'package:collection/collection.dart';

int part1(List<String> lines) {
  final rules = <int, List<int>>{};
  var result = 0;

  for (final line in lines) {
    if (isRule(line)) {
      addOrUpdateRule(line, rules);
    }
    if (isUpdate(line)) {
      final update = parseUpdate(line);
      if (hasCorrectOrder(update, rules)) {
        result += middle(update);
      }
    }
  }

  return result;
}

int part2(List<String> lines) {
  final rules = <int, List<int>>{};
  var result = 0;

  for (final line in lines) {
    if (isRule(line)) {
      addOrUpdateRule(line, rules);
    }
    if (isUpdate(line)) {
      final update = parseUpdate(line);
      if (!hasCorrectOrder(update, rules)) {
        result += middle(sort(update, rules));
      }
    }
  }

  return result;
}

List<int> parseUpdate(String line) => line.split(',').map(int.parse).toList();

bool hasCorrectOrder(List<int> update, Map<int, List<int>> rules) {
  return update.isSorted((a, b) => orderComparator(rules, a, b));
}

List<int> sort(List<int> list, Map<int, List<int>> rules) {
  return list.sorted((a, b) => orderComparator(rules, a, b));
}

int orderComparator(Map<int, List<int>> rules, int a, int b) {
  final currRules = rules[a];
  final nextRules = rules[b];
  if (currRules != null && currRules.contains(b)) {
    return -1;
  } else if (nextRules != null && nextRules.contains(a)) {
    return 1;
  } else {
    return 0;
  }
}

int middle(List<int> list) {
  return list[list.length ~/ 2];
}

bool isRule(String line) {
  return line.contains('|');
}

bool isUpdate(String line) {
  return line.contains(',');
}

void addOrUpdateRule(String line, Map<int, List<int>> rules) {
  final [p1, p2] = line.split('|').map(int.parse).toList();
  if (!rules.containsKey(p1)) {
    rules[p1] = [p2];
  } else {
    rules[p1]!.add(p2);
  }
}
