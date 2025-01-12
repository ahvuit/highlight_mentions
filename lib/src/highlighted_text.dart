import 'package:flutter/widgets.dart';
import 'highlight_helper.dart';

/// A widget that highlights specific parts of a text based on provided styles and patterns.
///
/// This widget uses `RichText` to display styled text spans, allowing for customized
/// highlighting of mentions, special patterns, or the current user's name.
///
/// Example usage:
/// ```dart
/// HighlightedText(
///   input: '@John Hello there! @Jane is here.',
///   normalStyle: TextStyle(color: Colors.black),
///   highlightedStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
///   specialStyle: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
///   mentionableNames: ['John', 'Jane'],
///   currentUsername: 'Jane',
/// )
/// ```
class HighlightedText extends StatelessWidget {
  /// The input text to be processed and displayed.
  final String input;

  /// Style applied to the normal (non-highlighted) text.
  final TextStyle? normalStyle;

  /// Style applied to highlighted mentions or matched patterns.
  final TextStyle? highlightedStyle;

  /// Style applied to special patterns such as the current username.
  final TextStyle? specialStyle;

  /// List of mentionable names to be highlighted in the text.
  final List<String>? mentionableNames;

  /// The current user's username, which can be styled differently if found in the text.
  final String? currentUsername;

  /// A regex pattern that matches "all" mentions (e.g., `@all` or similar patterns).
  final String? allPattern;

  /// Maximum number of lines to display in the widget.
  final int? maxLines;

  /// Overflow behavior for text that exceeds the maximum lines or available space.
  final TextOverflow? overflow;

  /// Alignment of the text within the widget.
  final TextAlign? textAlign;

  /// Constructor to initialize the `HighlightedText` widget.
  const HighlightedText({
    super.key,
    required this.input,
    this.normalStyle,
    this.highlightedStyle,
    this.specialStyle,
    this.mentionableNames,
    this.currentUsername,
    this.allPattern,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      // Align the text, defaulting to `TextAlign.start` if not specified.
      textAlign: textAlign ?? TextAlign.start,

      // Limit the number of lines to display if `maxLines` is provided.
      maxLines: maxLines,

      // Handle overflow behavior, defaulting to `TextOverflow.clip` if not specified.
      overflow: overflow ?? TextOverflow.clip,

      // Build the text spans using the `HighlightHelper.highlightText` method.
      text: TextSpan(
        children: HighlightHelper.highlightText(
          input,
          normalStyle: normalStyle,
          highlightedStyle: highlightedStyle,
          specialStyle: specialStyle,
          mentionableNames: mentionableNames,
          currentUsername: currentUsername,
          allPattern: allPattern,
        ),
      ),
    );
  }
}