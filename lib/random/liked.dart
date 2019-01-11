import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/detail.dart';

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
        ),
        onTap:(){
          toDetail(context);
        });
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

  void toDetail(BuildContext context){
    Navigator.push(context,new MaterialPageRoute(builder: (context) => new Detail()));
  }
}