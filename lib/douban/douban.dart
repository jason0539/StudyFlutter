import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoubanResponse {
  final int count;
  final int start;

  DoubanResponse({this.count, this.start});

  factory DoubanResponse.fromJson(Map<String, dynamic> json) {
    return new DoubanResponse(
      count: json['count'],
      start: json['start'],
    );
  }
}

Future<DoubanResponse> fetchDouban() async {
  final response = await http
      .get("https://api.douban.com/v2/movie/in_theaters?start=0&count=10");
  final responseJson = json.decode(response.body);
  return DoubanResponse.fromJson(responseJson);
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
                return new Text("${snapshot.data.count}");
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new CircularProgressIndicator();
            }),
      ),
    );
  }
}
