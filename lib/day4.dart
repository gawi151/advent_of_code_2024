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
  // - - - -
  // | \
  // |  \
  // |   \
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
            // print('horizontal found: $horizontalLookup');
            searchTermsFoundCount++;
          } else {
            // print('horizontal lookup fail: $horizontalLookup');
          }
        }

        // if can do horizontal backward lookup
        final canLookupHorizontallyBackwards = col >= searchTermLength;
        if (canLookupHorizontallyBackwards) {
          final horizontalLookup =
              line.substring(col - searchTermLength, col);
          if (isSearchTerm(horizontalLookup)) {
            // print('horizontal backwards found: $horizontalLookup');
            searchTermsFoundCount++;
          } else {
            // print('horizontal backwards lookup fail: $horizontalLookup');
          }
        }

        final canLookupVertically = row + searchTermLength <= lines.length;
        if (canLookupVertically) {
          final verticalLookup = lines
              .sublist(row, row + searchTermLength)
              .fold('', (s, l) => s + l[col]);
          if (isSearchTerm(verticalLookup)) {
            // print('vertical found: $verticalLookup');
            searchTermsFoundCount++;
          } else {
            // print('vertical lookup fail: $verticalLookup');
          }
        }

        final canLookupVerticallyBackwards = row >= searchTermLength;
        if (canLookupVerticallyBackwards) {
          final verticalLookup = lines
              .sublist(row - searchTermLength, row)
              .fold('', (s, l) => s + l[col]);
          if (isSearchTerm(verticalLookup)) {
            // print('vertical backwards found: $verticalLookup');
            searchTermsFoundCount++;
          } else {
            // print('vertical backwards lookup fail: $verticalLookup');
          }
        }

        if (canLookupVertically && canLookupHorizontally) {
          final diagonalLookup = lines[row][col] +
              lines[row + 1][col + 1] +
              lines[row + 2][col + 2] +
              lines[row + 3][col + 3];
          if (isSearchTerm(diagonalLookup)) {
            // print('diagonal found: $diagonalLookup');
            searchTermsFoundCount++;
          } else {
            // print('diagonal lookup fail: $diagonalLookup');
          }
        }

        if (canLookupVertically && canLookupHorizontallyBackwards) {
          final diagonalLookup = lines[row][col] +
              lines[row + 1][col - 1] +
              lines[row + 2][col - 2] +
              lines[row + 3][col - 3];
          if (isSearchTerm(diagonalLookup)) {
            // print('diagonal backwards found: $diagonalLookup');
            searchTermsFoundCount++;
          } else {
            // print('diagonal backwards lookup fail: $diagonalLookup');
          }
        }

        if (canLookupVerticallyBackwards && canLookupHorizontally) {
          final diagonalLookup = lines[row - 3][col] +
              lines[row - 2][col + 1] +
              lines[row - 1][col + 2] +
              lines[row][col + 3];
          if (isSearchTerm(diagonalLookup)) {
            // print('diagonal backwards found: $diagonalLookup');
            searchTermsFoundCount++;
          } else {
            // print('diagonal backwards lookup fail: $diagonalLookup');
          }
        }

        if (canLookupVerticallyBackwards && canLookupHorizontallyBackwards) {
          final diagonalLookup = lines[row - 3][col] +
              lines[row - 2][col - 1] +
              lines[row - 1][col - 2] +
              lines[row][col - 3];
          if (isSearchTerm(diagonalLookup)) {
            // print('diagonal backwards found: $diagonalLookup');
            searchTermsFoundCount++;
          } else {
            // print('diagonal backwards lookup fail: $diagonalLookup');
          }
        }
      } else {
        // print('skipping char: $char');
        // skip if we don't find a character that starts the search term
      }
    }
  }

  return searchTermsFoundCount;
}

int part2(List<String> lines) {
  return 0;
}
