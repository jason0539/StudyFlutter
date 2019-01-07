import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final imgUrl =
      "http://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/10dfa9ec8a13632796c4c1dd908fa0ec08fac737.jpg";
  final detailText =
      "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.";

  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new Text(
                  'Oeschinen Lake Campground',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Text(
                'Kandersteg, Switzerland',
                style: new TextStyle(color: Colors.grey[500]),
              )
            ],
          )),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41'),
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            icon,
            color: color,
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ),
          )
        ],
      );
    }

    Widget buttonSection = new Container(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildButtonColumn(Icons.call, 'CALL'),
        buildButtonColumn(Icons.near_me, 'ROUTE'),
        buildButtonColumn(Icons.share, 'SHARE')
      ],
    ));

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        detailText,
        softWrap: true,
      ),
    );

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
            titleSection,
            buttonSection,
            textSection,
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
