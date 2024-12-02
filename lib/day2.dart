int day2Part1(List<String> lines) {
  final reports = lines
      .map(
        (lines) => lines.split(' ').map((e) => int.parse(e)).toList(),
      )
      .where(isSafe)
      .toList();
  return reports.length;
}

bool isSafe(List<int> report) {
  // Check if all adjacent pairs have valid differences (1-3)
  for (int i = 0; i < report.length - 1; i++) {
    if (!isPairSafe(report[i], report[i + 1])) {
      return false;
    }
  }

  // Check if sequence is consistently increasing or decreasing
  bool? increasing;
  for (int i = 0; i < report.length - 1; i++) {
    final currentIncreasing = isIncreasing(report[i], report[i + 1]);
    if (increasing == null) {
      increasing = currentIncreasing;
    } else if (increasing != currentIncreasing) {
      return false;
    }
  }

  return true;
}

bool isPairSafe(int first, int second) {
  final firstPairDiff = (first - second).abs();
  return firstPairDiff >= 1 && firstPairDiff <= 3;
}

bool isIncreasing(int first, int second) {
  return first < second;
}

int day2Part2(List<String> lines) {
  final reports = lines
      .map(
        (lines) => lines.split(' ').map((e) => int.parse(e)).toList(),
      )
      .map((e) => (e, isSafeWithDampner(e)))
      .toList();

  final safeReports = reports.where((e) => e.$2).toList();
  return safeReports.length;
}

bool isSafeWithDampner(List<int> report) {
  // First check if it's already safe without removing anything
  if (isSafe(report)) {
    return true;
  }

  // Try removing each number one at a time
  for (int i = 0; i < report.length; i++) {
    final withoutCurrent = List<int>.from(report)..removeAt(i);
    if (isSafe(withoutCurrent)) {
      return true;
    }
  }

  return false;
}
