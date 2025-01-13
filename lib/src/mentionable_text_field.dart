import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'highlight_text_editing_controller.dart';
import 'highlighted_text_field.dart';
import 'mention_suggestions.dart';

typedef OnMentionSelected = void Function(String mention);

class MentionableTextField extends StatefulWidget {
  final List<String> mentionableNames;
  final OnMentionSelected onMentionSelected;
  final String? currentUsername;
  final String allPattern;
  final InputDecoration? textFieldDecoration;
  final BoxDecoration? suggestionDecoration;
  final EdgeInsetsGeometry? suggestionPadding;
  final TextStyle? normalStyle;
  final TextStyle? highlightedStyle;
  final TextStyle? specialStyle;
  final EdgeInsets? padding;

  // TextField properties
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
  final InputCounterWidgetBuilder? buildCounter;
  final bool? expands;

  const MentionableTextField({
    super.key,
    required this.mentionableNames,
    required this.onMentionSelected,
    this.currentUsername,
    this.allPattern = 'All',
    this.textFieldDecoration,
    this.suggestionDecoration,
    this.suggestionPadding,
    this.maxLines,
    this.normalStyle,
    this.highlightedStyle,
    this.specialStyle,
    required this.controller,
    this.decoration,
    this.keyboardType,
    this.focusNode,
    this.minLines,
    this.onChanged,
    this.textInputAction,
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
    this.padding,
  });

  @override
  State<MentionableTextField> createState() => _MentionableTextFieldState();
}

class _MentionableTextFieldState extends State<MentionableTextField> {
  late final ValueNotifier<bool> _isShowSuggestions;
  late final ValueNotifier<String> _query;
  late List<String> _combinedMentionableNames;

  @override
  void initState() {
    super.initState();
    _initializeMentionableNames();
    _initializeNotifiers();
    widget.controller.addListener(_onTextFieldChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextFieldChange);
    widget.controller.dispose();
    _isShowSuggestions.dispose();
    _query.dispose();
    super.dispose();
  }

  void _initializeMentionableNames() {
    _combinedMentionableNames = List.of(widget.mentionableNames);

    if (_isNonEmpty(widget.currentUsername) &&
        !_combinedMentionableNames.contains(widget.currentUsername)) {
      _combinedMentionableNames.insert(0, widget.currentUsername!);
    }

    if (_isNonEmpty(widget.allPattern) &&
        !_combinedMentionableNames.contains(widget.allPattern)) {
      _combinedMentionableNames.insert(0, widget.allPattern);
    }
  }

  void _initializeNotifiers() {
    _isShowSuggestions = ValueNotifier(false);
    _query = ValueNotifier('');
  }

  bool _isNonEmpty(String? value) => value?.isNotEmpty == true;

  void _onTextFieldChange() {
    final text = widget.controller.text;
    final cursorPos = widget.controller.selection.baseOffset;

    if (cursorPos <= 0 || text.isEmpty) {
      _resetSuggestions();
      return;
    }

    final triggerIndex = text.lastIndexOf('@', cursorPos - 1);
    if (triggerIndex != -1) {
      _processQuery(text, cursorPos, triggerIndex);
    } else {
      _resetSuggestions();
    }
  }

  void _resetSuggestions() {
    _isShowSuggestions.value = false;
    _query.value = '';
  }

  void _processQuery(String text, int cursorPos, int triggerIndex) {
    final query = cursorPos > triggerIndex + 1
        ? text.substring(triggerIndex + 1, cursorPos)
        : '';

    if (query.contains(RegExp(r'\s'))) {
      _resetSuggestions();
    } else {
      _query.value = query;
      _isShowSuggestions.value = !_combinedMentionableNames.contains(query);
    }
  }

  void _handleMentionTap(String mention) {
    final text = widget.controller.text;
    final cursorPos = widget.controller.selection.baseOffset;
    final triggerIndex = text.lastIndexOf('@', cursorPos - 1);

    if (triggerIndex != -1) {
      final updatedText = text.replaceRange(
        triggerIndex,
        cursorPos,
        '@$mention ',
      );
      widget.controller.value = TextEditingValue(
        text: updatedText,
        selection:
            TextSelection.collapsed(offset: triggerIndex + mention.length + 2),
      );
    }

    _resetSuggestions();
    widget.onMentionSelected(mention);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isShowSuggestions,
          builder: (context, isShow, child) {
            if (!isShow) return const SizedBox.shrink();
            return ValueListenableBuilder<String>(
              valueListenable: _query,
              builder: (context, query, child) {
                final filteredMentions = query.isEmpty
                    ? _combinedMentionableNames
                    : _combinedMentionableNames
                        .where((name) =>
                            name.toLowerCase().contains(query.toLowerCase()))
                        .toList();

                return filteredMentions.isEmpty
                    ? const SizedBox.shrink()
                    : MentionSuggestions(
                        isShow: isShow,
                        mentionableNames: filteredMentions,
                        onTapMention: _handleMentionTap,
                        decoration: widget.suggestionDecoration,
                        padding: widget.suggestionPadding,
                      );
              },
            );
          },
        ),
        if (widget.padding != null) Padding(padding: widget.padding!),
        HighlightedTextField(
          controller: widget.controller,
          decoration: widget.textFieldDecoration ??
              const InputDecoration(hintText: 'Type something...'),
          maxLines: widget.maxLines ?? 1,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.cursorColor,
          autofocus: widget.autofocus ?? false,
          obscureText: widget.obscureText ?? false,
          enabled: widget.enabled ?? true,
          textAlign: widget.textAlign ?? TextAlign.start,
          textAlignVertical: widget.textAlignVertical,
          cursorWidth: widget.cursorWidth ?? 2.0,
          cursorRadius: widget.cursorRadius,
          enableSuggestions: widget.enableSuggestions ?? true,
          autocorrect: widget.autocorrect ?? true,
          scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
          showCursor: widget.showCursor,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          scrollPhysics: widget.scrollPhysics,
          keyboardAppearance: widget.keyboardAppearance,
          buildCounter: widget.buildCounter,
          expands: widget.expands ?? false,
        ),
      ],
    );
  }
}
