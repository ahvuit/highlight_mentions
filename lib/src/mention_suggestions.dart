import 'package:flutter/material.dart';

/// A callback function type to handle the mention tap event.
/// [username] is the mentioned name selected by the user.
typedef OnTapMention = void Function(String username);

/// A widget to display a list of mentionable names in a customizable container.
class MentionSuggestions extends StatelessWidget {
  /// Controls whether the suggestions container is shown or hidden.
  final bool isShow;

  /// A list of names that can be mentioned.
  final List<String> mentionableNames;

  /// Callback triggered when a mentionable name is tapped.
  final OnTapMention? onTapMention;

  /// Customizable decoration for the container, including color, border, and shadow.
  final BoxDecoration? decoration;

  /// Customizable constraints for the container's size.
  final BoxConstraints? constraints;

  /// Customizable padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// Optional widget to display as a leading icon or widget in each list item.
  final Widget? itemLeading;

  /// Optional widget to display as a trailing icon or widget in each list item.
  final Widget? itemTrailing;

  /// Constructor to initialize the MentionSuggestions widget.
  const MentionSuggestions({
    super.key,
    required this.isShow,
    required this.mentionableNames,
    required this.onTapMention,
    this.decoration,
    this.constraints,
    this.padding,
    this.itemLeading,
    this.itemTrailing,
  });

  @override
  Widget build(BuildContext context) {
    // If the widget is not set to be shown, return an empty box.
    if (!isShow) return const SizedBox.shrink();

    return Container(
      // Apply constraints or use the default maximum height.
      constraints: constraints ?? const BoxConstraints(maxHeight: 180),

      // Apply padding or use the default padding value.
      padding: padding ?? const EdgeInsets.all(20),

      // Apply decoration or use the default decoration.
      decoration: decoration ??
          const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xffa8d9e0),
                blurRadius: 10.0,
                offset: Offset(0, 0.5),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),

      // Display a scrollable list of mentionable names.
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mentionableNames.length,
        itemBuilder: (context, index) => ListTile(
          // Optional leading widget for each list item.
          leading: itemLeading,

          // Display the mentionable name as the title.
          title: Text(mentionableNames[index]),

          // Optional trailing widget for each list item.
          trailing: itemTrailing,

          // Trigger the onTap callback when a list item is tapped.
          onTap: () {
            onTapMention?.call(mentionableNames[index]);
          },
        ),
      ),
    );
  }
}
