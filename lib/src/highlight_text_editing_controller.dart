import 'package:flutter/widgets.dart';
import 'highlight_helper.dart';

/// A custom TextEditingController that highlights mentions in the text.
class HighlightTextEditingController extends TextEditingController {
  final TextStyle? normalStyle; // Default style for plain text.
  final TextStyle? highlightedStyle; // Style for highlighted mentions.
  final TextStyle? specialStyle; // Style for special mentions.
  final List<String>? mentionableNames; // List of usernames to mention.
  final String? currentUsername; // The current user's username.
  final String? allPattern; // The all user.

  HighlightTextEditingController({
    super.text,
    this.normalStyle,
    this.highlightedStyle,
    this.specialStyle,
    this.mentionableNames,
    this.currentUsername,
    this.allPattern,
  });

  /// Builds a styled text span with highlighted mentions.
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      style: style ?? normalStyle,
      children: HighlightHelper.highlightText(
        text,
        normalStyle: normalStyle,
        highlightedStyle: highlightedStyle,
        specialStyle: specialStyle,
        mentionableNames: mentionableNames,
        currentUsername: currentUsername,
        allPattern: allPattern
      ),
    );
  }
}