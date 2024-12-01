(List<int>, List<int>) extractLists(List<String> lines) {
  // create lists
  final leftList = List.filled(lines.length, 0, growable: false);
  final rightList = List.of(leftList, growable: false);

  for (var i = 0; i < lines.length; i++) {
    final split = lines[i].split('   ');
    leftList[i] = int.parse(split[0]);
    rightList[i] = int.parse(split[1]);
  }

  return (leftList, rightList);
}

int day1Part1(List<int> leftList, List<int> rightList) {
  var result = 0;

  leftList.sort();
  rightList.sort();

  for (var i = 0; i < leftList.length; i++) {
    final left = leftList[i];
    final right = rightList[i];
    result += (left - right).abs();
  }

  return result;
}

int day1Part2(List<int> leftList, List<int> rightList) {
  final countMap = <int, int>{};

  for (var i = 0; i < rightList.length; i++) {
    final number = rightList[i];
    countMap[number] = (countMap[number] ?? 0) + 1;
  }

  var result = 0;
  for (final i in leftList) {
    final count = countMap[i] ?? 0;
    result += i * count;
  }

  return result;
}
