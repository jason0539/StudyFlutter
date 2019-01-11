import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/douban/doubanresponse.dart';
import 'package:http/http.dart' as http;


Future<DoubanResponse> fetchDouban() async {
  final response = await http
      .get("https://api.douban.com/v2/movie/in_theaters?start=0&count=10");
  Map<String,dynamic> responseMap = json.decode(response.body);
  return DoubanResponse.fromJson(responseMap);
}

class Douban extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DouBan"),
      ),
      body: new Center(
        child: new FutureBuilder<DoubanResponse>(
            future: fetchDouban(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Text("${snapshot.data.total}");
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new CircularProgressIndicator();
            }),
      ),
    );
  }
}
