import 'package:flutter/widgets.dart';
import 'highlight_helper.dart';

/// A custom `TextEditingController` that highlights mentions within the text.
///
/// This controller works in conjunction with a `TextField` or `EditableText` widget.
/// It allows the text to be styled dynamically based on specific rules, such as
/// highlighting mentions, special patterns, or the current user's username.
///
/// Example usage:
/// ```dart
/// HighlightTextEditingController controller = HighlightTextEditingController(
///   normalStyle: TextStyle(color: Colors.black),
///   highlightedStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
///   specialStyle: TextStyle(color: Colors.green),
///   mentionableNames: ['Alice', 'Bob'],
///   currentUsername: 'Bob',
///   allPattern: 'all',
/// );
///
/// TextField(
///   controller: controller,
///   decoration: InputDecoration(hintText: 'Type a message...'),
/// );
/// ```
class HighlightTextEditingController extends TextEditingController {
  /// The default style for normal (non-highlighted) text.
  final TextStyle? normalStyle;

  /// The style applied to highlighted mentions or patterns.
  final TextStyle? highlightedStyle;

  /// The style applied to special patterns such as the current username.
  final TextStyle? specialStyle;

  /// A list of names that should be highlighted as mentions.
  final List<String>? mentionableNames;

  /// The current user's username, which can have a unique style if found in the text.
  final String? currentUsername;

  /// A regex pattern to identify "all" mentions (e.g., `@all`).
  final String? allPattern;

  /// Constructor for `HighlightTextEditingController`.
  ///
  /// Accepts optional text to initialize the controller and styles for various parts of the text.
  HighlightTextEditingController({
    super.text,
    this.normalStyle,
    this.highlightedStyle,
    this.specialStyle,
    this.mentionableNames,
    this.currentUsername,
    this.allPattern,
  });

  /// Builds a `TextSpan` with the text content styled dynamically.
  ///
  /// The method uses the `HighlightHelper.highlightText` function to generate
  /// a list of styled spans based on the input text and the provided styles.
  ///
  /// Parameters:
  /// - [context]: The build context.
  /// - [style]: The base style for the text.
  /// - [withComposing]: Whether to show composing text (e.g., during typing).
  ///
  /// Returns:
  /// - A `TextSpan` object containing the styled text with highlighted mentions.
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      // Fallback to `normalStyle` if no `style` is provided.
      style: style ?? normalStyle,

      // Generate styled children using the highlight helper.
      children: HighlightHelper.highlightText(
        text, // Current text in the controller.
        normalStyle: normalStyle,
        highlightedStyle: highlightedStyle,
        specialStyle: specialStyle,
        mentionableNames: mentionableNames,
        currentUsername: currentUsername,
        allPattern: allPattern,
      ),
    );
  }
}
