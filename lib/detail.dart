import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Images"),
        ),
        body: new Image.network(
            'http://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/10dfa9ec8a13632796c4c1dd908fa0ec08fac737.jpg'),
      );
  }
}
