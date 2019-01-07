import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class LikedScreen extends StatelessWidget {

  var _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  LikedScreen(this._saved);

  @override
  Widget build(BuildContext context) {
    final titles = _saved.map((pair) {
      return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ));
    });
    final divided =
    ListTile.divideTiles(tiles: titles, context: context).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Saved Suggestions'),
      ),
      body: new ListView(children: divided),
    );
  }
}