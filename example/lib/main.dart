import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:highlight_mentions/highlight_mentions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HighlightTextScreen(),
    );
  }
}

class HighlightTextScreen extends StatefulWidget {
  const HighlightTextScreen({super.key});

  @override
  State<HighlightTextScreen> createState() => _HighlightTextScreenState();
}

class _HighlightTextScreenState extends State<HighlightTextScreen> {
  final String _currentUsername = 'john';
  late List<String> mentionableNames = ['alice', 'bob', 'sss'];
  late HighlightTextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  String text = '';

  @override
  void initState() {
    super.initState();
    _controller = HighlightTextEditingController(
      mentionableNames: mentionableNames,
      currentUsername: _currentUsername,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Highlight Mentions')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HighlightedText(
                input: text,
                mentionableNames: mentionableNames,
                currentUsername: _currentUsername),
            SizedBox(
              height: 20,
            ),
            // HighlightedTextField(
            //     controller: _controller,
            //     onChanged: (value) {
            //       setState(() {
            //         text = value;
            //       });
            //     }),
            SizedBox(
              height: 20,
            ),
            MentionableTextField(
              focusNode: _focusNode,
              currentUsername: _currentUsername,
              mentionableNames: mentionableNames,
              onMentionSelected: (mention) {
                if (kDebugMode) {
                  print('Mention selected: $mention');
                }
              },
              textFieldDecoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type @ to mention...',
              ),
              suggestionDecoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
