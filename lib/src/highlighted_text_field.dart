import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'highlight_text_editing_controller.dart';

/// A TextField widget that highlights mentions as the user types.
typedef OnTypingCallback = void Function(String value);

class HighlightedTextField extends StatelessWidget {
  final HighlightTextEditingController controller;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final OnTypingCallback? onChanged;
  final TextInputAction? textInputAction;
  final Color? cursorColor;
  final bool? autofocus;
  final bool? obscureText;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final EdgeInsets? scrollPadding;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final ScrollPhysics? scrollPhysics;
  final Brightness? keyboardAppearance;
  final EdgeInsets? padding;
  final InputCounterWidgetBuilder? buildCounter;
  final bool? expands;
  final OverlayVisibilityMode? clearButtonMode;

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
    this.padding,
    this.buildCounter,
    this.expands,
    this.clearButtonMode,
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
