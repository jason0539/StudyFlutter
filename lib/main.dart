import 'package:flutter/material.dart';
import 'package:flutter_app/battery.dart';
import 'package:flutter_app/douban/douban.dart';
import 'package:flutter_app/increment.dart';
import 'package:flutter_app/random/random.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primaryColor: Colors.red,
        ),
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  final _demoEntrance = <String>["Random", "Douban", "Increment", "Battery"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new ListView.builder(itemBuilder: (context, i) {
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index < _demoEntrance.length) {
            return new ListTile(
              onTap: () {
                clickLv(context, _demoEntrance[index]);
              },
              title: new Text(_demoEntrance[index]),
            );
          }
        }));
  }
}

void clickLv(BuildContext context, String itemStr) {
  switch (itemStr) {
    case "Random":
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => new RandomWords()));
      break;
    case "Douban":
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new Douban()));
      break;
    case "Increment":
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new InheritedWidgetTestContainer()));
      break;
    case "Battery":
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (context) => new BatteryWidget()));
      break;
  }
}
