import 'package:flutter/widgets.dart';
import 'highlight_helper.dart';

/// A widget that displays highlighted mentions within a given text.
class HighlightedText extends StatelessWidget {
  final String input;
  final TextStyle? normalStyle;
  final TextStyle? highlightedStyle;
  final TextStyle? specialStyle;
  final List<String>? mentionableNames;
  final String? currentUsername;
  final String? allPattern;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

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
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        children: HighlightHelper.highlightText(
          input,
          normalStyle: normalStyle,
          highlightedStyle: highlightedStyle,
          specialStyle: specialStyle,
          mentionableNames: mentionableNames,
          currentUsername: currentUsername,
          allPattern: allPattern
        ),
      ),
    );
  }
}