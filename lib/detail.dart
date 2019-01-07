import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final imgUrl =
      "http://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/10dfa9ec8a13632796c4c1dd908fa0ec08fac737.jpg";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Images"),
        ),
        body: new ListView(
          children: <Widget>[
            new Image.asset(
              'images/king_of_ocean_thief.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.fill,
            ),
            Builder(
                builder: (context) => new InkWell(
                      onTap: () {
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: new Text('Tap')));
                      },
                      child: new Container(
                        padding: new EdgeInsets.all(12.0),
                        child: new Image.network(imgUrl),
                      ),
                    ))
          ],
        ));
  }
}
