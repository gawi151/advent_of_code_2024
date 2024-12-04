int part1(List<String> lines) {
  if (lines.isEmpty) return 0;
  final lineLength = lines[0].length;
  assert(lines.every((line) => line.length == lineLength));

  final searchTerms = ['XMAS', 'SAMX'];
  const searchTermLength = 4;

  bool isSearchTerm(String test) {
    assert(test.length == 4);
    return searchTerms.any((st) => st == test);
  }

  bool hasPotentialToBeTerm(String char) {
    assert(char.length == 1);
    return searchTerms.any((s) => s.startsWith(char));
  }

  var searchTermsFoundCount = 0;

  // lookup for search term from left to right, top to down
  // below picture of rays to lookup potential search terms
  // - - - -- - - -
  //     / | \
  //    /  |  \
  //   /   |   \
  for (var row = 0; row < lines.length; row++) {
    final line = lines[row];
    for (var col = 0; col < line.length; col++) {
      final char = line[col];
      if (hasPotentialToBeTerm(char)) {
        // if can do horizontal forward lookup
        final canLookupHorizontally = col + searchTermLength <= line.length;
        if (canLookupHorizontally) {
          final horizontalLookup = line.substring(col, col + searchTermLength);
          if (isSearchTerm(horizontalLookup)) {
            searchTermsFoundCount++;
          }
        }

        final canLookupVertically = row + searchTermLength <= lines.length;
        if (canLookupVertically) {
          final verticalLookup = lines
              .sublist(row, row + searchTermLength)
              .fold('', (s, l) => s + l[col]);
          if (isSearchTerm(verticalLookup)) {
            searchTermsFoundCount++;
          }
        }

        if (canLookupVertically && canLookupHorizontally) {
          final diagonalLookup = lines[row][col] +
              lines[row + 1][col + 1] +
              lines[row + 2][col + 2] +
              lines[row + 3][col + 3];
          if (isSearchTerm(diagonalLookup)) {
            searchTermsFoundCount++;
          }
        }

        if (canLookupVertically && col >= searchTermLength - 1) {
          final diagonalLookup = lines[row][col] +
              lines[row + 1][col - 1] +
              lines[row + 2][col - 2] +
              lines[row + 3][col - 3];
          if (isSearchTerm(diagonalLookup)) {
            searchTermsFoundCount++;
          }
        }
      } else {
        // skip if we don't find a character that starts the search term
      }
    }
  }

  return searchTermsFoundCount;
}

int part2(List<String> lines) {
  if (lines.isEmpty) return 0;
  final lineLength = lines[0].length;
  assert(lines.every((line) => line.length == lineLength));

  var patternCount = 0;
  final patternSize = 3;

  bool isMas(String test) {
    assert(test.length == 3);
    return ["MAS", "SAM"].any((st) => st == test);
  }

  for (var row = 0; row <= lines.length - patternSize; row++) {
    for (var col = 0; col <= lineLength - patternSize; col++) {
      // M.S  M.M  S.S  S.M
      // .A.  .A.  .A.  .A.
      // M.S  S.S  M.M  S.M
      final diag1 =
          lines[row][col] + lines[row + 1][col + 1] + lines[row + 2][col + 2];
      final diag2 =
          lines[row][col + 2] + lines[row + 1][col + 1] + lines[row + 2][col];
      if (isMas(diag1) && isMas(diag2)) {
        patternCount++;
      }
    }
  }

  return patternCount;
}
