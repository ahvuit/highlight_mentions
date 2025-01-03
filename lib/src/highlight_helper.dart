import 'package:flutter/material.dart';

/// A helper class to highlight specific text patterns within a string.
class HighlightHelper {
  /// Highlights specific patterns in the given [text].
  ///
  /// - [normalStyle]: The default text style for non-highlighted text.
  /// - [highlightedStyle]: The text style for highlighted mentions.
  /// - [specialStyle]: The text style for special mentions.
  /// - [mentionableNames]: A list of usernames to match for mentions.
  /// - [currentUsername]: The current user's username for personal mention.
  static List<TextSpan> highlightText(
      String text, {
        TextStyle? normalStyle,
        TextStyle? highlightedStyle,
        TextStyle? specialStyle,
        List<String>? mentionableNames,
        String? currentUsername,
        String? allPattern,
      }) {
    // Build the mention pattern dynamically.
    final namePattern = (mentionableNames ?? []).map(RegExp.escape).join('|');
    final allPatternEscaped = RegExp.escape(allPattern ?? 'All');
    final currentUsernameEscaped = RegExp.escape(currentUsername ?? '');

    final fullPattern = r'(@(' +
        allPatternEscaped +
        (currentUsernameEscaped.isNotEmpty ? r'|' + currentUsernameEscaped : '') +
        (namePattern.isNotEmpty ? r'|' + namePattern : '') +
        r'))';

    // Compile the regular expression.
    final regExp = RegExp(fullPattern);

    // Initialize the list of TextSpans to hold formatted parts of the text.
    final spans = <TextSpan>[];
    int currentIndex = 0;

    // Process all matches in the input text.
    for (final match in regExp.allMatches(text)) {
      // Add normal text before the match.
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: normalStyle ?? TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        );
      }

      // Determine the correct style for the match.
      TextStyle? matchStyle;
      final matchText = match.group(0);

      // Special case for the 'allPattern'.
      if (matchText == '@$allPatternEscaped') {
        matchStyle = specialStyle ?? TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
      } else {
        matchStyle = highlightedStyle ??
            TextStyle(color: (matchText == '@$currentUsername' ? Colors.red : Colors.blue), fontWeight: FontWeight.bold);
      }

      // Add the match as a TextSpan with the determined style.
      spans.add(
        TextSpan(
          text: matchText,
          style: matchStyle,
        ),
      );

      // Update the index to continue after this match.
      currentIndex = match.end;
    }

    // Add remaining normal text after the last match.
    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: normalStyle ?? TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      );
    }

    return spans;
  }
}