import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'highlight_text_editing_controller.dart';

/// A `TextField` widget that supports real-time mention highlighting as the user types.
///
/// This widget uses a `HighlightTextEditingController` to handle the dynamic styling
/// of mentions and patterns in the text. It also provides a wide range of customizable
/// properties to control the behavior and appearance of the text field.
///
/// Example usage:
/// ```dart
/// HighlightedTextField(
///   controller: HighlightTextEditingController(
///     normalStyle: TextStyle(color: Colors.black),
///     highlightedStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
///     specialStyle: TextStyle(color: Colors.green),
///     mentionableNames: ['Alice', 'Bob'],
///   ),
///   decoration: InputDecoration(
///     hintText: 'Type a message...',
///     border: OutlineInputBorder(),
///   ),
///   onChanged: (value) => print('User typed: $value'),
/// );
/// ```
typedef OnTypingCallback = void Function(String value);

class HighlightedTextField extends StatelessWidget {
  /// The controller that manages the text and applies highlighting.
  final HighlightTextEditingController controller;

  /// Decoration for the `TextField`, such as borders and hint text.
  final InputDecoration? decoration;

  /// The type of keyboard to use for the text field (e.g., email, number).
  final TextInputType? keyboardType;

  /// Controls the focus of the text field.
  final FocusNode? focusNode;

  /// The minimum number of lines for the text field.
  final int? minLines;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// Callback triggered when the text changes.
  final OnTypingCallback? onChanged;

  /// The action button to display on the keyboard (e.g., "done", "next").
  final TextInputAction? textInputAction;

  /// The color of the cursor.
  final Color? cursorColor;

  /// Whether the text field should focus automatically.
  final bool? autofocus;

  /// Whether the text should be obscured (e.g., for passwords).
  final bool? obscureText;

  /// Whether the text field is enabled or disabled.
  final bool? enabled;

  /// Alignment of the text within the text field.
  final TextAlign? textAlign;

  /// Vertical alignment of the text field content.
  final TextAlignVertical? textAlignVertical;

  /// The width of the cursor.
  final double? cursorWidth;

  /// The radius of the cursor corners.
  final Radius? cursorRadius;

  /// Whether to enable text suggestions.
  final bool? enableSuggestions;

  /// Whether to enable auto-correct for the text field.
  final bool? autocorrect;

  /// Padding around the text field when scrolling.
  final EdgeInsets? scrollPadding;

  /// Whether to show the cursor even when the text field is not focused.
  final bool? showCursor;

  /// The maximum number of characters allowed in the text field.
  final int? maxLength;

  /// Enforcement behavior for `maxLength`.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Callback triggered when the text field is tapped.
  final GestureTapCallback? onTap;

  /// Callback triggered when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Callback triggered when the user submits the text.
  final ValueChanged<String>? onSubmitted;

  /// The scroll physics for the text field.
  final ScrollPhysics? scrollPhysics;

  /// The appearance of the keyboard (e.g., dark, light).
  final Brightness? keyboardAppearance;

  /// Custom counter widget builder for the text field.
  final InputCounterWidgetBuilder? buildCounter;

  /// Whether the text field expands to fill available space.
  final bool? expands;

  /// Constructor for the `HighlightedTextField`.
  const HighlightedTextField({
    super.key,
    required this.controller,
    this.decoration,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.cursorColor,
    this.autofocus,
    this.obscureText,
    this.enabled,
    this.textAlign,
    this.textAlignVertical,
    this.cursorWidth,
    this.cursorRadius,
    this.enableSuggestions,
    this.autocorrect,
    this.scrollPadding,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onTap,
    this.onEditingComplete,
    this.onSubmitted,
    this.scrollPhysics,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      decoration:
      decoration ?? const InputDecoration(border: OutlineInputBorder()),
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      enabled: enabled ?? true,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical,
      cursorWidth: cursorWidth ?? 2.0,
      cursorRadius: cursorRadius,
      enableSuggestions: enableSuggestions ?? true,
      autocorrect: autocorrect ?? true,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      showCursor: showCursor,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      scrollPhysics: scrollPhysics,
      keyboardAppearance: keyboardAppearance,
      buildCounter: buildCounter,
      expands: expands ?? false,
    );
  }
}