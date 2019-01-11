import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/douban/doubanresponse.dart';
import 'package:http/http.dart' as http;

class Douban extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DoubanState();
  }
}

class DoubanState extends State<Douban> {
  DoubanResponse _doubanResponse = null;

  void fetchDouban() async {
    final response = await http
        .get("https://api.douban.com/v2/movie/in_theaters?start=0&count=15");
    Map<String, dynamic> responseMap = json.decode(response.body);
    print(responseMap);
    if (responseMap.containsKey('code') && responseMap['code'] != 200) {
      String msg = responseMap['msg'];
      print(msg);
    }else{
      setState(() {
        _doubanResponse = DoubanResponse.fromJson(responseMap);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDouban();
  }

  @override
  Widget build(BuildContext context) {
    Widget loading = new CircularProgressIndicator();
    Widget content = new RefreshIndicator(
        child: new ListView.builder(
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return new Divider();
            }
            if (_doubanResponse == null) {
              return new CircularProgressIndicator();
            }
            final movies = _doubanResponse.movies;
            final index = i ~/ 2;
            if (index < movies.length) {
              return new Row(
                children: <Widget>[
                  new Image.network(
                    movies[index].images.small,
                    height: 80,
                  ),
                  new Text(movies[index].title)
                ],
              );
            }
          },
          physics: const AlwaysScrollableScrollPhysics(),
//                      itemCount: movies.length,
        ),
        onRefresh: () {
          fetchDouban();
        });
    Widget body = _doubanResponse == null ? loading : content;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DouBan"),
      ),
      body: new Center(
        child: body,
      ),
    );
  }
}
