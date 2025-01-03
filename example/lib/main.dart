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
  _HighlightTextScreenState createState() => _HighlightTextScreenState();
}

class _HighlightTextScreenState extends State<HighlightTextScreen> {
  final List<String> mentionableNames = ['alice', 'bob', 'sss'];
  final String _currentUsername = 'john';
  late HighlightTextEditingController _controller;

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
            HighlightedTextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
